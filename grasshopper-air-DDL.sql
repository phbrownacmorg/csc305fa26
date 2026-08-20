CREATE TABLE if not exists Airport (
  AirportCode char(3) primary key,
  Name varchar(50) unique not null,
  Address varchar(50) not null,
  Latitude float(6) not null,
  Longitude float(6) not null,
  elevation integer not null
);

CREATE TABLE if not exists Passenger (
  PsgrID integer primary key autoincrement,
  FirstName varchar(20) not null,
  LastName varchar(30) not null,
  Address varchar(50) not null,
  Phone char(10),
  Birthdate date
);

-- drop table if exists Flight;
CREATE TABLE if not exists Flight (
  FltNum integer primary key, -- pretend this never changes.  In fact, it does, but rarely.  
  Origin char(3) not null,
  Dest char(3) not null,
  DpTime time,
  ArTime time,
  ACModelID integer,
constraint FKOrigin foreign key(Origin) references Airport(AirportCode),
constraint FKDest foreign key(Dest) references Airport(AirportCode),
constraint FKType foreign key(ACModelID) references ACModel
);

create table if not exists ACModel (
  ACModelID integer primary key autoincrement,
  ModelName varchar(15),
  Manufacturer varchar(30) not null,
  Seats integer,
  FuelCapy integer, -- in pounds, at sea level and 25 degrees C
  WeightCapy integer -- cargo capacity in pounds, at sea level and 25 degrees C
);

drop table if exists Aircraft;
create table if not exists Aircraft (
  ACID integer primary key autoincrement,
  ACModelID integer,
  RegNum char(8) unique
);

drop table if exists Ticket;
create table if not exists Ticket (
  TktNum integer primary key autoincrement,
  PsgrID integer,
  FltNum integer,
  FltDate date,
  Seat char(3),
constraint FKPsgr foreign key(PsgrID) references Passenger,
constraint FltNum foreign key(FltNum) references Flight,
constraint UniqPsgrFltDate unique(PsgrId, FltNum, FltDate)
);