# Pharm-Data-Analysis-Project


## Introduction 

This project focuses on analyzing sales data using Python and SQLite, integrating data analysis techniques and geospatial visualizations to extract valuable business insights. The dataset includes transactional sales data, customer demographics, product details, and geospatial location data, providing a comprehensive view of sales performance and customer behavior. By leveraging SQLite for database management and Python for data analysis, the project covers a wide range of tasks, from data preprocessing to advanced geospatial mapping.

The objective of the project is to uncover sales trends, identify top-performing products and regions, understand customer purchasing patterns, and visualize the geographic impact on sales. This analysis aims to help the business optimize its operations, target its customer base more effectively, and develop data-driven strategies for future growth.

**Disclaimer**: The datasets used in this report is from 3SIGNET LTD Data Archive and are purely for demonstration purposes and do not represent any specific company, institution or country.



## Contents

1. [Problem Statement](#problem-statement)
2. [Project Overview](#project-overview)
3. [Database Setup](#database-setup)
4. [Data Cleaning](#data-cleaning)
5. [Data Insertion](#data-insertion)
6. [ER Diagram](#er-diagram)
7. [SQL Analysis](#sql-analysis)
8. [Python Analysis and Visualization](#python-analysis-and-visualization) 
9. [Project Results](#project-results)  
10. [Conclusion](#conclusion)


---


### Problem Statement

Businesses face challenges in understanding sales performance due to fragmented data, lack of geographic insights, and limited visibility into customer behavior and product trends. Key issues include:

 - Identifying year-over-year and seasonal sales trends.
 - Analyzing product performance across regions and channels.
 - Understanding customer demographics and channel effectiveness.
 - Managing and cleaning fragmented datasets for accurate analysis.
 - Leveraging visual and geospatial insights to make data-driven decisions.


### Project Overview

This project focuses on analyzing sales data using Python and SQLite to uncover trends, patterns, and actionable insights that drive business decisions. The dataset includes details on sales transactions, products, customer demographics, geographic locations, and sales channels. By combining database management, advanced analytics, and geospatial visualizations, the project provides a comprehensive understanding of sales performance across time, products, regions, and customer segments.

The analysis involved:

- Organized data into structured tables for efficient querying and analysis.
- Merged data from multiple sources, calculated total sales, and cleaned for duplicates and null values.
- Exploratory Data Analysis (EDA):
- Conducted detailed investigations to understand data distribution, identify outliers, and assess relationships between variables.
- Sales Performance Analysis
- Yearly and Monthly Trends 
- Products Performance and Trends
- Geographic Performance
- Customer Demographics and Channel Analysis
- Geospatial Analysis with Python using Geopandas and Plotly


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

WHAT ARE THE TOTAL SALES FOR EACH PRODUCTS??(IDENTIFY THE TOP-SELLING PRODUCTS)

 <img width="463" alt="Total sales for each product" src="https://github.com/user-attachments/assets/5174803d-96b0-4cc8-921a-9f4c74777161">

 Results:


<img width="434" alt="Total sales for each product execution" src="https://github.com/user-attachments/assets/b37b3388-6f5f-4399-8f72-5b4fb633efb2">
 
This data indicates Ionclotide (an analgesic) is the top-selling product with total sales of 169,083,391.0 while Amphensive is the lowest-performing product with total sales of 2,623,450.0. Ionclotide belongs to the analgesics class, which has a consistently high demand due to its wide applicability for managing pain and also may have strong brand recognition, trust among healthcare providers, and favorable distribution channels. Amphensive’s low sales could indicate a lack of broad appeal or that it serves a very niche medical need with limited applications. Lack of awareness among healthcare providers and consumers may limit its sales and also distribution challenges or low availability in key markets could also contribute to poor performance.



HOW DO SALES VARY MONTH BY MONTH WITHIN A SPECIFIC YEAR??(ANALYZE MONTHLY SALES TREND)

<img width="536" alt="Month by month sales" src="https://github.com/user-attachments/assets/338bbbef-4da2-4608-a4e3-7fdffb63313d">

Results:

<img width="208" alt="Month by month execution" src="https://github.com/user-attachments/assets/aae8a338-0f7d-4653-bfe6-3ce356bf9b7f">

According to this data December comes first in terms of total sales, while April comes last. December's position as the highest-selling month indicates a strong demand likely driven by seasonal trends, such as holiday shopping, year-end medical promo, or restocking by distributors. The lower sales in April may be due to fewer events, slower market activity, or customers focusing on other priorities during this period.


Sales by Location

WHICH CITIES HAVE THE HIGHEST SALES??(IDENITY TOP CITIES BY SALES VOLUME)


<img width="465" alt="sales by location" src="https://github.com/user-attachments/assets/1af12301-f87d-44f6-8593-d51fd0f0bff3">

Results:

<img width="447" alt="sales by location execution" src="https://github.com/user-attachments/assets/31958040-ed54-4136-97dc-d8f5e86f7e2a">

Butzbach records the highest total sales of 93,561,780.0 while Szczytno records the lowest total sales of 1,679,772.0. Butzbach may have a high customer density, strong distributor networks, or larger purchasing power. It could also be the retail outlets, pharmacies, or medical institutions contributing to higher sales. Szczytno might represent a smaller market with limited demand or logistics challenges affecting supply.


HOW DO SALES COMPARE ACROSS DIFFERENT COUNTRIES??(SALES PERFORMANCE BY COUNTRY)

<img width="486" alt="location 2 results" src="https://github.com/user-attachments/assets/9052e545-b4c8-48e2-b8d4-924066a6c3b1">

Results:

<img width="411" alt="location 2 " src="https://github.com/user-attachments/assets/f0b7c73c-8162-4f33-b826-4a757c448347">

From this data, Germany is the top-performing country with sales totaling 11,118,107,840.40, Poland ranks the lowest with sales totaling 680,879,801.80. Germany’s high sales reflect a robust healthcare system, strong demand for products, or an established distribution network.The country's larger economy and population compared to Poland may also contribute to this performance. Poland's lower sales could be from limited market size, weaker purchasing power, or different healthcare priorities.

### Customer Segmentation

WHAT IS THE TOTAL SALES BY CUSTOMER TYPE?

<img width="383" alt="customers segmentation 1" src="https://github.com/user-attachments/assets/11b50f04-257c-41df-8b6a-a3ec47706288">


Results:

<img width="520" alt="Customers segmentation 1 results" src="https://github.com/user-attachments/assets/a9027f28-9d4a-49dc-baeb-297ce03d3ddb">

From this data, Pharmacies account for the highest sales of 6,218,312,138.69 and Hospitals record the lowest sales of 5,580,675,503.51. Pharmacies’ dominance may be due to their role in directly serving end-users like patients and their presence in retail locations. Hospitals might purchase fewer products overall or rely on institutional purchasing agreements, leading to less frequent orders.

HOW DO SALES DIFFER ACROSS SECTORS

<img width="434" alt="Customer seg 2" src="https://github.com/user-attachments/assets/fb7a3d8a-59dd-48d4-ae6f-dac921dd3cea">

Results:

<img width="496" alt="customers seg 2 results" src="https://github.com/user-attachments/assets/e97f2daf-7d8f-4f87-8ddc-e8264f087004">

From this data, Retail leads with sales of 3,343,096,900.39, followed by Government 3,058,240,247.95, Institutions 2,875,215,238.30, and Private sectors 2,522,435,255.56. Retail's high sales highlight its direct connection to consumers, making it the primary channel for product distribution, government purchases may reflect public healthcare investments or large institutional contracts.

### Product Analysis

WHAT ARE THE TOP SELLING PRODUCTS WITH EACH DRUG CLASS?

<img width="578" alt="product analysis 1" src="https://github.com/user-attachments/assets/49c6887b-d372-4af1-8975-560971091855">

Results:

<img width="518" alt="product analysis 1 results" src="https://github.com/user-attachments/assets/2425d1cb-77ef-4b1d-a4c1-8e1237355af6">

From this data, Ionclotide (Analgesics) is the top-selling product, while Factofribate (Mood Stabilizer) is the lowest. High sales of analgesics indicate their universal demand for pain relief and could be from its efficacy, brand recognition, or affordability. Lower sales for mood stabilizers could be due to niche demand, higher prices, or competition.

WHAT IS THE AVERAGE PRICE FOR EACH CLASS OF DRUGS?

<img width="351" alt="Product analysis 2" src="https://github.com/user-attachments/assets/b05c84c7-8244-45df-8ffa-ea731b45b27e">

Results:

<img width="338" alt="product analysis 2 results" src="https://github.com/user-attachments/assets/d629727b-b316-47a1-a0bb-e50b1e87c8f9">

Antipyretics have the highest average price of 469, while Anti-malarials have the lowest at 300. Antipyretic Price might reflect advanced formulations, strong demand, or higher production costs. Anti-malarial Price Lower prices might aim to address affordability in malaria-endemic regions.

### Sales Representative Performance

TOP PERFORMING SALES REPS BY TOTAL SALES 

<img width="420" alt="sales performance 1 " src="https://github.com/user-attachments/assets/87e26e89-7d54-46a8-a911-5b9c33a204d3">

Results:

<img width="410" alt="sales performance 1 results" src="https://github.com/user-attachments/assets/4e268079-f63c-4f74-b229-f6e2ab8ca266">

From this data, Jimmy Fret is the top-performing sales representative with total sales of 985,969,993.94 while Alan Ray records the lowest total sales of 84,263,724.20. Jimmy Fret’s Performance could indicate superior sales techniques, customer relationships, or a favorable territory while Alan Ray may face challenges like less favorable territories or smaller accounts.


SALES PERFORMANCE ACROSS DIFFERENT SALES TEAMS?

<img width="398" alt="sales performance 2" src="https://github.com/user-attachments/assets/1e976628-426e-43c7-88ce-4de6e8e2aa12">

Results:

<img width="388" alt="sales performance 2 results" src="https://github.com/user-attachments/assets/bb1811af-b369-408c-a3bb-a511b5d2bf93">

From this data, Delta leads with 3,635,413,331.33, while Alfa lags at 2,580,974,320.38. Delta’s strong performance could result from effective teamwork or operating in high-demand territories while Alfa’s lower performance may require process improvements or team restructuring.

### Time Series Analysis

WHAT IS THE YEAR-OVER-YEAR GROWTH IN TOTAL SALES?

<img width="325" alt="Time series 1" src="https://github.com/user-attachments/assets/1be44983-65c7-4a27-bb93-a17d7ee18e34">

Results:

<img width="304" alt="Time series 1 results" src="https://github.com/user-attachments/assets/64f51361-6de5-43ac-9ffe-4ecc8958ce8a">

From this data, 2018 recorded the highest total sales of 3,506,897,353 while 2020 recorded the lowest sales of 2,659,672,415. 2018’s peak might reflect market expansions or successful product launches. 2020’s dip could be attributed to global disruptions like the COVID-19 pandemic.


WHICH MONTH CONSISTENLY HAVE THE HIGHEST SALES VOLUME??(IDENTIFY SEASONAL SALES PATTERN)

<img width="524" alt="Time series 2 " src="https://github.com/user-attachments/assets/163ca24d-f474-4568-a10a-cf62e6189520">

Results:

<img width="200" alt="Time series 2 resullts" src="https://github.com/user-attachments/assets/53d82fd9-9145-4e18-a175-30ead6e68a90">

From this data, July recorded the highest sales (1,042,536,827), while January recorded the lowest (674,191,145). July’s high sales may align with summer demand, inventory restocking, or promotional campaigns. January often sees reduced activity due to holiday fatigue or budget constraints.














### Recommendation

1. Product Management
Maintain Ionclotide's Momentum:
Focus on strengthening the supply chain, expanding into underperforming markets, and leveraging marketing campaigns to sustain its top position.
Revive Amphensive Sales:
Conduct targeted market research to identify demand gaps and reposition the product through awareness campaigns, strategic pricing, or partnerships. If it remains unprofitable, consider discontinuation.
2. Location-Specific Strategies
Germany and Butzbach:
Invest in maintaining strong distribution networks and increasing product offerings in these locations to maximize revenue.
Poland and Szczytno:
Analyze barriers to sales in these locations, such as logistics, pricing, or product awareness. Develop tailored strategies like promotions or partnerships to improve performance.
3. Customer Segment Focus
Pharmacies:
Continue prioritizing pharmacies as the key revenue drivers. Enhance loyalty programs and provide incentives to encourage bulk purchases.
Hospitals:
Explore partnerships with hospitals to increase orders, possibly by offering discounts or bundling related products.
Retail Sector:
Strengthen marketing and promotional campaigns for retail buyers to maintain dominance in this sector.
4. Sales Team Optimization
Evaluate performance metrics for the Alfa team and provide training or additional resources to address inefficiencies.
Incentivize high-performing teams like Delta to sustain motivation and improve overall sales efficiency.
5. Pricing Strategy
Use the success of antipiretics to optimize pricing across other drug classes. Conduct market analysis to find competitive yet profitable price points for low-priced drugs like anti-malarials.
6. Seasonal and Yearly Planning
Seasonal Trends:
Prepare for increased demand in July by ensuring adequate inventory, logistics, and staffing to capitalize on peak sales.
Annual Trends:
Investigate the factors behind the sales decline in 2020 (e.g., economic downturn, policy changes) and mitigate risks for future periods of uncertainty.






















 
 

### Conclusion
This database project for pharmacy sales data organizes and optimizes transactional information, creating a structured and efficient database. By separating data into dimension tables (such as Distributors, Customers, Products, Locations, DimDate, SalesReps and Channels) and a central fact table (FactSales), we’ve minimized redundancy and ensured relational integrity across the dataset.

The data cleaning steps were essential to ensuring data quality and reliability, handling missing values and correct inconsistencies. These steps allow for accurate analysis and reporting, contributing to better business insights and operational decisions.

The ER diagram further supports understanding and maintaining this structure, illustrating the relationships between each table for both database management and ease of future development. Overall, this project establishes a strong foundation for data-driven decisions, scalable reporting, and further analysis in the pharmacy sales context.

The analysis of sales data across multiple dimensions, including products, locations, customer types, and time periods, provides critical insights into the business's performance:

Top Products:

Ionclotide is the leading product, driving significant sales, while Amphensive is the lowest-performing, requiring strategic attention.
Location Insights:

Germany and Butzbach stand out as the top-performing country and city, respectively. Poland and Szczytno lag behind, highlighting areas for potential improvement.
Customer Segments:

Pharmacies generate the highest revenue among customer types, emphasizing their importance to the business. Hospitals, despite contributing significantly, rank lower in total sales. Across sectors, retail outperforms others, followed by government and institutions.
Drug Classes and Pricing:

Analgesics are the most purchased drug class, with antipiretics having the highest average price. Anti-malarial drugs have the lowest average price, reflecting their economic accessibility.
Sales Team Performance:

Delta is the highest-performing team, while Alfa ranks last, signaling differences in team efficiencies that warrant further investigation.
Time-Series Performance:

The year 2018 recorded the highest total sales, while 2020 saw a decline, potentially due to external factors like economic disruptions. Seasonally, July is the peak month for sales, whereas January is the slowest.









