<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.employee.model.Employee" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Employee List</title>
    <link rel="stylesheet" href="css/style.css">
    <style>
        .employee-table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        .employee-table th,
        .employee-table td {
            padding: 12px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }
        .employee-table th {
            background-color: #f8f9fa;
            font-weight: bold;
            color: #333;
        }
        .employee-table tr:hover {
            background-color: #f5f5f5;
        }
        .employee-info {
            margin-bottom: 5px;
        }
        .employee-name {
            font-weight: bold;
            color: #007bff;
        }
        .employee-email {
            color: #6c757d;
            font-size: 0.9em;
        }
        .employee-phone {
            color: #6c757d;
            font-size: 0.9em;
        }
        .department-badge {
            background-color: #007bff;
            color: white;
            padding: 4px 8px;
            border-radius: 12px;
            font-size: 0.8em;
            display: inline-block;
        }
        .salary {
            font-weight: bold;
            color: #28a745;
        }
        .success-message {
            background-color: #d4edda;
            color: #155724;
            padding: 15px;
            border-radius: 4px;
            margin-bottom: 20px;
            border: 1px solid #c3e6cb;
        }
        .empty-state {
            text-align: center;
            padding: 40px;
            color: #6c757d;
        }
        .empty-state h3 {
            margin-bottom: 10px;
        }
        .stats-container {
            display: flex;
            gap: 20px;
            margin-bottom: 20px;
        }
        .stat-card {
            background-color: #f8f9fa;
            padding: 20px;
            border-radius: 8px;
            border-left: 4px solid #007bff;
            flex: 1;
        }
        .stat-number {
            font-size: 2em;
            font-weight: bold;
            color: #007bff;
        }
        .stat-label {
            color: #6c757d;
            margin-top: 5px;
        }
        .action-buttons {
            display: flex;
            gap: 10px;
            margin-bottom: 20px;
        }
        @media (max-width: 768px) {
            .employee-table {
                font-size: 0.9em;
            }
            .employee-table th,
            .employee-table td {
                padding: 8px;
            }
            .stats-container {
                flex-direction: column;
            }
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
                    <li><a href="EmployeeRegistrationServlet">Register Employee</a></li>
                </ul>
            </nav>
        </header>

        <main>
            <section class="list-section">
                <h2>Employee List</h2>
                
                <%-- Display success message if any --%>
                <% String successMessage = (String) request.getAttribute("successMessage"); %>
                <% if (successMessage != null && !successMessage.isEmpty()) { %>
                    <div class="success-message">
                        <%= successMessage %>
                    </div>
                <% } %>

                <%-- Statistics --%>
                <% Integer employeeCount = (Integer) request.getAttribute("employeeCount"); %>
                <% if (employeeCount != null) { %>
                    <div class="stats-container">
                        <div class="stat-card">
                            <div class="stat-number"><%= employeeCount %></div>
                            <div class="stat-label">Total Employees</div>
                        </div>
                        <div class="stat-card">
                            <div class="stat-number"><%= employeeCount > 0 ? "Active" : "No Data" %></div>
                            <div class="stat-label">System Status</div>
                        </div>
                    </div>
                <% } %>

                <%-- Action buttons --%>
                <div class="action-buttons">
                    <a href="EmployeeRegistrationServlet" class="btn btn-primary">Register New Employee</a>
                    <button onclick="window.location.reload()" class="btn btn-secondary">Refresh</button>
                </div>

                <%-- Employee list --%>
                <% List<Employee> employees = (List<Employee>) request.getAttribute("employees"); %>
                <% if (employees != null && !employees.isEmpty()) { %>
                    <div class="table-container">
                        <table class="employee-table">
                            <thead>
                                <tr>
                                    <th>Employee Information</th>
                                    <th>Department</th>
                                    <th>Position</th>
                                    <th>Salary</th>
                                    <th>Hire Date</th>
                                </tr>
                            </thead>
                            <tbody>
                                <% for (Employee employee : employees) { %>
                                    <tr>
                                        <td>
                                            <div class="employee-info">
                                                <div class="employee-name"><%= employee.getFullName() %></div>
                                                <div class="employee-email"><%= employee.getEmail() %></div>
                                                <div class="employee-phone"><%= employee.getPhone() %></div>
                                                <% if (employee.getAddress() != null && !employee.getAddress().isEmpty()) { %>
                                                    <div class="employee-address" style="font-size: 0.8em; color: #6c757d;">
                                                        <%= employee.getAddress() %>
                                                    </div>
                                                <% } %>
                                            </div>
                                        </td>
                                        <td>
                                            <span class="department-badge"><%= employee.getDepartment() %></span>
                                        </td>
                                        <td><%= employee.getPosition() %></td>
                                        <td class="salary"><%= employee.getFormattedSalary() %></td>
                                        <td><%= employee.getFormattedHireDate() %></td>
                                    </tr>
                                <% } %>
                            </tbody>
                        </table>
                    </div>
                <% } else { %>
                    <div class="empty-state">
                        <h3>No Employees Found</h3>
                        <p>There are no employees registered in the system yet.</p>
                        <p>
                            <a href="EmployeeRegistrationServlet" class="btn btn-primary">Register First Employee</a>
                        </p>
                    </div>
                <% } %>
            </section>
        </main>

        <footer>
            <p>&copy; 2024 Employee Registration System. All rights reserved.</p>
        </footer>
    </div>

    <script>
        // Auto-hide success message after 5 seconds
        document.addEventListener('DOMContentLoaded', function() {
            const successMessage = document.querySelector('.success-message');
            if (successMessage) {
                setTimeout(function() {
                    successMessage.style.display = 'none';
                }, 5000);
            }
        });

        // Add search functionality (optional enhancement)
        function addSearchFunctionality() {
            const table = document.querySelector('.employee-table');
            if (!table) return;

            const searchInput = document.createElement('input');
            searchInput.type = 'text';
            searchInput.placeholder = 'Search employees...';
            searchInput.className = 'form-control';
            searchInput.style.marginBottom = '20px';
            searchInput.style.width = '300px';

            const section = document.querySelector('.list-section');
            section.insertBefore(searchInput, section.querySelector('.stats-container'));

            searchInput.addEventListener('keyup', function() {
                const filter = searchInput.value.toLowerCase();
                const rows = table.getElementsByTagName('tr');

                for (let i = 1; i < rows.length; i++) {
                    const row = rows[i];
                    const text = row.textContent.toLowerCase();
                    row.style.display = text.includes(filter) ? '' : 'none';
                }
            });
        }

        // Uncomment to enable search functionality
        // addSearchFunctionality();
    </script>
</body>
</html>
