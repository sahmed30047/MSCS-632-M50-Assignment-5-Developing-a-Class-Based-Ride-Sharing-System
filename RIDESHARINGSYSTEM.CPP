#include <iostream>
#include <vector>
#include <memory>
using namespace std;

// Base Ride Class: Abstract class representing a ride
class Ride {
protected:
    int rideID;                // Unique identifier for the ride
    string pickupLocation;     // Pickup location for the ride
    string dropoffLocation;    // Dropoff location for the ride
    double distance;           // Distance of the ride in miles
public:
    // Constructor to initialize ride details
    Ride(int id, string pickup, string dropoff, double dist) 
        : rideID(id), pickupLocation(pickup), dropoffLocation(dropoff), distance(dist) {}

    // Pure virtual function for calculating fare - must be overridden by derived classes
    virtual double fare() const = 0;

    // Function to display common ride details
    virtual void rideDetails() const {
        cout << "Ride ID: " << rideID 
             << ", Pickup: " << pickupLocation 
             << ", Dropoff: " << dropoffLocation 
             << ", Distance: " << distance << " miles" << endl;
    }

    // Virtual destructor
    virtual ~Ride() {}
};

// StandardRide subclass: Represents a standard type of ride
class StandardRide : public Ride {
public:
    // Constructor using the base class constructor
    StandardRide(int id, string pickup, string dropoff, double dist) 
        : Ride(id, pickup, dropoff, dist) {}

    // Override the fare function to calculate fare for a standard ride (rate: $2.0 per mile)
    double fare() const override {
        return distance * 2.0;
    }

    // Override the rideDetails function to include ride type and fare
    void rideDetails() const override {
        Ride::rideDetails(); // Call base class details
        cout << "Ride Type: Standard, Fare: $" << fare() << endl;
    }
};

// PremiumRide subclass: Represents a premium type of ride
class PremiumRide : public Ride {
public:
    // Constructor using the base class constructor
    PremiumRide(int id, string pickup, string dropoff, double dist) 
        : Ride(id, pickup, dropoff, dist) {}

    // Override the fare function to calculate fare for a premium ride (rate: $3.5 per mile)
    double fare() const override {
        return distance * 3.5;
    }

    // Override the rideDetails function to include ride type and fare
    void rideDetails() const override {
        Ride::rideDetails(); // Call base class details
        cout << "Ride Type: Premium, Fare: $" << fare() << endl;
    }
};

// Driver Class: Represents a driver with a set of assigned rides
class Driver {
private:
    int driverID;                 // Unique identifier for the driver
    string name;                  // Driver's name
    double rating;                // Driver's rating
    vector<shared_ptr<Ride>> assignedRides; // List of rides assigned to the driver
public:
    // Constructor to initialize driver details
    Driver(int id, string driverName, double driverRating) 
        : driverID(id), name(driverName), rating(driverRating) {}

    // Function to add a ride to the driver's list
    void addRide(shared_ptr<Ride> ride) {
        assignedRides.push_back(ride);
    }

    // Function to display driver information along with details of assigned rides
    void getDriverInfo() const {
        cout << "Driver ID: " << driverID 
             << ", Name: " << name 
             << ", Rating: " << rating << endl;
        cout << "Assigned Rides: " << endl;
        for (const auto& ride : assignedRides) {
            ride->rideDetails(); // Polymorphic call to rideDetails()
        }
    }
};

// Rider Class: Represents a rider who requests rides
class Rider {
private:
    int riderID;                 // Unique identifier for the rider
    string name;                 // Rider's name
    vector<shared_ptr<Ride>> requestedRides; // List of rides requested by the rider
public:
    // Constructor to initialize rider details
    Rider(int id, string riderName) : riderID(id), name(riderName) {}

    // Function to add a ride to the rider's requested list
    void requestRide(shared_ptr<Ride> ride) {
        requestedRides.push_back(ride);
    }

    // Function to display rider information along with details of requested rides
    void viewRides() const {
        cout << "Rider ID: " << riderID << ", Name: " << name << endl;
        cout << "Requested Rides: " << endl;
        for (const auto& ride : requestedRides) {
            ride->rideDetails(); // Polymorphic call to rideDetails()
        }
    }
};

int main() {
    // Create ride objects using shared pointers for dynamic memory management
    shared_ptr<Ride> ride1 = make_shared<StandardRide>(1, "Downtown", "Airport", 10.0);
    shared_ptr<Ride> ride2 = make_shared<PremiumRide>(2, "Mall", "Hotel", 5.0);
    
    // Create a Driver object and assign rides
    Driver driver(101, "Alice", 4.9);
    driver.addRide(ride1);
    driver.addRide(ride2);
    
    // Create a Rider object and request rides
    Rider rider(201, "Bob");
    rider.requestRide(ride1);
    rider.requestRide(ride2);
    
    // Display Driver and Rider information
    cout << "--- Driver Info ---" << endl;
    driver.getDriverInfo();
    
    cout << "\n--- Rider Info ---" << endl;
    rider.viewRides();
    
    return 0;
}
