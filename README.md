# Pharm-Data-Analysis-Project


This project involves setting up a relational database in SQLite to analyze pharmacy sales data. The project includes creating tables, handling data cleaning, generating an ER diagram, and inserting data into fact and dimension tables.

## Contents

1. [Project Overview](#project-overview)
2. [Database Setup](#database-setup)
3. [Data Cleaning](#data-cleaning)
4. [Data Insertion](#data-insertion)
5. [ER Diagram](#er-diagram)

---

### Project Overview

We use a pharmacy sales dataset to:
- Create a normalized database with dimension and fact tables.
- Clean data to ensure integrity by handling nulls, and correcting spelling inconsistencies.
- Generate an ER diagram to visualize relationships.


### Database Setup

The `database_setup.sql` file includes SQL commands to create tables in the SQLite database, including primary keys and foreign keys.

- **Tables Created**:
  - `Distributors`: Stores distributor details.
  - `Customers`: Stores customer details, including city and country.
  - `Products`: Stores product details, including price and product class.
  - `SalesTeams`: Stores sales team information, including sales reps and managers.
  - `FactSales`: Fact table for sales data, with foreign keys referencing the above dimension tables.

#### Script

In `database_setup.sql`:

```sql
-- Database Setup Script

-- 1. Create Distributors Table
CREATE TABLE Distributors (
    DistributorID INTEGER PRIMARY KEY AUTOINCREMENT,
    DistributorName TEXT NOT NULL
);

-- 2. Create Customers Table
CREATE TABLE Customers (
    CustomerID INTEGER PRIMARY KEY AUTOINCREMENT,
    CustomerName TEXT NOT NULL,
    City TEXT,
    Country TEXT,
    Latitude REAL,
    Longitude REAL
);

-- 3. Create Products Table
CREATE TABLE Products (
    ProductID INTEGER PRIMARY KEY AUTOINCREMENT,
    ProductName TEXT NOT NULL,
    ProductClass TEXT,
    Price REAL
);

-- 4. Create SalesTeams Table
CREATE TABLE SalesTeams (
    SalesTeamID INTEGER PRIMARY KEY AUTOINCREMENT,
    SalesRepName TEXT,
    ManagerName TEXT,
    TeamName TEXT
);

-- 5. Create FactSales Table
CREATE TABLE FactSales (
    SalesID INTEGER PRIMARY KEY AUTOINCREMENT,
    DistributorID INTEGER,
    CustomerID INTEGER,
    ProductID INTEGER,
    SalesTeamID INTEGER,
    Quantity INTEGER,
    Sales REAL,
    Month INTEGER,
    Year INTEGER,
    FOREIGN KEY (DistributorID) REFERENCES Distributors (DistributorID),
    FOREIGN KEY (CustomerID) REFERENCES Customers (CustomerID),
    FOREIGN KEY (ProductID) REFERENCES Products (ProductID),
    FOREIGN KEY (SalesTeamID) REFERENCES SalesTeams (SalesTeamID)
);
