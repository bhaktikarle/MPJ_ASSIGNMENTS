# Employee Registration System

A web application for employee registration using JSP, Servlet and JDBC technologies. This application provides a complete solution for managing employee information with a user-friendly interface.

## Features

- **Employee Registration**: Register new employees with comprehensive information
- **Employee List**: View all registered employees in a tabular format
- **Data Validation**: Client-side and server-side validation for all input fields
- **Database Integration**: MySQL database for persistent storage
- **Responsive Design**: Mobile-friendly interface using modern CSS
- **Error Handling**: Comprehensive error handling and user feedback
- **Session Management**: Secure session handling for user interactions

## Technology Stack

- **Frontend**: JSP, HTML5, CSS3, JavaScript
- **Backend**: Java Servlets
- **Database**: MySQL
- **Build Tool**: Maven (optional)
- **Server**: Apache Tomcat 9.0+
- **JDK**: Java 8 or higher

## Project Structure

```
mpj/
|-- src/
|   |-- main/
|   |   |-- java/
|   |   |   |-- com/
|   |   |   |   |-- employee/
|   |   |   |   |   |-- controller/     # Servlet classes
|   |   |   |   |   |-- dao/           # Data Access Objects
|   |   |   |   |   |-- model/         # Model/Bean classes
|   |   |   |   |   |-- util/          # Utility classes
|   |   |-- webapp/
|   |   |   |-- WEB-INF/
|   |   |   |   |-- web.xml            # Deployment descriptor
|   |   |   |-- css/                   # CSS stylesheets
|   |   |   |-- js/                    # JavaScript files
|   |   |   |-- register-employee.jsp  # Registration form
|   |   |   |-- employee-list.jsp      # Employee list display
|   |   |   |-- index.jsp             # Welcome page
|-- database/
|   |-- create_database.sql            # Database setup script
|-- README.md                          # This file
```

## Prerequisites

1. **Java Development Kit (JDK)** - Version 8 or higher
2. **Apache Tomcat** - Version 9.0 or higher
3. **MySQL Server** - Version 5.7 or higher
4. **IDE** - Eclipse, IntelliJ IDEA, or any Java IDE
5. **MySQL Connector/J** - JDBC driver for MySQL

## Setup Instructions

### 1. Database Setup

1. Install MySQL Server if not already installed
2. Start MySQL service
3. Execute the database setup script:

```sql
-- Run the following script in MySQL command line or MySQL Workbench
SOURCE database/create_database.sql;
```

Or manually execute these commands:

```sql
CREATE DATABASE IF NOT EXISTS employee_registration;
USE employee_registration;

CREATE TABLE IF NOT EXISTS employees (
    id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    phone VARCHAR(20) NOT NULL,
    department VARCHAR(50) NOT NULL,
    position VARCHAR(50) NOT NULL,
    salary DECIMAL(10,2) NOT NULL,
    hire_date DATE NOT NULL,
    address TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);
```

### 2. Project Configuration

1. **Update Database Connection**:
   - Edit `src/main/java/com/employee/util/DatabaseUtil.java`
   - Update the database URL, username, and password:
   ```java
   private static final String DB_URL = "jdbc:mysql://localhost:3306/employee_registration";
   private static final String DB_USERNAME = "your_mysql_username";
   private static final String DB_PASSWORD = "your_mysql_password";
   ```

2. **Add MySQL JDBC Driver**:
   - Download MySQL Connector/J from [MySQL official website](https://dev.mysql.com/downloads/connector/j/)
   - Add the JAR file to your project's classpath
   - For Tomcat, place the JAR file in `WEB-INF/lib/` directory

### 3. Deployment

#### Option 1: Using IDE (Eclipse/IntelliJ)

1. Import the project as a Dynamic Web Project
2. Configure the server runtime (Apache Tomcat)
3. Add MySQL Connector/J to the project's build path
4. Run the project on the server

#### Option 2: Manual WAR Deployment

1. Create a WAR file:
   ```bash
   # Navigate to project root
   jar -cvf employee-registration.war .
   ```

2. Deploy to Tomcat:
   - Copy the WAR file to Tomcat's `webapps` directory
   - Start Tomcat server

#### Option 3: Using Maven (if pom.xml is added)

1. Add Maven dependencies to `pom.xml`
2. Build the project:
   ```bash
   mvn clean package
   ```
3. Deploy the generated WAR file

### 4. Access the Application

Once deployed, access the application:

- **Home Page**: `http://localhost:8080/employee-registration/`
- **Employee List**: `http://localhost:8080/employee-registration/EmployeeListServlet`
- **Registration Form**: `http://localhost:8080/employee-registration/EmployeeRegistrationServlet`

## Usage Guide

### Registering a New Employee

1. Navigate to the registration form
2. Fill in all required fields (marked with *)
3. Click "Register Employee" button
4. Success message will appear and redirect to employee list

### Viewing Employees

1. Go to the employee list page
2. All registered employees are displayed in a table
3. Use the "Register New Employee" button to add more employees

### Data Validation

The application includes comprehensive validation:

- **Required Fields**: All mandatory fields must be filled
- **Email Format**: Valid email address format required
- **Phone Format**: Valid phone number format accepted
- **Salary**: Positive numbers only
- **Hire Date**: Cannot be in the future
- **Unique Email**: Each email must be unique in the system

## Configuration Options

### Database Configuration

Update the following in `DatabaseUtil.java`:

```java
// Database connection parameters
private static final String DB_URL = "jdbc:mysql://localhost:3306/employee_registration";
private static final String DB_USERNAME = "your_username";
private static final String DB_PASSWORD = "your_password";
```

### Server Configuration

In `web.xml`, you can configure:

- Session timeout
- Error pages
- Character encoding
- Security constraints

## Troubleshooting

### Common Issues

1. **Database Connection Error**:
   - Verify MySQL server is running
   - Check database credentials in `DatabaseUtil.java`
   - Ensure MySQL Connector/J is in the classpath

2. **404 Error**:
   - Verify the application is properly deployed
   - Check the URL pattern in web.xml
   - Ensure Tomcat is running on the correct port

3. **ClassNotFoundException for MySQL Driver**:
   - Add MySQL Connector/J JAR to `WEB-INF/lib/`
   - Or add to project build path

4. **Character Encoding Issues**:
   - Ensure UTF-8 encoding is set in web.xml
   - Check database character set (recommended: utf8mb4)

### Debug Mode

To enable debug mode, add logging to `DatabaseUtil.java`:

```java
System.out.println("Attempting database connection...");
```

## Security Considerations

1. **Database Credentials**: Store credentials securely
2. **SQL Injection**: Use PreparedStatement (already implemented)
3. **Input Validation**: Comprehensive validation implemented
4. **Error Messages**: Avoid exposing sensitive information

## Future Enhancements

Potential improvements for the application:

1. **Employee Update/Edit** functionality
2. **Employee Delete** functionality
3. **Search and Filter** capabilities
4. **Pagination** for large employee lists
5. **Export to PDF/Excel** functionality
6. **User Authentication** and authorization
7. **Profile Pictures** upload
8. **Audit Trail** for changes
9. **Email Notifications** for new registrations
10. **REST API** for mobile integration

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test thoroughly
5. Submit a pull request

## License

This project is for educational purposes. Feel free to use and modify as needed.

## Support

For any issues or questions, please check the troubleshooting section or create an issue in the project repository.

---

**Note**: This application is designed as a learning project to demonstrate JSP, Servlet, and JDBC integration. For production use, consider additional security measures and optimizations.
