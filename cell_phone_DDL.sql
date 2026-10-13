-- Turn on foreign-key checking (off by default)
pragma foreign_keys=on;

drop table if exists Address;
create table Address (
    AddressID integer primary key autoincrement,
    StreetAddress varchar(30) not null,
    City varchar(20) not null,
    AddrState char(2) not null,
    Zip char(9) not null
);

drop table if exists Person;
create table Person (
    PersonID integer primary key autoincrement,
    FirstName varchar(20) not null,
    LastName varchar(30) not null,
    AddressID integer not null references Address
);

drop table if exists PhonePlan;
create table PhonePlan (
    PlanID integer primary key autoincrement,
    PlanName varchar(10) not null unique,
    PlanMessages integer,
    PlanMinutes integer,
    PlanData integer
);

drop table if exists Device;
create table Device (
    DeviceID integer primary key autoincrement,
    IMEI integer unique not null,
    SIM_id integer,
    WiFi_MAC char(17),
    Manufacturer varchar(30) not null,
    Model varchar(10) not null
);

drop table if exists Account;
create table Account (
    AcctID integer primary key autoincrement,
    AcctNum integer not null unique,
    Balance decimal(8,2) default 0
);

drop table if exists PhoneLine;
create table PhoneLine (
    LineID integer primary key autoincrement,
    PhoneNumber char(10) not null unique,
    AcctID integer not null references Account,
    PlanID integer not null references PhonePlan,
    DeviceID integer references Device 
);

drop table if exists Bill;
create table Bill (
    BillID integer primary key autoincrement,
    AcctID integer not null references Account,
    amount decimal(8,2) not null,
    BillDate date not null,
    DueDate date not null
);

drop table if exists PaymentMethod;
create table PaymentMethod (
    MethodID integer primary key autoincrement,
    MethodNumber not null unique
);

drop table if exists CreditCard;
create table CreditCard (
    MethodID integer primary key references PaymentMethod,
    Issuer varchar(30) not null,
    Processor varchar(10) not null,
    CVV char(3) not null,
    Expires date not null
);

drop table if exists BankAccount;
create table BankAccount (
    MethodID integer primary key references PaymentMethod,
    Routing char(9) not null,
    Checking boolean not null
);

drop table if exists Payment;
create table Payment (
    PaymentID integer primary key autoincrement,
    MethodID integer not null references PaymentMethod,
    BillID integer not null references Bill,
    Amount decimal(7,2) not null,
    Paid date not null
);

drop table if exists AccountAdmin;
create table AccountAdmin (
    PersonID integer references Person,
    AcctID integer references Account,
    isPrimaryOwner boolean not null,
constraint PKAcctAdmin primary key(personID, AcctID)
);

drop table if exists PaymentMethodOwner;
create table PaymentMethodOwner (
    PersonID integer references Person,
    MethodID integer references PaymentMethod,
    isPrimary boolean not null,
constraint PKMethodOwner primary key(PersonID, MethodID)
);