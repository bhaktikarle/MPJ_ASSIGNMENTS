package com.example;
import java.io.*;
import java.util.*;

class InvalidCIDException extends Exception {
    InvalidCIDException(String msg) {
        super(msg);
    }
}

class InvalidAmountException extends Exception {
    InvalidAmountException(String msg) {
        super(msg);
    }
}

class InsufficientBalanceException extends Exception {
    InsufficientBalanceException(String msg) {
        super(msg);
    }
}

class Customer implements Serializable {
    int cid;
    String cname;
    double amount;

    Customer(int cid, String cname, double amount) {
        this.cid = cid;
        this.cname = cname;
        this.amount = amount;
    }

    void display() {
        System.out.println(cid + " " + cname + " " + amount);
    }
}

public class Assignment_4 {
    static final String FILE = "customer.dat";

    static void addCustomer() throws Exception {
        Scanner sc = new Scanner(System.in);

        System.out.print("Enter CID: ");
        int cid = sc.nextInt();
        if (cid < 1 || cid > 20)
            throw new InvalidCIDException("CID must be between 1 and 20");

        System.out.print("Enter Name: ");
        String cname = sc.next();

        System.out.print("Enter Amount: ");
        double amt = sc.nextDouble();

        if (amt < 1000)
            throw new InvalidAmountException("Minimum balance is 1000");

        if (amt <= 0)
            throw new InvalidAmountException("Amount must be positive");

        Customer c = new Customer(cid, cname, amt);

        FileOutputStream fos = new FileOutputStream(FILE, true);
        ObjectOutputStream oos;

        if (new File(FILE).length() == 0)
            oos = new ObjectOutputStream(fos);
        else
            oos = new ObjectOutputStream(fos) {
                protected void writeStreamHeader() throws IOException {}
            };

        oos.writeObject(c);
        oos.close();

        System.out.println("Account Created!");
    }

    static void displayAll() throws Exception {
        FileInputStream fis = new FileInputStream(FILE);
        ObjectInputStream ois = new ObjectInputStream(fis);

        try {
            while (true) {
                Customer c = (Customer) ois.readObject();
                c.display();
            }
        } catch (EOFException e) {
            ois.close();
        }
    }

    static void withdraw() throws Exception {
        Scanner sc = new Scanner(System.in);

        System.out.print("Enter CID: ");
        int id = sc.nextInt();

        System.out.print("Enter Withdraw Amount: ");
        double wamt = sc.nextDouble();

        if (wamt <= 0)
            throw new InvalidAmountException("Amount must be positive");

        FileInputStream fis = new FileInputStream(FILE);
        ObjectInputStream ois = new ObjectInputStream(fis);

        ArrayList<Customer> list = new ArrayList<>();

        try {
            while (true) {
                Customer c = (Customer) ois.readObject();

                if (c.cid == id) {
                    if (wamt > c.amount)
                        throw new InsufficientBalanceException("Insufficient balance");
                    c.amount -= wamt;
                }
                list.add(c);
            }
        } catch (EOFException e) {
            ois.close();
        }

        ObjectOutputStream oos = new ObjectOutputStream(new FileOutputStream(FILE));
        for (Customer c : list)
            oos.writeObject(c);

        oos.close();
        System.out.println("Withdrawal Successful!");
    }

    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);

        while (true) {
            System.out.println("\n1. Add Customer");
            System.out.println("2. Display");
            System.out.println("3. Withdraw");
            System.out.println("4. Exit");

            System.out.print("Choice: ");
            int ch = sc.nextInt();

            try {
                switch (ch) {
                    case 1: addCustomer(); break;
                    case 2: displayAll(); break;
                    case 3: withdraw(); break;
                    case 4: System.exit(0);
                    default: System.out.println("Invalid choice");
                }
            } catch (Exception e) {
                System.out.println("Error: " + e.getMessage());
            }
        }
    }
}