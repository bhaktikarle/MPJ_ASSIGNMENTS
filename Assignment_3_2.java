package com.example;

class HillStations {

    void famousFood() {
        System.out.println("Famous food of hill station: ");
    }

    void famousFor() {
        System.out.println("Famous for its : ");
    }
}

class Manali extends HillStations {

    void famousFood() {
    	super.famousFood();
        System.out.println("Manali Food: Siddu");
    }

    void famousFor() {
    	super.famousFor();
        System.out.println("Snow & Mountains");
    }
}

class Shimla extends HillStations {

    void famousFood() {
    	super.famousFood();
        System.out.println("Shimla Food: Chana Madra");
    }

    void famousFor() {
    	super.famousFor();
        System.out.println("Mall Road");
    }
}

class Darjeeling extends HillStations {

    void famousFood() {
    	super.famousFood();
        System.out.println("Darjeeling Food: Momos");
    }

    void famousFor() {
    	super.famousFor();
        System.out.println("Tea Gardens");
    }
}

public class Assignment_3_2 {
	

	public static void main(String[] args) {
        HillStations h;

        h = new Manali();
        h.famousFood();
        h.famousFor();

        System.out.println();

        h = new Shimla();
        h.famousFood();
        h.famousFor();

        System.out.println();

        h = new Darjeeling();
        h.famousFood();
        h.famousFor();


	}

}
