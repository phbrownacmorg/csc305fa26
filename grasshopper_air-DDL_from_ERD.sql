create table if not exists Airport (
    AirportCode char(3) primary key,
    AirportName varchar(50),
    AirportAddress varchar(50),
    Latitude float(6),
    Longitude float(6),
    Elevation integer
);

create table if not exists Flight (
    FltNum integer primary key,
    Origin char(3) references Airport(AirportCode) not null,
    Dest char(3) references Airport(AirportCode) not null,
    ACModelID integer references ACModel not null,
    DpTime time,
    ArTime time
);

create table if not exists Passenger (
    PsgrID integer primary key,
    FirstName varchar(20),
    LastName varchar(30),
    PsgrAddress varchar(50),
    Phone char(10),
    Birthdate date
);

create table if not exists Ticket (
    TktNum integer primary key,
    PsgrID integer references Passenger not null,
    FltNum integer references Flight not null,
    FltDate date,
    Seat char(3)
);

create table if not exists ACModel (
    ACModelID integer primary key,
    ModelName varchar(15),
    Manufacturer varchar(30),
    Seats integer,
    FuelCapy integer,
    WeightCapy integer
);

create table if not exists Aircraft (
    ACID integer primary key,
    ACModelID integer references ACModel not null,
    RegNum char(8)
);

create table if not exists ConnectingFlight (
    Inbound integer references Flight(FltNum) not null,
    Outbound integer references Flight(FltNum) not null,
    AirportCode char(3) references Airport not null,
    constraint PKConnection primary key(Inbound, Outbound)
);

create table if not exists ACAssignment (
    FltNum integer references Flight not null,
    ACID integer references Aircraft not null,
    FltDate date,
    constraint PKACAssignment primary key(FltNum, ACID, FltDate)
);