-- Employee Registration Database Schema
-- MySQL Database Setup Script

-- Create database if not exists
CREATE DATABASE IF NOT EXISTS employee_registration;
USE employee_registration;

-- Create employees table
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

-- Insert sample data for testing
INSERT INTO employees (first_name, last_name, email, phone, department, position, salary, hire_date, address) VALUES
('John', 'Doe', 'john.doe@example.com', '123-456-7890', 'IT', 'Software Developer', 75000.00, '2023-01-15', '123 Main St, City, State 12345'),
('Jane', 'Smith', 'jane.smith@example.com', '234-567-8901', 'HR', 'HR Manager', 85000.00, '2022-11-20', '456 Oak Ave, Town, State 67890'),
('Mike', 'Johnson', 'mike.johnson@example.com', '345-678-9012', 'Finance', 'Accountant', 65000.00, '2023-03-10', '789 Pine Rd, Village, State 11223'),
('Sarah', 'Williams', 'sarah.williams@example.com', '456-789-0123', 'Marketing', 'Marketing Manager', 80000.00, '2022-09-05', '321 Elm St, City, State 54321'),
('David', 'Brown', 'david.brown@example.com', '567-890-1234', 'IT', 'System Administrator', 70000.00, '2023-02-28', '654 Maple Dr, Town, State 98765');

-- Create indexes for better performance
CREATE INDEX idx_email ON employees(email);
CREATE INDEX idx_department ON employees(department);
CREATE INDEX idx_last_name ON employees(last_name);

-- Show table structure
DESCRIBE employees;
