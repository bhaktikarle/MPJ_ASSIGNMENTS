package com.employee.controller;

import com.employee.dao.EmployeeDAO;
import com.employee.model.Employee;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

/**
 * Servlet for displaying the list of all employees
 * Handles GET requests to show all registered employees
 */
@WebServlet("/EmployeeListServlet")
public class EmployeeListServlet extends HttpServlet {
    
    private static final long serialVersionUID = 1L;
    private EmployeeDAO employeeDAO;
    
    @Override
    public void init() throws ServletException {
        employeeDAO = new EmployeeDAO();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        try {
            // Get all employees from database
            List<Employee> employees = employeeDAO.getAllEmployees();
            
            // Get employee count
            int employeeCount = employeeDAO.getEmployeeCount();
            
            // Set attributes for JSP
            request.setAttribute("employees", employees);
            request.setAttribute("employeeCount", employeeCount);
            
            // Check for success message from registration
            String successMessage = (String) request.getSession().getAttribute("successMessage");
            if (successMessage != null) {
                request.setAttribute("successMessage", successMessage);
                request.getSession().removeAttribute("successMessage"); // Remove after displaying
            }
            
            // Forward to employee list JSP
            request.getRequestDispatcher("/employee-list.jsp").forward(request, response);
            
        } catch (Exception e) {
            System.err.println("Error in EmployeeListServlet: " + e.getMessage());
            e.printStackTrace();
            
            // Set error message and forward to error page
            request.setAttribute("errorMessage", "Unable to load employee list: " + e.getMessage());
            request.getRequestDispatcher("/error.jsp").forward(request, response);
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // For simplicity, handle POST the same as GET
        doGet(request, response);
    }
}
