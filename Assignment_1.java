package com.example;

class Student {

    int id;
    String name;
    String course;


    Student(int id, String name, String course) {
        this.id = id;
        this.name = name;
        this.course = course;
    }


    void displayInfo() {
        System.out.println("ID      : " + id);
        System.out.println("Name    : " + name);
        System.out.println("Course  : " + course);
        System.out.println("-----------------");
    }
}

public class Assignment_1 {

	public static void main(String[] args) {

        Student s1 = new Student(1, "Bhakti", "Computer Science");
        Student s2 = new Student(2, "Amit", "IT");

        s1.displayInfo();
        s2.displayInfo();

	}

}
