<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.employee.dao.EmployeeDAO" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Employee Registration System</title>
    <link rel="stylesheet" href="css/style.css">
    <style>
        .hero-section {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 4rem 0;
            text-align: center;
            border-radius: 10px;
            margin-bottom: 2rem;
        }
        .hero-section h1 {
            font-size: 3rem;
            margin-bottom: 1rem;
            font-weight: 300;
        }
        .hero-section p {
            font-size: 1.2rem;
            margin-bottom: 2rem;
            opacity: 0.9;
        }
        .features {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 2rem;
            margin-top: 3rem;
        }
        .feature-card {
            background: white;
            padding: 2rem;
            border-radius: 10px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
            text-align: center;
            transition: transform 0.3s ease;
        }
        .feature-card:hover {
            transform: translateY(-5px);
        }
        .feature-icon {
            font-size: 3rem;
            margin-bottom: 1rem;
        }
        .feature-title {
            font-size: 1.5rem;
            margin-bottom: 1rem;
            color: #333;
        }
        .feature-description {
            color: #666;
            line-height: 1.6;
        }
        .cta-buttons {
            display: flex;
            gap: 1rem;
            justify-content: center;
            flex-wrap: wrap;
        }
        .stats-row {
            display: flex;
            justify-content: center;
            gap: 3rem;
            margin: 3rem 0;
            flex-wrap: wrap;
        }
        .stat-item {
            text-align: center;
        }
        .stat-number {
            font-size: 2.5rem;
            font-weight: bold;
            color: #667eea;
        }
        .stat-label {
            color: white;
            opacity: 0.9;
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
            <section class="hero-section">
                <h1>Welcome to Employee Registration System</h1>
                <p>A comprehensive solution for managing employee information with ease and efficiency</p>
                
                <%
                    EmployeeDAO employeeDAO = new EmployeeDAO();
                    int employeeCount = 0;
                    try {
                        employeeCount = employeeDAO.getEmployeeCount();
                    } catch (Exception e) {
                        // Handle database connection error gracefully
                        employeeCount = 0;
                    }
                %>
                
                <div class="stats-row">
                    <div class="stat-item">
                        <div class="stat-number"><%= employeeCount %></div>
                        <div class="stat-label">Total Employees</div>
                    </div>
                    <div class="stat-item">
                        <div class="stat-number"><%= employeeCount > 0 ? "Active" : "Ready" %></div>
                        <div class="stat-label">System Status</div>
                    </div>
                </div>
                
                <div class="cta-buttons">
                    <a href="EmployeeRegistrationServlet" class="btn btn-primary">Register New Employee</a>
                    <a href="EmployeeListServlet" class="btn btn-secondary">View All Employees</a>
                </div>
            </section>

            <section class="features-section">
                <h2 style="text-align: center; margin-bottom: 2rem; color: #333;">Key Features</h2>
                
                <div class="features">
                    <div class="feature-card">
                        <div class="feature-icon">+ Add</div>
                        <h3 class="feature-title">Easy Registration</h3>
                        <p class="feature-description">
                            Simple and intuitive form for registering new employees with comprehensive validation and error handling.
                        </p>
                    </div>
                    
                    <div class="feature-card">
                        <div class="feature-icon">View List</div>
                        <h3 class="feature-title">Employee Management</h3>
                        <p class="feature-description">
                            View all registered employees in an organized table format with sorting and filtering capabilities.
                        </p>
                    </div>
                    
                    <div class="feature-card">
                        <div class="feature-icon">Database</div>
                        <h3 class="feature-title">Secure Storage</h3>
                        <p class="feature-description">
                            Reliable MySQL database integration with proper connection management and data security.
                        </p>
                    </div>
                    
                    <div class="feature-card">
                        <div class="feature-icon">Responsive</div>
                        <h3 class="feature-title">Mobile Friendly</h3>
                        <p class="feature-description">
                            Fully responsive design that works seamlessly across all devices and screen sizes.
                        </p>
                    </div>
                    
                    <div class="feature-card">
                        <div class="feature-icon">Validated</div>
                        <h3 class="feature-title">Data Validation</h3>
                        <p class="feature-description">
                            Comprehensive input validation both on client-side and server-side for data integrity.
                        </p>
                    </div>
                    
                    <div class="feature-card">
                        <div class="feature-icon">Modern UI</div>
                        <h3 class="feature-title">Modern Design</h3>
                        <p class="feature-description">
                            Clean, modern interface with smooth animations and user-friendly navigation.
                        </p>
                    </div>
                </div>
            </section>

            <section class="getting-started">
                <h2 style="text-align: center; margin-bottom: 2rem; color: #333;">Getting Started</h2>
                <div style="background: white; padding: 2rem; border-radius: 10px; box-shadow: 0 4px 15px rgba(0,0,0,0.1);">
                    <div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(250px, 1fr)); gap: 2rem;">
                        <div>
                            <h4 style="color: #667eea; margin-bottom: 1rem;">1. Register Employee</h4>
                            <p style="color: #666;">Click "Register New Employee" to add a new employee to the system. Fill in all required information.</p>
                        </div>
                        <div>
                            <h4 style="color: #667eea; margin-bottom: 1rem;">2. View Employees</h4>
                            <p style="color: #666;">Browse through all registered employees in the employee list with detailed information.</p>
                        </div>
                        <div>
                            <h4 style="color: #667eea; margin-bottom: 1rem;">3. Manage Data</h4>
                            <p style="color: #666;">All data is securely stored in the database with proper validation and error handling.</p>
                        </div>
                    </div>
                </div>
            </section>
        </main>

        <footer>
            <p>&copy; 2024 Employee Registration System. All rights reserved.</p>
        </footer>
    </div>

    <script>
        // Add smooth scrolling for navigation
        document.querySelectorAll('a[href^="#"]').forEach(anchor => {
            anchor.addEventListener('click', function (e) {
                e.preventDefault();
                document.querySelector(this.getAttribute('href')).scrollIntoView({
                    behavior: 'smooth'
                });
            });
        });

        // Add animation to feature cards on scroll
        const observerOptions = {
            threshold: 0.1,
            rootMargin: '0px 0px -50px 0px'
        };

        const observer = new IntersectionObserver(function(entries) {
            entries.forEach(entry => {
                if (entry.isIntersecting) {
                    entry.target.style.opacity = '1';
                    entry.target.style.transform = 'translateY(0)';
                }
            });
        }, observerOptions);

        document.querySelectorAll('.feature-card').forEach(card => {
            card.style.opacity = '0';
            card.style.transform = 'translateY(20px)';
            card.style.transition = 'opacity 0.6s ease, transform 0.6s ease';
            observer.observe(card);
        });
    </script>
</body>
</html>
