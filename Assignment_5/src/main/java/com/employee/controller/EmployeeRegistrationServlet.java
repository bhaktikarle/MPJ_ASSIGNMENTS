package com.employee.controller;

import com.employee.dao.EmployeeDAO;
import com.employee.model.Employee;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.time.format.DateTimeParseException;
import java.util.ArrayList;
import java.util.List;

/**
 * Servlet for handling employee registration operations
 * Handles both GET (display form) and POST (process registration) requests
 */
@WebServlet("/EmployeeRegistrationServlet")
public class EmployeeRegistrationServlet extends HttpServlet {
    
    private static final long serialVersionUID = 1L;
    private EmployeeDAO employeeDAO;
    
    @Override
    public void init() throws ServletException {
        employeeDAO = new EmployeeDAO();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Forward to the registration form
        request.getRequestDispatcher("/register-employee.jsp").forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Set request encoding to handle form data properly
        request.setCharacterEncoding("UTF-8");
        
        List<String> errors = new ArrayList<>();
        Employee employee = new Employee();
        
        try {
            // Get form parameters and perform validation
            String firstName = request.getParameter("firstName");
            String lastName = request.getParameter("lastName");
            String email = request.getParameter("email");
            String phone = request.getParameter("phone");
            String department = request.getParameter("department");
            String position = request.getParameter("position");
            String salaryStr = request.getParameter("salary");
            String hireDateStr = request.getParameter("hireDate");
            String address = request.getParameter("address");
            
            // Validate First Name
            if (firstName == null || firstName.trim().isEmpty()) {
                errors.add("First name is required");
            } else if (firstName.length() > 50) {
                errors.add("First name must be less than 50 characters");
            } else {
                employee.setFirstName(firstName.trim());
            }
            
            // Validate Last Name
            if (lastName == null || lastName.trim().isEmpty()) {
                errors.add("Last name is required");
            } else if (lastName.length() > 50) {
                errors.add("Last name must be less than 50 characters");
            } else {
                employee.setLastName(lastName.trim());
            }
            
            // Validate Email
            if (email == null || email.trim().isEmpty()) {
                errors.add("Email is required");
            } else if (!isValidEmail(email)) {
                errors.add("Invalid email format");
            } else if (email.length() > 100) {
                errors.add("Email must be less than 100 characters");
            } else {
                // Check if email already exists
                Employee existingEmployee = employeeDAO.getEmployeeByEmail(email.trim());
                if (existingEmployee != null) {
                    errors.add("Email already exists in the system");
                } else {
                    employee.setEmail(email.trim());
                }
            }
            
            // Validate Phone
            if (phone == null || phone.trim().isEmpty()) {
                errors.add("Phone number is required");
            } else if (!isValidPhone(phone)) {
                errors.add("Invalid phone number format");
            } else {
                employee.setPhone(phone.trim());
            }
            
            // Validate Department
            if (department == null || department.trim().isEmpty()) {
                errors.add("Department is required");
            } else {
                employee.setDepartment(department.trim());
            }
            
            // Validate Position
            if (position == null || position.trim().isEmpty()) {
                errors.add("Position is required");
            } else {
                employee.setPosition(position.trim());
            }
            
            // Validate Salary
            if (salaryStr == null || salaryStr.trim().isEmpty()) {
                errors.add("Salary is required");
            } else {
                try {
                    BigDecimal salary = new BigDecimal(salaryStr.trim());
                    if (salary.compareTo(BigDecimal.ZERO) < 0) {
                        errors.add("Salary cannot be negative");
                    } else if (salary.compareTo(new BigDecimal("999999999.99")) > 0) {
                        errors.add("Salary is too large");
                    } else {
                        employee.setSalary(salary);
                    }
                } catch (NumberFormatException e) {
                    errors.add("Invalid salary format");
                }
            }
            
            // Validate Hire Date
            if (hireDateStr == null || hireDateStr.trim().isEmpty()) {
                errors.add("Hire date is required");
            } else {
                try {
                    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
                    LocalDate hireDate = LocalDate.parse(hireDateStr.trim(), formatter);
                    
                    // Check if hire date is not in the future
                    if (hireDate.isAfter(LocalDate.now())) {
                        errors.add("Hire date cannot be in the future");
                    } else {
                        employee.setHireDate(hireDate);
                    }
                } catch (DateTimeParseException e) {
                    errors.add("Invalid hire date format. Please use YYYY-MM-DD format");
                }
            }
            
            // Validate Address (optional)
            if (address != null && !address.trim().isEmpty()) {
                if (address.length() > 500) {
                    errors.add("Address must be less than 500 characters");
                } else {
                    employee.setAddress(address.trim());
                }
            }
            
            // If there are validation errors, return to form with error messages
            if (!errors.isEmpty()) {
                request.setAttribute("errors", errors);
                request.setAttribute("employee", employee);
                request.getRequestDispatcher("/register-employee.jsp").forward(request, response);
                return;
            }
            
            // If validation passes, save the employee
            boolean success = employeeDAO.addEmployee(employee);
            
            if (success) {
                // Set success message and redirect to employee list
                request.getSession().setAttribute("successMessage", 
                    "Employee " + employee.getFullName() + " has been successfully registered!");
                response.sendRedirect("EmployeeListServlet");
            } else {
                errors.add("Failed to register employee. Please try again.");
                request.setAttribute("errors", errors);
                request.setAttribute("employee", employee);
                request.getRequestDispatcher("/register-employee.jsp").forward(request, response);
            }
            
        } catch (Exception e) {
            errors.add("An unexpected error occurred: " + e.getMessage());
            request.setAttribute("errors", errors);
            request.setAttribute("employee", employee);
            request.getRequestDispatcher("/register-employee.jsp").forward(request, response);
        }
    }
    
    /**
     * Validate email format using simple regex
     * @param email Email string to validate
     * @return true if valid, false otherwise
     */
    private boolean isValidEmail(String email) {
        String emailRegex = "^[a-zA-Z0-9_+&*-]+(?:\\.[a-zA-Z0-9_+&*-]+)*@(?:[a-zA-Z0-9-]+\\.)+[a-zA-Z]{2,7}$";
        return email.trim().matches(emailRegex);
    }
    
    /**
     * Validate phone number format
     * @param phone Phone string to validate
     * @return true if valid, false otherwise
     */
    private boolean isValidPhone(String phone) {
        // Accept formats: 123-456-7890, (123) 456-7890, 1234567890, etc.
        String phoneRegex = "^(\\+\\d{1,3}[- ]?)?\\(?\\d{3}\\)?[- ]?\\d{3}[- ]?\\d{4}$";
        return phone.trim().matches(phoneRegex);
    }
}
