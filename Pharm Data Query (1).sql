-- DATA STRUCTURE WITH FACTS AND DIMENSIONAL TABLE.
-- FACTS TABLE STORES TRANSACTIONAL DATA WITH FOREIGN KEYS RELATING TO DIMENSION TABLES
-- DIMENSIONAL TABLE STORES ADDITIONAL DATA FOR EACH FACT 
--FACTS TABLE(SALES)
--DIMENSIONAL TABLE(CUSTOMERS, PRODUCTS, LOCATIONS, SALES REP, DATES, CHANNEL)

CREATE TABLE FactSales(
SalesID INTEGER PRIMARY KEY AUTOINCREMENT,
Quantity INT,
Price REAL,
Sales REAL,
ProductID INT REFERENCES Products(ProductID),
CustomerID INT REFERENCES Customers(CustomerID),
DateID INT REFERENCES DimDate(DateID),
LocationID INT REFERENCES Locations(LocationID),
SalesRepID INT REFERENCES SalesReps(SalesRepID),
ChannelID INT REFERENCES Channels(ChannelID)
);
 ALTER TABLE FactSales RENAME TO FactSales_old;

-- DIMENSIONAL TABLE
CREATE TABLE Customers (
    CustomerID INTEGER PRIMARY KEY,
    CustomerName TEXT,
    Distributor TEXT
);

CREATE TABLE Products(
    ProductID INTEGER PRIMARY KEY,
    ProductName TEXT,
    ProductClass TEXT
);
ALTER TABLE Products ADD COLUMN Price REAL;

CREATE TABLE Locations(
    LocationID INTEGER PRIMARY KEY,
    City TEXT,
    Country TEXT,
    Latitude REAL,
    Longitude REAL
);

CREATE TABLE DimDate (
    DateID INTEGER PRIMARY KEY,
    Year INTEGER,
    Month INTEGER
);

CREATE TABLE SalesReps (
    SalesRepID INTEGER PRIMARY KEY,
    NameofSalesRep TEXT,
    Manager TEXT,
    SalesTeam TEXT
);

CREATE TABLE Channels(
    ChannelID INTEGER PRIMARY KEY,
    Channel TEXT,
    SubChannel TEXT
);

-- INSERT DATA INTO DIMENSIONAL TABLES
SELECT * FROM Customers

INSERT INTO Customers(CustomerName, Distributor)
SELECT CustomerName, Distributor
FROM Pharm_Data;

SELECT * FROM Products

INSERT INTO Products(ProductName, ProductClass, Price)
SELECT ProductName, ProductClass, Price
FROM Pharm_Data;

UPDATE Products
SET Price = (SELECT DISTINCT Price 
             FROM Pharm_Data 
             WHERE Pharm_Data.ProductName = Products.ProductName);


SELECT * FROM Locations

INSERT INTO Locations(City, Country, Latitude, Longitude)
SELECT City,Country, Latitude, Longitude
FROM Pharm_Data;

SELECT * FROM DimDate

INSERT INTO DimDate(Year, Month)
SELECT Year, Month
FROM Pharm_Data;

SELECT * FROM SalesReps

INSERT INTO SalesReps(NameofSalesRep, Manager, SalesTeam)
SELECT NameofSalesRep, Manager, SalesTeam
FROM Pharm_Data;

SELECT * FROM Channels

INSERT INTO Channels(Channel, SubChannel)
SELECT Channel, SubChannel
FROM Pharm_Data;

--ADD THE DIMENSION TABLE IT IN THE PHARM DATA 

ALTER TABLE Pharm_Data ADD COLUMN ProductID INTEGER;
ALTER TABLE Pharm_Data ADD COLUMN CustomerID INTEGER;
ALTER TABLE Pharm_Data ADD COLUMN DateID INTEGER;
ALTER TABLE Pharm_Data ADD COLUMN LocationID INTEGER;
ALTER TABLE Pharm_Data ADD COLUMN SalesRepID INTEGER;
ALTER TABLE Pharm_Data ADD COLUMN ChannelID INTEGER;

--UPDATE PHARMA DATA WITH FOREIGN KEY REFERENCES
UPDATE Pharm_Data
SET ProductID = (SELECT ProductID FROM Products 
                 WHERE Pharm_Data.ProductName = Products.ProductName 
                 AND Pharm_Data.ProductClass = Products.ProductClass);
				 
UPDATE Pharm_Data
SET CustomerID = (SELECT CustomerID FROM Customers 
                  WHERE Pharm_Data.CustomerName = Customers.CustomerName 
                  AND Pharm_Data.Distributor = Customers.Distributor);
				  
UPDATE Pharm_Data
SET DateID = (SELECT DateID FROM DimDate 
              WHERE Pharm_Data.Year = DimDate.Year 
              AND Pharm_Data.Month = DimDate.Month);
			  
UPDATE Pharm_Data
SET LocationID = (SELECT LocationID FROM Locations
                  WHERE Pharm_Data.City = Locations.City 
                  AND Pharm_Data.Country = Locations.Country 
                  AND Pharm_Data.Latitude = Locations.Latitude 
                  AND Pharm_Data.Longitude = Locations.Longitude);
				  
UPDATE Pharm_Data
SET SalesRepID = (SELECT SalesRepID FROM SalesReps
                  WHERE Pharm_Data.NameofSalesRep = SalesReps.NameofSalesRep 
                  AND Pharm_Data.Manager = SalesReps.Manager 
                  AND Pharm_Data.SalesTeam = SalesReps.SalesTeam);
				  
UPDATE Pharm_Data
SET ChannelID = (SELECT ChannelID FROM Channels 
                 WHERE Pharm_Data.Channel = Channels.Channel 
                 AND Pharm_Data.SubChannel = Channels.SubChannel);


-- INSERT DATA INTO FACT TABLES
SELECT * FROM FactSales

INSERT INTO FactSales(Quantity, Price, Sales, ProductID, CustomerID, DateID, LocationID, SalesRepID, ChannelID)
SELECT Quantity, Price, Sales, ProductID, CustomerID, DateID, LocationID, SalesRepID, ChannelID
FROM Pharm_Data;

----DATA CLEANING
--HANDLING MISSING VALUES
SELECT * FROM Customers
WHERE CustomerName IS NULL;

SELECT * FROM Customers
WHERE Distributor IS NULL;

SELECT * FROM Products
WHERE ProductName IS NULL;

SELECT * FROM Products
WHERE ProductClass IS NULL;

SELECT * FROM Products
WHERE Price IS NULL;

SELECT * FROM Locations
WHERE City IS NULL;

SELECT * FROM Locations
WHERE Country IS NULL;

SELECT * FROM Locations
WHERE Latitude IS NULL;

SELECT * FROM Locations
WHERE Longitude IS NULL;

SELECT * FROM DimDate
WHERE Year IS NULL;

SELECT * FROM DimDate
WHERE Month IS NULL;

SELECT * FROM SalesReps
WHERE NameofSalesRep IS NULL;

SELECT * FROM SalesReps
WHERE Manager IS NULL;

SELECT * FROM SalesReps
WHERE SalesTeam IS NULL;

SELECT * FROM Channels
WHERE  Channel IS NULL;

SELECT * FROM Channels
WHERE  SubChannel IS NULL;

SELECT * FROM FactSales
WHERE  Quantity IS NULL;

SELECT * FROM FactSales
WHERE  Price IS NULL;

SELECT * FROM FactSales
WHERE Sales IS NULL;

SELECT * FROM FactSales
WHERE ChannelID IS NULL;

--UPDATE MISSPELLED ENTRIES
UPDATE Locations
SET City = REPLACE(City, '?', '')
WHERE City LIKE '%?%';

SELECT * FROM Locations

UPDATE Locations
SET City = REPLACE(City, 'a', 'A')
WHERE City LIKE '%a%';

UPDATE Locations
SET City = LOWER(City);

UPDATE Locations
SET City = UPPER(SUBSTR(City, 1, 1)) || LOWER(SUBSTR(City, 2))
WHERE City IS NOT NULL;

UPDATE Locations
SET City = REPLACE(City, 'ό', 'o')
WHERE City LIKE '%o%';

--REMOVING DUPLICATES
SELECT CustomerName, COUNT(*) as Count
FROM Customers
GROUP BY CustomerName
HAVING COUNT(*) > 1;

DELETE FROM Customers
WHERE rowid NOT IN (
    SELECT MIN(rowid)
    FROM Customers
    GROUP BY CustomerName,Distributor
);

---PHARM DATA SQL DATA ANALYSIS
-- SALES PERFOMANCE ANALYSIS
--WHAT ARE THE TOTAL SALES FOR EACH PRODUCTS??(IDENTIFY THE TOP-SELLING PRODUCTS)
SELECT Products.ProductName, SUM(FactSales.Sales) AS TotalSales
FROM FactSales
JOIN Products ON FactSales.ProductID = Products.ProductID
GROUP BY Products.ProductName
ORDER BY TotalSales DESC;

--HOW DO SALES VARY MONTH BY MONTH WITHIN A SPECIFIC YEAR??(ANALYZE MONTHLY SALES TREND)
SELECT DimDate.Month, SUM(Sales) AS MonthlySales
FROM FactSales
JOIN DimDate ON FactSales.DateID = DimDate.DateID
WHERE Year = 2020 -- Replace with specific year
GROUP BY Month
ORDER BY MonthlySales DESC;


--SALES BY LOCATION 

--WHICH CITIES HAVE THE HIGHEST SALES??(IDENITY TOP CITIES BY SALES VOLUME)
SELECT Locations.City, SUM(FactSales.Sales) AS TotalSales
FROM FactSales
JOIN Locations ON FactSales.LocationID = Locations.LocationID
GROUP BY Locations.City
ORDER BY TotalSales DESC;

--HOW DO SALES COMPARE ACROSS DIFFERENT COUNTRIES??(SALES PERFORMANCE BY COUNTRY)
SELECT Locations.Country, SUM(FactSales.Sales) AS TotalSales
FROM FactSales
JOIN Locations ON FactSales.LocationID = Locations.LocationID
GROUP BY Locations.Country
ORDER BY TotalSales DESC;

--CUSTOMER SEGMENTATION 

--WHAT IS THE TOTAL SALES BY CUSTOMER TYPE?
SELECT Channels.Channel AS CustomerType, SUM(FactSales.Sales) AS TotalSales
FROM FactSales
JOIN Channels ON FactSales.ChannelID = Channels.ChannelID
GROUP BY CustomerType
ORDER BY TotalSales DESC;

--HOW DO SALES DIFFER ACROSS SECTORS
SELECT Channels.SubChannel AS Sector, SUM(FactSales.Sales) AS TotalSales
FROM FactSales
JOIN Channels ON FactSales.ChannelID = Channels.ChannelID 
GROUP BY Sector
ORDER BY TotalSales DESC;

--PRODUCT ANALYSIS

--WHAT ARE THE TOP SELLING PRODUCTS WITH EACH DRUG CLASS?
SELECT Products.ProductClass, Products.ProductName, SUM(FactSales.Sales) AS TotalSales
FROM FactSales
JOIN Products ON FactSales.ProductID = Products.ProductID
GROUP BY Products.ProductClass, Products.ProductName
ORDER BY Products.ProductClass, TotalSales DESC;

--WHAT IS THE AVERAGE PRICE FOR EACH CLASS OF DRUGS
SELECT ProductClass, AVG(Price) AS AveragePrice
FROM Products
GROUP BY ProductClass
ORDER BY AveragePrice;

--SALES REPRESENTATIVE PERFORMANCE

--TOP PERFORMING SALES REPS BY TOTAL SALES 
SELECT SalesReps.NameOfSalesRep, SUM(FactSales.Sales) AS TotalSales
FROM FactSales
JOIN SalesReps ON FactSales.SalesRepID = SalesReps.SalesRepID
GROUP BY SalesReps.NameOfSalesRep
ORDER BY TotalSales DESC;

--SALES PERFORMANCE ACROSS DIFFERENT SALES TEAMS
SELECT SalesReps.SalesTeam, SUM(FactSales.Sales) AS TotalSales
FROM FactSales
JOIN SalesReps ON FactSales.SalesRepID = SalesReps.SalesRepID
GROUP BY SalesReps.SalesTeam
ORDER BY TotalSales DESC;

--TIME SERIES ANALYSIS
--WHAT IS THE YEAR-OVER-YEAR GROWTH IN TOTAL SALES?
SELECT DimDate.Year, SUM(Sales) AS TotalSales
FROM FactSales
JOIN DimDate ON FactSales.DateID = DimDate.DateID
GROUP BY Year
ORDER BY TotalSales;

--WHICH MONTH CONSISTENLY HAVE THE HIGHEST SALES VOLUME??(IDENTIFY SEASONAL SALES PATTERN)
SELECT DimDate.Month, SUM(Sales) AS TotalSales
FROM FactSales
JOIN DimDate ON FactSales.DateID = DimDate.DateID
GROUP BY Month
ORDER BY TotalSales;




















