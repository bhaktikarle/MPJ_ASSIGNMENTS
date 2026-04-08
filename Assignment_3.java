package com.example;

class Shape {
    double area;


    Shape(double r) {
        area = 3.14 * r * r;
        System.out.println("Area of Circle: " + area);
    }

    Shape(double l, double b) {
        area = l * b;
        System.out.println("Area of Rectangle: " + area);
    }


    Shape(double b, double h, int x) {
        area = 0.5 * b * h;
        System.out.println("Area of Triangle: " + area);
    }


    void findArea(double r) {
        area = 3.14 * r * r;
        System.out.println("Area of Circle : " + area);
    }

    void findArea(double l, double b) {
        area = l * b;
        System.out.println("Area of Rectangle : " + area);
    }

    void findArea(double b, double h, int x) {
        area = 0.5 * b * h;
        System.out.println("Area of Triangle : " + area);
    }
}

public class Assignment_3 {

    public static void main(String[] args) {
    	
        System.out.println("Area using Constructor overloading :");
        Shape s1 = new Shape(5);
        Shape s2 = new Shape(4, 6);
        Shape s3 = new Shape(3, 8, 1);

        System.out.println();
        
        System.out.println("Area using Method overloading :");

        Shape obj = new Shape(1); 

        obj.findArea(7);
        obj.findArea(5, 9);
        obj.findArea(6, 4, 1);
    }
}