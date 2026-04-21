<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.employee.model.Employee" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Employee Registration</title>
    <link rel="stylesheet" href="css/style.css">
    <style>
        .form-group {
            margin-bottom: 15px;
        }
        .form-group label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
        }
        .form-group input, .form-group select, .form-group textarea {
            width: 100%;
            padding: 8px;
            border: 1px solid #ddd;
            border-radius: 4px;
            font-size: 14px;
        }
        .form-group textarea {
            height: 80px;
            resize: vertical;
        }
        .required {
            color: red;
        }
        .error-messages {
            background-color: #f8d7da;
            color: #721c24;
            padding: 10px;
            border-radius: 4px;
            margin-bottom: 20px;
        }
        .error-messages ul {
            margin: 0;
            padding-left: 20px;
        }
        .form-row {
            display: flex;
            gap: 20px;
        }
        .form-row .form-group {
            flex: 1;
        }
        .btn-container {
            display: flex;
            gap: 10px;
            margin-top: 20px;
        }
        .btn-secondary {
            background-color: #6c757d;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            text-decoration: none;
            display: inline-block;
        }
        .btn-secondary:hover {
            background-color: #5a6268;
        }
    </style>
</head>
<body>
    <div class="container">
        <header>
            <h1>Employee Registration System</h1>
            <nav>
                <ul>
                    <li><a href="EmployeeListServlet" class="active">View Employees</a></li>
                    <li><a href="EmployeeRegistrationServlet" class="active">Register Employee</a></li>
                </ul>
            </nav>
        </header>

        <main>
            <section class="form-section">
                <h2>Register New Employee</h2>
                <p>Please fill in the employee details below. Fields marked with <span class="required">*</span> are required.</p>
                
                <%-- Display error messages if any --%>
                <% List<String> errors = (List<String>) request.getAttribute("errors"); %>
                <% if (errors != null && !errors.isEmpty()) { %>
                    <div class="error-messages">
                        <h4>Please correct the following errors:</h4>
                        <ul>
                            <% for (String error : errors) { %>
                                <li><%= error %></li>
                            <% } %>
                        </ul>
                    </div>
                <% } %>

                <form action="EmployeeRegistrationServlet" method="post" class="employee-form">
                    <%-- Get employee object if form is being redisplayed with errors --%>
                    <% Employee employee = (Employee) request.getAttribute("employee"); %>
                    
                    <div class="form-row">
                        <div class="form-group">
                            <label for="firstName">First Name <span class="required">*</span></label>
                            <input type="text" id="firstName" name="firstName" 
                                   value="<%= employee != null && employee.getFirstName() != null ? employee.getFirstName() : "" %>"
                                   required maxlength="50" placeholder="Enter first name">
                        </div>
                        
                        <div class="form-group">
                            <label for="lastName">Last Name <span class="required">*</span></label>
                            <input type="text" id="lastName" name="lastName" 
                                   value="<%= employee != null && employee.getLastName() != null ? employee.getLastName() : "" %>"
                                   required maxlength="50" placeholder="Enter last name">
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="email">Email <span class="required">*</span></label>
                        <input type="email" id="email" name="email" 
                               value="<%= employee != null && employee.getEmail() != null ? employee.getEmail() : "" %>"
                               required maxlength="100" placeholder="employee@example.com">
                    </div>

                    <div class="form-group">
                        <label for="phone">Phone Number <span class="required">*</span></label>
                        <input type="tel" id="phone" name="phone" 
                               value="<%= employee != null && employee.getPhone() != null ? employee.getPhone() : "" %>"
                               required placeholder="123-456-7890 or (123) 456-7890">
                    </div>

                    <div class="form-row">
                        <div class="form-group">
                            <label for="department">Department <span class="required">*</span></label>
                            <select id="department" name="department" required>
                                <option value="">Select Department</option>
                                <option value="IT" <%= employee != null && "IT".equals(employee.getDepartment()) ? "selected" : "" %>>IT</option>
                                <option value="HR" <%= employee != null && "HR".equals(employee.getDepartment()) ? "selected" : "" %>>HR</option>
                                <option value="Finance" <%= employee != null && "Finance".equals(employee.getDepartment()) ? "selected" : "" %>>Finance</option>
                                <option value="Marketing" <%= employee != null && "Marketing".equals(employee.getDepartment()) ? "selected" : "" %>>Marketing</option>
                                <option value="Sales" <%= employee != null && "Sales".equals(employee.getDepartment()) ? "selected" : "" %>>Sales</option>
                                <option value="Operations" <%= employee != null && "Operations".equals(employee.getDepartment()) ? "selected" : "" %>>Operations</option>
                                <option value="Administration" <%= employee != null && "Administration".equals(employee.getDepartment()) ? "selected" : "" %>>Administration</option>
                            </select>
                        </div>
                        
                        <div class="form-group">
                            <label for="position">Position <span class="required">*</span></label>
                            <input type="text" id="position" name="position" 
                                   value="<%= employee != null && employee.getPosition() != null ? employee.getPosition() : "" %>"
                                   required maxlength="50" placeholder="e.g., Software Developer">
                        </div>
                    </div>

                    <div class="form-row">
                        <div class="form-group">
                            <label for="salary">Salary <span class="required">*</span></label>
                            <input type="number" id="salary" name="salary" 
                                   value="<%= employee != null && employee.getSalary() != null ? employee.getSalary() : "" %>"
                                   required min="0" step="0.01" placeholder="50000.00">
                        </div>
                        
                        <div class="form-group">
                            <label for="hireDate">Hire Date <span class="required">*</span></label>
                            <input type="date" id="hireDate" name="hireDate" 
                                   value="<%= employee != null && employee.getHireDate() != null ? employee.getHireDate() : "" %>"
                                   required>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="address">Address</label>
                        <textarea id="address" name="address" 
                                  placeholder="Enter complete address (optional)"><%= employee != null && employee.getAddress() != null ? employee.getAddress() : "" %></textarea>
                    </div>

                    <div class="btn-container">
                        <button type="submit" class="btn btn-primary">Register Employee</button>
                        <a href="EmployeeListServlet" class="btn btn-secondary">Cancel</a>
                    </div>
                </form>
            </section>
        </main>

        <footer>
            <p>&copy; 2024 Employee Registration System. All rights reserved.</p>
        </footer>
    </div>

    <script>
        // Set today's date as max for hire date
        document.addEventListener('DOMContentLoaded', function() {
            const hireDateInput = document.getElementById('hireDate');
            const today = new Date().toISOString().split('T')[0];
            hireDateInput.setAttribute('max', today);
        });
    </script>
</body>
</html>
