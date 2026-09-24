drop table if exists Person;
drop table if exists Faculty;
drop table if exists Student;
drop table if exists Course;
drop table if exists Offering;
drop table if exists Enrollment;

create table if not exists Person (
    SSN char(9) primary key,
    FirstName varchar(30),
    LastName varchar(50),
    City varchar(50),
    PersonState char(2),
    Zip char(9),
    FacSupervisor char(9) references Person(SSN),
    FacDept char(6),
    FacRank char(4),
    FacHireDate date,
    FacSalary decimal(10,2),
    StdMajor char(6),
    StdClass char(4),
    StdGPA float(8, 2)
);

create table if not exists Course (
    CourseNo char(6) primary key,
    CrsDesc varchar(250),
    CrsUnits smallint
);

create table if not exists Offering (
    OfferNo smallint primary key,
    CourseNo char(6) references Course not null,
    OffTerm char(6),
    OffYear smallint,
    OffLocation varchar(50),
    OffDays char(8),
    OffTime time,
    FacSSN references Person(SSN)
);

create table if not exists Enrollment (
    StdSSN char(9) references Person(SSN),
    OfferNo smallint references Offering,
    EnrGrade float(8,2),
    constraint PKEnrollment primary key(StdSSN, OfferNo)
);