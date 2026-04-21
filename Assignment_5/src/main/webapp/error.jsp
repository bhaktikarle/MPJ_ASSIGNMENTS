<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page isErrorPage="true" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Error - Employee Registration System</title>
    <link rel="stylesheet" href="css/style.css">
    <style>
        .error-container {
            text-align: center;
            padding: 4rem 2rem;
        }
        .error-icon {
            font-size: 4rem;
            color: #dc3545;
            margin-bottom: 1rem;
        }
        .error-title {
            font-size: 2.5rem;
            color: #333;
            margin-bottom: 1rem;
        }
        .error-message {
            font-size: 1.2rem;
            color: #666;
            margin-bottom: 2rem;
            max-width: 600px;
            margin-left: auto;
            margin-right: auto;
        }
        .error-details {
            background: #f8f9fa;
            padding: 1rem;
            border-radius: 8px;
            margin: 2rem auto;
            max-width: 600px;
            text-align: left;
            font-family: monospace;
            font-size: 0.9rem;
        }
        .back-button {
            display: inline-block;
            margin-top: 2rem;
        }
    </style>
</head>
<body>
    <div class="container">
        <header>
            <h1>Employee Registration System</h1>
            <nav>
                <ul>
                    <li><a href="EmployeeListServlet">View Employees</a></li>
                    <li><a href="EmployeeRegistrationServlet">Register Employee</a></li>
                </ul>
            </nav>
        </header>

        <main>
            <section class="error-container">
                <div class="error-icon">!</div>
                <h2 class="error-title">Oops! Something went wrong</h2>
                
                <% 
                    String errorMessage = (String) request.getAttribute("errorMessage");
                    if (errorMessage == null) {
                        errorMessage = "An unexpected error occurred while processing your request.";
                    }
                %>
                
                <p class="error-message"><%= errorMessage %></p>
                
                <% if (exception != null) { %>
                    <div class="error-details">
                        <strong>Error Details:</strong><br>
                        <%= exception.getMessage() %>
                        <% if (exception.getCause() != null) { %>
                            <br><strong>Cause:</strong><br>
                            <%= exception.getCause().getMessage() %>
                        <% } %>
                    </div>
                <% } %>
                
                <div class="back-button">
                    <a href="index.jsp" class="btn btn-primary">Back to Home</a>
                    <a href="EmployeeListServlet" class="btn btn-secondary">View Employees</a>
                </div>
            </section>
        </main>

        <footer>
            <p>&copy; 2024 Employee Registration System. All rights reserved.</p>
        </footer>
    </div>
</body>
</html>
