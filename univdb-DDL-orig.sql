CREATE TABLE if not exists Student (
	StdSSN CHAR(9) NOT NULL,
	StdFirstName VARCHAR(30) NOT NULL,
	StdLastName VARCHAR(50) NOT NULL,
	StdCity VARCHAR(50) NOT NULL,
	StdState CHAR(2) NOT NULL,
	StdMajor CHAR(6),
	StdClass CHAR(2),
	StdGPA FLOAT(8, 2),
	StdZip CHAR(9) NOT NULL,
	constraint PKStudent primary key(StdSSN)
);

CREATE TABLE if not exists Faculty (
	FacSSN CHAR(9) NOT NULL,
	FacFirstName VARCHAR(30) NOT NULL,
	FacLastName VARCHAR(50) NOT NULL,
	FacCity VARCHAR(50) NOT NULL,
	FacState CHAR(2) NOT NULL,
	FacDept CHAR(6),
	FacRank CHAR(4),
	FacSalary DECIMAL(10, 2),
	FacSupervisor CHAR(9),
	FacHireDate DATE,
	FacZipCode CHAR(9) NOT NULL,
	constraint PKFaculty primary key(FacSSN),
	constraint FKFacSupervisor foreign key(FacSupervisor) references Faculty on update no action on delete no action
);

CREATE TABLE if not exists Course (
	CourseNo CHAR(6) NOT NULL,
	CrsDesc VARCHAR(250) NOT NULL,
	CrsUnits SMALLINT,
	CONSTRAINT PKCourse PRIMARY KEY (CourseNo),
	CONSTRAINT UniqueCrsDesc UNIQUE (CrsDesc)
);

CREATE TABLE if not exists Offering (
	OfferNo SMALLINT NOT NULL,
	CourseNo CHAR(6) NOT NULL,
	OffTerm CHAR(6) NOT NULL,
	OffYear SMALLINT NOT NULL,
	OffLocation VARCHAR(50),
	OffTime TIME,
	FacSSN CHAR(9),
	OffDays CHAR(6),
	constraint PKOffering primary key(OfferNo),
	constraint FKCourseNo foreign key(CourseNo) references Course on delete no action on update no action,
	constraint FKFacSSN foreign key(FacSSN) references Faculty on delete no action on update cascade
);

CREATE TABLE if not exists Enrollment (
	OfferNo SMALLINT NOT NULL,
	StdSSN CHAR(9) NOT NULL,
	EnrGrade FLOAT(8, 2),
	CONSTRAINT PKEnrollment PRIMARY KEY(OfferNo, StdSSN),
	constraint FKOfferNo foreign key(OfferNo) references Offering on delete cascade on update cascade,
	constraint FKStdSSN foreign key(StdSSN) references Student on delete cascade on update cascade
);