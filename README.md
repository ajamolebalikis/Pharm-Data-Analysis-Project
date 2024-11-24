# Pharm-Data-Analysis-Project


This project setting up a relational database in SQLite to analyze pharmacy sales data. The project includes creating tables, handling data cleaning, generating an ER diagram, and inserting data into fact and dimension tables. This project provides an in-depth analysis of pharmacy sales data using SQLite and Python to derive meaningful insights. The analysis focuses on sales trend, customer behaviour and product performance across locations and time.

## Contents

1. [Project Overview](#project-overview)
2. [Database Setup](#database-setup)
3. [Data Cleaning](#data-cleaning)
4. [Data Insertion](#data-insertion)
5. [ER Diagram](#er-diagram)
6. [SQL Analysis](#sql-analysis)
7. [Python Analysis and Visualization](#python-analysis-and-visualization) 
8. [Project Results](#project-results)  
9. [Conclusion](#conclusion)


---

### Project Overview

The purpose of this project is to analyze sales performance and identify product trends by leveraging SQL for querying and Python for advanced data analysis and visualizations.  

We use a pharmacy sales dataset to:
- Create a normalized database with dimension and fact tables.
- Clean data to ensure integrity by handling nulls, and correcting spelling inconsistencies.
- Generate an ER diagram to visualize relationships.
- Analyze total sales for each product to identify top-selling products.
- Understand product trends over time.
- Analyze sales trends by location.
- Perform exploratory data analysis and visualize results.

### Tools Used
SQL: For data extraction and transformation.
Python (Jupyter Notebook): For analysis, data cleaning, and visualization.
Pandas: Data manipulation and transformation.
Matplotlib & Seaborn: Data visualization.
SQLite: For managing and querying the database.



### Database Setup

The `database_setup.sql` file includes SQL commands to create tables in the SQLite database, including primary keys and foreign keys.

- **Tables Created**:
  - `FactSales`: Fact table for sales data, with foreign keys referencing the dimension tables.
  - `Customers`: Stores customer and distributors details.
  - `Products`: Stores product details, including price and product class.
  - `Location`: Stores the city, country, latitude and longitude details.
  - `DimDate`: Stores the date, month and year details.
  - `SalesReps`: Stores sales rep information, including sales reps and managers.
  - `Channels`: Stores the channel and sub channel details.
  
### Data Insertion
Inserting Data into Each Table

Populating Tables: To populate each dimension table (Distributors, Customers, Products, Locations, DimDates, SalesReps and Channels):

For each unique customers, inserted customer and distributor in customers table.

Populate the Products table with each unique product name, class, and price combination.

Populate the locations table with city, country, latitude and logitude.

Populate the Dimdate with year and month.

For each unique sales representative, insert records into SalesTeams with their name, manager, and team.

Populate the channels table with the channel and subchannel data.

Linked Data in FactSales: After filling in the dimension tables, populate FactSales with the transactional data (e.g., quantity, sales, date). For each sale:

Created a foreign key from each dimension table (e.g., DistributorID, CustomerID, ProductID, SalesTeamID) to create a complete record with all relevant data linked by IDs.

### Data Cleaning

Handling Missing Values: Review each table for missing values.
Correcting Inconsistencies: Eensure city names follow the same format, and convert any inconsistently formatted city and country names to a consistent style.

### ER Diagram
Once the tables and relationships are set up, created an ER (Entity-Relationship) diagram to visualize the database structure. This diagram shows how tables relate to each other.

<img width="625" alt="Screenshot 2024-11-10 181521" src="https://github.com/user-attachments/assets/1649eca8-e81f-4e72-a852-badd246049af">

### SQL Analysis
 Sales Performance Analysis
 For the total sales of each products, Ionclotide comes as the first product with the total sales of 169083391.0 and Tetratanyl comes second.
SELECT Products.ProductName, SUM(FactSales.Sales) AS TotalSales
FROM FactSales
JOIN Products ON FactSales.ProductID = Products.ProductID
GROUP BY Products.ProductName
ORDER BY TotalSales DESC;

Monthly Sales Trend
For the monthly sales trend, December was the highest with the total of sales of 306284161.0, November comes second and April comes last.
  SELECT DimDate.Month, SUM(Sales) AS MonthlySales
FROM FactSales
JOIN DimDate ON FactSales.DateID = DimDate.DateID
WHERE Year = 2020 -- Replace with specific year
GROUP BY Month
ORDER BY MonthlySales DESC;

Sales by Location
Identified cities with the highest sales which Butzbach comes the highest with the total sales of 93561780.0  
 
 

### Conclusion
This database project for pharmacy sales data organizes and optimizes transactional information, creating a structured and efficient database. By separating data into dimension tables (such as Distributors, Customers, Products, Locations, DimDate, SalesReps and Channels) and a central fact table (FactSales), we’ve minimized redundancy and ensured relational integrity across the dataset.

The data cleaning steps were essential to ensuring data quality and reliability, handling missing values and correct inconsistencies. These steps allow for accurate analysis and reporting, contributing to better business insights and operational decisions.

The ER diagram further supports understanding and maintaining this structure, illustrating the relationships between each table for both database management and ease of future development. Overall, this project establishes a strong foundation for data-driven decisions, scalable reporting, and further analysis in the pharmacy sales context.








