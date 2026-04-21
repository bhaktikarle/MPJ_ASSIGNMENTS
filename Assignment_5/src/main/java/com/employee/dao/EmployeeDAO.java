package com.employee.dao;

import com.employee.model.Employee;
import com.employee.util.DatabaseUtil;

import java.sql.*;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

/**
 * Data Access Object (DAO) class for Employee operations
 * Handles all database operations related to employees
 */
public class EmployeeDAO {
    
    // SQL queries
    private static final String INSERT_EMPLOYEE = 
        "INSERT INTO employees (first_name, last_name, email, phone, department, position, salary, hire_date, address) " +
        "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
    
    private static final String SELECT_ALL_EMPLOYEES = 
        "SELECT * FROM employees ORDER BY last_name, first_name";
    
    private static final String SELECT_EMPLOYEE_BY_ID = 
        "SELECT * FROM employees WHERE id = ?";
    
    private static final String SELECT_EMPLOYEE_BY_EMAIL = 
        "SELECT * FROM employees WHERE email = ?";
    
    private static final String UPDATE_EMPLOYEE = 
        "UPDATE employees SET first_name = ?, last_name = ?, email = ?, phone = ?, " +
        "department = ?, position = ?, salary = ?, hire_date = ?, address = ? WHERE id = ?";
    
    private static final String DELETE_EMPLOYEE = 
        "DELETE FROM employees WHERE id = ?";
    
    private static final String COUNT_EMPLOYEES = 
        "SELECT COUNT(*) FROM employees";
    
    /**
     * Add a new employee to the database
     * @param employee Employee object to insert
     * @return true if insertion successful, false otherwise
     */
    public boolean addEmployee(Employee employee) {
        Connection connection = null;
        PreparedStatement preparedStatement = null;
        
        try {
            connection = DatabaseUtil.getConnection();
            preparedStatement = connection.prepareStatement(INSERT_EMPLOYEE, Statement.RETURN_GENERATED_KEYS);
            
            preparedStatement.setString(1, employee.getFirstName());
            preparedStatement.setString(2, employee.getLastName());
            preparedStatement.setString(3, employee.getEmail());
            preparedStatement.setString(4, employee.getPhone());
            preparedStatement.setString(5, employee.getDepartment());
            preparedStatement.setString(6, employee.getPosition());
            preparedStatement.setBigDecimal(7, employee.getSalary());
            preparedStatement.setDate(8, Date.valueOf(employee.getHireDate()));
            preparedStatement.setString(9, employee.getAddress());
            
            int rowsAffected = preparedStatement.executeUpdate();
            
            // Get the generated ID and set it back to the employee object
            if (rowsAffected > 0) {
                ResultSet generatedKeys = preparedStatement.getGeneratedKeys();
                if (generatedKeys.next()) {
                    employee.setId(generatedKeys.getInt(1));
                }
                return true;
            }
            
        } catch (SQLException e) {
            System.err.println("Error adding employee: " + e.getMessage());
            e.printStackTrace();
        } finally {
            DatabaseUtil.closeAll(connection, preparedStatement, null);
        }
        
        return false;
    }
    
    /**
     * Get all employees from the database
     * @return List of all employees
     */
    public List<Employee> getAllEmployees() {
        List<Employee> employees = new ArrayList<>();
        Connection connection = null;
        PreparedStatement preparedStatement = null;
        ResultSet resultSet = null;
        
        try {
            connection = DatabaseUtil.getConnection();
            preparedStatement = connection.prepareStatement(SELECT_ALL_EMPLOYEES);
            resultSet = preparedStatement.executeQuery();
            
            while (resultSet.next()) {
                Employee employee = extractEmployeeFromResultSet(resultSet);
                employees.add(employee);
            }
            
        } catch (SQLException e) {
            System.err.println("Error getting all employees: " + e.getMessage());
            e.printStackTrace();
        } finally {
            DatabaseUtil.closeAll(connection, preparedStatement, resultSet);
        }
        
        return employees;
    }
    
    /**
     * Get employee by ID
     * @param id Employee ID
     * @return Employee object if found, null otherwise
     */
    public Employee getEmployeeById(int id) {
        Connection connection = null;
        PreparedStatement preparedStatement = null;
        ResultSet resultSet = null;
        Employee employee = null;
        
        try {
            connection = DatabaseUtil.getConnection();
            preparedStatement = connection.prepareStatement(SELECT_EMPLOYEE_BY_ID);
            preparedStatement.setInt(1, id);
            resultSet = preparedStatement.executeQuery();
            
            if (resultSet.next()) {
                employee = extractEmployeeFromResultSet(resultSet);
            }
            
        } catch (SQLException e) {
            System.err.println("Error getting employee by ID: " + e.getMessage());
            e.printStackTrace();
        } finally {
            DatabaseUtil.closeAll(connection, preparedStatement, resultSet);
        }
        
        return employee;
    }
    
    /**
     * Get employee by email
     * @param email Employee email
     * @return Employee object if found, null otherwise
     */
    public Employee getEmployeeByEmail(String email) {
        Connection connection = null;
        PreparedStatement preparedStatement = null;
        ResultSet resultSet = null;
        Employee employee = null;
        
        try {
            connection = DatabaseUtil.getConnection();
            preparedStatement = connection.prepareStatement(SELECT_EMPLOYEE_BY_EMAIL);
            preparedStatement.setString(1, email);
            resultSet = preparedStatement.executeQuery();
            
            if (resultSet.next()) {
                employee = extractEmployeeFromResultSet(resultSet);
            }
            
        } catch (SQLException e) {
            System.err.println("Error getting employee by email: " + e.getMessage());
            e.printStackTrace();
        } finally {
            DatabaseUtil.closeAll(connection, preparedStatement, resultSet);
        }
        
        return employee;
    }
    
    /**
     * Update an existing employee
     * @param employee Employee object with updated information
     * @return true if update successful, false otherwise
     */
    public boolean updateEmployee(Employee employee) {
        Connection connection = null;
        PreparedStatement preparedStatement = null;
        
        try {
            connection = DatabaseUtil.getConnection();
            preparedStatement = connection.prepareStatement(UPDATE_EMPLOYEE);
            
            preparedStatement.setString(1, employee.getFirstName());
            preparedStatement.setString(2, employee.getLastName());
            preparedStatement.setString(3, employee.getEmail());
            preparedStatement.setString(4, employee.getPhone());
            preparedStatement.setString(5, employee.getDepartment());
            preparedStatement.setString(6, employee.getPosition());
            preparedStatement.setBigDecimal(7, employee.getSalary());
            preparedStatement.setDate(8, Date.valueOf(employee.getHireDate()));
            preparedStatement.setString(9, employee.getAddress());
            preparedStatement.setInt(10, employee.getId());
            
            int rowsAffected = preparedStatement.executeUpdate();
            return rowsAffected > 0;
            
        } catch (SQLException e) {
            System.err.println("Error updating employee: " + e.getMessage());
            e.printStackTrace();
        } finally {
            DatabaseUtil.closeAll(connection, preparedStatement, null);
        }
        
        return false;
    }
    
    /**
     * Delete an employee by ID
     * @param id Employee ID to delete
     * @return true if deletion successful, false otherwise
     */
    public boolean deleteEmployee(int id) {
        Connection connection = null;
        PreparedStatement preparedStatement = null;
        
        try {
            connection = DatabaseUtil.getConnection();
            preparedStatement = connection.prepareStatement(DELETE_EMPLOYEE);
            preparedStatement.setInt(1, id);
            
            int rowsAffected = preparedStatement.executeUpdate();
            return rowsAffected > 0;
            
        } catch (SQLException e) {
            System.err.println("Error deleting employee: " + e.getMessage());
            e.printStackTrace();
        } finally {
            DatabaseUtil.closeAll(connection, preparedStatement, null);
        }
        
        return false;
    }
    
    /**
     * Get total count of employees
     * @return Number of employees in the database
     */
    public int getEmployeeCount() {
        Connection connection = null;
        PreparedStatement preparedStatement = null;
        ResultSet resultSet = null;
        int count = 0;
        
        try {
            connection = DatabaseUtil.getConnection();
            preparedStatement = connection.prepareStatement(COUNT_EMPLOYEES);
            resultSet = preparedStatement.executeQuery();
            
            if (resultSet.next()) {
                count = resultSet.getInt(1);
            }
            
        } catch (SQLException e) {
            System.err.println("Error getting employee count: " + e.getMessage());
            e.printStackTrace();
        } finally {
            DatabaseUtil.closeAll(connection, preparedStatement, resultSet);
        }
        
        return count;
    }
    
    /**
     * Helper method to extract Employee object from ResultSet
     * @param resultSet ResultSet containing employee data
     * @return Employee object
     * @throws SQLException if database error occurs
     */
    private Employee extractEmployeeFromResultSet(ResultSet resultSet) throws SQLException {
        Employee employee = new Employee();
        employee.setId(resultSet.getInt("id"));
        employee.setFirstName(resultSet.getString("first_name"));
        employee.setLastName(resultSet.getString("last_name"));
        employee.setEmail(resultSet.getString("email"));
        employee.setPhone(resultSet.getString("phone"));
        employee.setDepartment(resultSet.getString("department"));
        employee.setPosition(resultSet.getString("position"));
        employee.setSalary(resultSet.getBigDecimal("salary"));
        
        Date hireDate = resultSet.getDate("hire_date");
        if (hireDate != null) {
            employee.setHireDate(hireDate.toLocalDate());
        }
        
        employee.setAddress(resultSet.getString("address"));
        
        return employee;
    }
}
