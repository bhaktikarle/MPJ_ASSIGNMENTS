package com.example;

class Employee {

    double salary;


    Employee(double salary) {
        this.salary = salary;
    }

    void displaySalary() {
        System.out.println("Salary : " + salary);
    }
}


class FullTimeEmployee extends Employee {

    FullTimeEmployee(double salary) {
        super(salary);
    }

    void calculateSalary() {
        System.out.println("Full Time Employee");
        System.out.print("Before Hike -> ");
        displaySalary();

        salary = salary + (salary * 0.50);

        System.out.print("After 50% Hike -> ");
        displaySalary();
        System.out.println("----------------------");
    }
}


class InternEmployee extends Employee {

    InternEmployee(double salary) {
        super(salary);
    }

    void calculateSalary() {
        System.out.println("Intern Employee");
        System.out.print("Before Hike -> ");
        displaySalary();

        salary = salary + (salary * 0.25);

        System.out.print("After 25% Hike -> ");
        displaySalary();
        System.out.println("----------------------");
    }
}



public class Assignment_2 {
    public static void main(String[] args) {

        FullTimeEmployee fte = new FullTimeEmployee(40000);
        InternEmployee intern = new InternEmployee(20000);

        fte.calculateSalary();
        intern.calculateSalary();
    }

}
