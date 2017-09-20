/* Assignment.sql
* (KIT102 Data Modelling Assignment)
*
* creates database "WEOC" => populates it with the appropriate 
* 13 tables => inserts 2 values into each.
*
* author: Marina Rose "Mars" Geldard
* last edited: 09/05/2017
*/



/* ===== CREATE DATABASE AND SELECT IT AS TARGET FOR USE ===== */
CREATE DATABASE WinnaleahEssentialOilsCo;
USE WinnaleahEssentialOilsCo;



/* ========== CREATE 5 TABLES WITH NO DEPENDENCIES =========== */
CREATE TABLE Perfume (
	PerfumeName VARCHAR(20) NOT NULL,
	Description VARCHAR(100) NOT NULL,
	PRIMARY KEY (PerfumeName)
	)
	Engine=InnoDB;
	

CREATE TABLE Farmer (
	FarmerID SMALLINT(6) NOT NULL AUTO_INCREMENT, /* Assigns a unique number automatically due to lack of identifier */
	GivenName VARCHAR(20) NOT NULL,
	Surname VARCHAR(20) NOT NULL,
	PRIMARY KEY (FarmerID)
	)
	Engine=InnoDB;

CREATE TABLE Supplier (
	SupplierName VARCHAR(40) NOT NULL,
	SupplierAddress VARCHAR(40) NOT NULL,
	PRIMARY KEY (SupplierName)
	)
	Engine=InnoDB;
	
	
CREATE TABLE Retailer (
	CompanyName VARCHAR(40) NOT NULL,
	RetailAddress VARCHAR(40) NOT NULL,
	PRIMARY KEY (CompanyName)
	)
	Engine=InnoDB;
	
CREATE TABLE Customer (
	CustomerID SMALLINT(5) NOT NULL AUTO_INCREMENT, /* Assigns a unique number automatically due to lack of identifier */
	GivenName VARCHAR(20) NOT NULL,
	Surname VARCHAR(20) NOT NULL,
	PRIMARY KEY (CustomerID)
	)
	Engine=InnoDB;
	
	
	
/* ===== CREATE 8 TABLES WITH FOREIGN KEY DEPENDENCIES ===== */
CREATE TABLE Employee (
	PayrollNumber SMALLINT(6) NOT NULL AUTO_INCREMENT, /* Assigns a unique number automatically due to lack of identifier */
	GivenName VARCHAR(20) NOT NULL,
	Surname VARCHAR(20) NOT NULL,
	Address VARCHAR(40) NOT NULL,
	Designs VARCHAR(20) NOT NULL,
	Manager SMALLINT(6), /* Should only be NULL in the case of the boss */
	PRIMARY KEY (PayrollNumber),
	foreign KEY (Designs) references Perfume (PerfumeName),
	foreign KEY (Manager) references Employee (PayrollNumber) /* Refers to another entry in this same TABLE */
	)
	Engine = InnoDB;
	
CREATE TABLE Farm (
	FarmName VARCHAR(20) NOT NULL,
	FarmAddress VARCHAR(40) NOT NULL,
	FarmerID SMALLINT(6) NOT NULL,
	PRIMARY KEY (FarmName, FarmAddress),
	foreign KEY (FarmerID) references Farmer (FarmerID)
	)
	Engine=InnoDB;
	
CREATE TABLE Plant (
	BotanicalName VARCHAR(20) NOT NULL,
	CommonName VARCHAR(20) NOT NULL,
	Habitat VARCHAR(20) NOT NULL,
	FarmerID SMALLINT(6) NOT NULL,
	PRIMARY KEY (BotanicalName),
	foreign KEY (FarmerID) references Farmer (FarmerID)
	)
	Engine = InnoDB;
	
CREATE TABLE EssentialOil (
	OilID SMALLINT(6) NOT NULL AUTO_INCREMENT, /* Assigns a unique number automatically due to lack of identifier */
	FragranceWheel VARCHAR(20) NOT NULL,
	OriginatesFrom VARCHAR(20) NOT NULL,
	SupplierName VARCHAR(40) NOT NULL,
	PRIMARY KEY (OilID),
	foreign KEY (OriginatesFrom) references Plant (BotanicalName),
	foreign KEY (SupplierName) references Supplier (SupplierName)
	)
	Engine=InnoDB;
	
CREATE TABLE Bottle (
	BottleID SMALLINT(4) NOT NULL AUTO_INCREMENT, /* Assigns a unique number automatically due to lack of identifier */
	BottleColour VARCHAR(20) NOT NULL,
	BottleSize SMALLINT(4) NOT NULL,
	BottleShape VARCHAR(15) NOT NULL,
	SupplierName VARCHAR(40) NOT NULL,
	PerfumeName VARCHAR(20) NOT NULL,
	PRIMARY KEY (BottleID),
	foreign KEY (SupplierName) references Supplier (SupplierName),
	foreign KEY (PerfumeName) references Perfume (PerfumeName)
	)
	Engine=InnoDB;
	
CREATE TABLE CustomerPerfume (
	CustomerID SMALLINT(5) NOT NULL,
	PerfumeName VARCHAR(20) NOT NULL,
	PRIMARY KEY (CustomerID, PerfumeName),
	foreign KEY (CustomerID) references Customer (CustomerID),
	foreign KEY (PerfumeName) references Perfume (PerfumeName)
	)
	Engine=InnoDB;
	
CREATE TABLE RetailerPerfume (
	CompanyName VARCHAR(40) NOT NULL,
	PerfumeName VARCHAR(20) NOT NULL,
	PRIMARY KEY (CompanyName, PerfumeName),
	foreign KEY (CompanyName) references Retailer (CompanyName),
	foreign KEY (PerfumeName) references Perfume (PerfumeName)
	)
	Engine=InnoDB;
	
CREATE TABLE PerfumeOil (
	PerfumeName VARCHAR(20) NOT NULL,
	OilID SMALLINT(6) NOT NULL,
	PRIMARY KEY (PerfumeName, OilID),
	foreign KEY (PerfumeName) references Perfume (PerfumeName),
	foreign KEY (OilID) references EssentialOil (OilID)
	)
	Engine=InnoDB;
	
	
	
/* ======= INSERT 2 VALUES IN EACH INDEPENDENT TABLE ======= */
INSERT INTO Perfume VALUES ('Summer Dream','A flowery combination of Lavender, Jasmine and Ylang Ylang.');
INSERT INTO Perfume VALUES ('Woodland Essence','Cedar oil and Sandalwood with musk undertones.');

INSERT INTO Farmer VALUES (NULL, 'John', 'Smith');
INSERT INTO Farmer VALUES (NULL, 'David', 'McFarmer');

INSERT INTO Supplier VALUES ('Healthy Herbs','112 Widewood Court, Moria 7010');
INSERT INTO Supplier VALUES ('Apothecary Supplies Inc','1299 Clairemont Highway, Townville 7196');

INSERT INTO Retailer VALUES ('Eau de parfum','151 Davy Street, Hobarton 7371');
INSERT INTO Retailer VALUES ('Perfect Perfumes','Shop 4 Mary Arcade, 299 Montville Avenue, Montville 7159');

INSERT INTO Customer VALUES (NULL, 'Mary','Lovell');
INSERT INTO Customer VALUES (NULL, 'Jane', 'Doe');



/* ====== INSERT 2 VALUES IN EACH KEY-DEPENDENT TABLE ====== */
INSERT INTO Employee VALUES (NULL, 'Joseph', 'Bloggs', '9 Rosalind Avenue, Narnia 7000', 'Summer Dream', NULL);
INSERT INTO Employee VALUES (NULL, 'Jack', 'Barker', '12 Drury Lane, Neverland 7999', 'Woodland Essence', 1);

INSERT INTO Farm VALUES ('Tasmanian Organic Pty Ltd','34 Liverpool Circuit, Eureka 7118',1);
INSERT INTO Farm VALUES ('Abernathy Farm','2 Johnson Street, Faketown 7433',2);

INSERT INTO Plant VALUES ('Cupressus sempervirens','Mediterranean Cypress','Macchia (Shrubland)',2);
INSERT INTO Plant VALUES ('Lavandula angustifolia','English Lavender','Montane',1);

INSERT INTO EssentialOil VALUES (NULL,'Woody','Cupressus sempervirens','Apothecary Supplies Inc');
INSERT INTO EssentialOil VALUES (NULL,'Floral','Lavandula angustifolia','Healthy Herbs');

INSERT INTO Bottle VALUES (NULL, 'Red', 300, 'Cylindrical', 'Apothecary Supplies Inc', 'Summer Dream');
INSERT INTO Bottle VALUES (NULL, 'Clear', 500, 'Flask', 'Apothecary Supplies Inc', 'Woodland Essence');

INSERT INTO CustomerPerfume VALUES (1, 'Summer Dream');
INSERT INTO CustomerPerfume VALUES (2, 'Summer Dream');

INSERT INTO RetailerPerfume VALUES ('Perfect Perfumes','Woodland Essence');
INSERT INTO RetailerPerfume VALUES ('Eau de parfum','Summer Dream');

INSERT INTO PerfumeOil VALUES ('Summer Dream',2);
INSERT INTO PerfumeOil VALUES ('Woodland Essence',1);