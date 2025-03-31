"Define the base Ride class"
Object subclass: Ride [
    | rideID pickupLocation dropoffLocation distance |

    "Class method to create a new ride with the provided details"
    Ride class >> newRideWithID: anID pickup: pickup dropoff: dropoff distance: dist [
        ^self new initializeWithID: anID pickup: pickup dropoff: dropoff distance: dist.
    ]

    "Instance method to initialize the ride with an ID, pickup, dropoff, and distance"
    Ride >> initializeWithID: anID pickup: pickup dropoff: dropoff distance: dist [
        rideID := anID.
        pickupLocation := pickup.
        dropoffLocation := dropoff.
        distance := dist.
    ]

    "Method to calculate the fare; intended to be overridden by subclasses"
    Ride >> fare [
        ^ 0. "To be overridden by subclasses"
    ]

    "Return a formatted string of the ride details"
    Ride >> rideDetails [
        ^ 'Ride ID: ', rideID asString, ' | Pickup: ', pickupLocation, ' | Dropoff: ', dropoffLocation, ' | Distance: ', distance asString.
    ]
]

"Define StandardRide subclass, representing a standard ride type"
Ride subclass: StandardRide [
    "Override fare to calculate standard ride fare at $2 per mile"
    StandardRide >> fare [
        ^ distance * 2.0.
    ]

    "Override rideDetails to include the ride type and fare for a standard ride"
    StandardRide >> rideDetails [
        ^ (super rideDetails), ' | Type: Standard | Fare: $', (self fare) asString.
    ]
]

"Define PremiumRide subclass, representing a premium ride type"
Ride subclass: PremiumRide [
    "Override fare to calculate premium ride fare at $3.5 per mile"
    PremiumRide >> fare [
        ^ distance * 3.5.
    ]

    "Override rideDetails to include the ride type and fare for a premium ride"
    PremiumRide >> rideDetails [
        ^ (super rideDetails), ' | Type: Premium | Fare: $', (self fare) asString.
    ]
]

"Define the Driver class to represent a ride-sharing driver"
Object subclass: Driver [
    | driverID name rating assignedRides |

    "Class method to create a new driver with given ID, name, and rating"
    Driver class >> newDriverWithID: anID name: driverName rating: driverRating [
        ^ self new initializeWithID: anID name: driverName rating: driverRating.
    ]

    "Initialize the driver with an ID, name, rating, and an empty collection for rides"
    Driver >> initializeWithID: anID name: driverName rating: driverRating [
        driverID := anID.
        name := driverName.
        rating := driverRating.
        assignedRides := OrderedCollection new.
    ]

    "Add a ride to the driver's collection of assigned rides"
    Driver >> addRide: aRide [
        assignedRides add: aRide.
    ]

    "Return driver information along with details of all assigned rides"
    Driver >> getDriverInfo [
        | rideInfo |
        rideInfo := ''.
        assignedRides do: [:ride | rideInfo := rideInfo, ride rideDetails, ' || '].
        ^ 'Driver ID: ', driverID asString, ' | Name: ', name, ' | Rating: ', rating asString, ' | Assigned Rides: ', rideInfo.
    ]
]

"Define the Rider class to represent a ride-sharing customer"
Object subclass: Rider [
    | riderID name requestedRides |

    "Class method to create a new rider with the provided ID and name"
    Rider class >> newRiderWithID: anID name: riderName [
        ^ self new initializeWithID: anID name: riderName.
    ]

    "Initialize the rider with an ID, name, and an empty collection for requested rides"
    Rider >> initializeWithID: anID name: riderName [
        riderID := anID.
        name := riderName.
        requestedRides := OrderedCollection new.
    ]

    "Add a ride to the rider's list of requested rides"
    Rider >> requestRide: aRide [
        requestedRides add: aRide.
    ]

    "Return rider information along with details of all requested rides"
    Rider >> viewRides [
        | rideInfo |
        rideInfo := ''.
        requestedRides do: [:ride | rideInfo := rideInfo, ride rideDetails, ' || '].
        ^ 'Rider ID: ', riderID asString, ' | Name: ', name, ' | Requested Rides: ', rideInfo.
    ]
]

"Testing the Ride Sharing System"
| ride1 ride2 driver rider |

"Create a StandardRide instance with specific details"
ride1 := StandardRide newRideWithID: 1 pickup: 'Downtown' dropoff: 'Airport' distance: 10.

"Create a PremiumRide instance with specific details"
ride2 := PremiumRide newRideWithID: 2 pickup: 'Mall' dropoff: 'Hotel' distance: 5.

"Create a Driver instance and assign rides to the driver"
driver := Driver newDriverWithID: 101 name: 'Shaffan' rating: 4.9.
driver addRide: ride1.
driver addRide: ride2.

"Create a Rider instance and request rides"
rider := Rider newRiderWithID: 201 name: 'Ahmed'.
rider requestRide: ride1.
rider requestRide: ride2.

"Display the driver's and rider's information in the Transcript"
Transcript show: (driver getDriverInfo); cr.
Transcript show: (rider viewRides); cr.
