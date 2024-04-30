
DROP DATABASE IF EXISTS TestPageWeb

CREATE DATABASE TestPageWeb


USE TestPageWeb


-- TABLE POST
	DROP TABLE IF EXISTS Company 

	CREATE TABLE Company
	(
	Company_ID INT NOT NULL PRIMARY KEY IDENTITY(1000000,1) ,
	Name VARCHAR(50) UNIQUE,
	Description VARCHAR(100)
	)
	GO

	INSERT INTO Company (Name, Description )VALUES 
	('Honda','company dedicated to the manufacture of automobiles'),
	('Toyota','company dedicated to the manufacture of automobiles - low')



-- TABLE PRODUCT 
	DROP TABLE IF EXISTS Product
	CREATE TABLE Product
	(
	Product_ID INT NOT NULL PRIMARY KEY IDENTITY(1000000,1) ,
	Company_ID INT NOT NULL FOREIGN KEY REFERENCES Company(Company_ID),
	Name VARCHAR(50),
	Description VARCHAR(100)
	)
	GO

	INSERT INTO Product (Company_ID,Name, Description )VALUES ( 1000000,'electric car','multiple functionality')


-- TABLE SERVICE 
	DROP TABLE IF EXISTS Service
	CREATE TABLE Service
	(
	Service_ID INT NOT NULL PRIMARY KEY IDENTITY(1000000,1) ,
	Name VARCHAR(50),
	Description VARCHAR(100)
	)
	GO

	INSERT INTO Service (Name, Description )VALUES ( 'Sales Parts of automobiles','sale of spare parts')


-- TABLE SERVICE 
	DROP TABLE IF EXISTS Company_Service
	CREATE TABLE Company_Service
	(
	Product_ID INT NOT NULL FOREIGN KEY REFERENCES Company(Company_ID),
	Service_ID INT NOT NULL FOREIGN KEY REFERENCES Service(Service_ID)
	CONSTRAINT PK_Company_Service PRIMARY KEY (Product_ID,Service_ID)
	)
	GO

	INSERT INTO Company_Service VALUES (1000001,1000000)


SELECT * FROM [dbo].[Company]
SELECT * FROM [dbo].[Company_Service]
SELECT * FROM [dbo].[Product]
SELECT * FROM [dbo].[Service]
