-- CREATE DATABASE Crime;

drop table if exists crimeHistory;
drop table  if exists crimeimport;
drop table if exists Offence;

CREATE TABLE Offence(
	OffenseCode INT,
    OffenseDescription VARCHAR(100),
    PRIMARY KEY (OffenseCode)
);

CREATE TABLE crimeHistory(
	OCANumber INT AUTO_INCREMENT,
    StartDate DATE,
    OffenseCode INT,
    LocationStreet VARCHAR(40),
    LocationLatitude DOUBLE,
    LocationLongitude DOUBLE,
    PRIMARY KEY (OCANumber),
    FOREIGN KEY (OffenseCode) REFERENCES Offence(OffenseCode)
);

 CREATE TABLE crimeImport(
	 OCANumber INT AUTO_INCREMENT,
     FromDate DATE Default null,
     OffenseCode INT Default null,
     OffenseDescription VARCHAR(100) Default null,
     LocationStreet VARCHAR(40) Default null,
     Latitude DOUBLE Default null,
     Longitude DOUBLE Default null,
     PRIMARY KEY (OCANumber)
 );
