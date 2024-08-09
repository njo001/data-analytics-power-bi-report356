## Data Analytics Power BI Report ##

## Data import ##

1. Fact table: Orders 
    - Contains 
        - order and shipping dates
        - the customer
        - store and product IDs 
        - amount of each product ordered
    Each order in this table consists of an order of a single product type, so there is only one product code per order.

Connect to the Azure SQL Database and import the orders_powerbi table using the Import option in Power BI. 
Transformations: Order and shipping dates columns split to date and time. 

2. Dimension table: Products
    - Contains
        - product code
        - name
        - category
        - cost price
        - sale price
        - weight
.CSV import from local machine. Duplicates removed from product code column. 

3. Dimension table: Stores
    - Contains
        - store code
        - store type
        - country
        - region
        - address
Connect Azure blob storage. Columns renames in title case. 

4. Dimension table: Customer
    - Contains
        - customer names
        - customer contacts
        - custome regions
One file per region (3), imported through folder, combine and transform. 

## Data Model

### Star Schema Relationships
- **Products[product_code]** to **Orders[product_code]**
- **Stores[store_code]** to **Orders[store_code]**
- **Customers[User_UUID]** to **Orders[User_ID]**
- **Date[date]** to **Orders[Order_Date]**
- **Date[date]** to **Orders[Shipping_Date]**

### Active Relationships
- Ensure the relationship between **Orders[Order_Date]** and **Date[date]** is active.
- All relationships are one-to-many with a single filter direction from dimension tables to the fact table.

### Measures Table
- **Creation**: Create a new blank table named `Measures Table` in the Data Model View.
- **Measures**:
  - **Total Orders**: Counts the number of orders in the Orders table.
  - **Total Revenue**: Multiplies `Orders[Product_Quantity]` by `Products[Sale_Price]` for each row, then sums the result.
  - **Total Profit**: `(Products[Sale_Price] - Products[Cost_Price]) * Orders[Product_Quantity]`, summed for all rows.
  - **Total Customers**: Counts the number of unique customers in the Orders table.
  - **Total Quantity**: Counts the number of items sold in the Orders table.
  - **Profit YTD**: `TOTALYTD([Total Profit], Orders[Order Date])`
  - **Revenue YTD**: `TOTALYTD([Total Revenue], Orders[Order Date])`

### Date Table
- **Creation**: Continuous date table from the earliest `Orders[Order Date]` to the latest `Orders[Shipping Date]`.
- **Columns**: Day of Week, Month Number, Month Name, Quarter, Year, Start of Year, Start of Quarter, Start of Month, Start of Week.

### Hierarchies
- **Date Hierarchy**: Start of Year, Start of Quarter, Start of Month, Start of Week, Date.
- **Geography Hierarchy**: World Region, Country, Country Region.

### Calculated Columns
- **Stores[Country]**: 
  ```DAX
  Country = 
  IF(Stores[Country_Code] = "GB", "United Kingdom",
  IF(Stores[Country_Code] = "US", "United States",
  IF(Stores[Country_Code] = "DE", "Germany",
  "Other")))
  ```
- **Stores[Geography]**: 
  ```DAX
  Geography = Stores[Country_Region] & ", " & Stores[Country]
  ```

## Report Pages

### 1. Executive Summary
- **KPIs**: Quarterly Revenue, Orders, and Profit.
- **Visuals**: KPIs for previous quarter metrics, targets with 5% growth, line charts, and top products table.

### 2. Customer Detail
- **Visuals**: Headline cards, Donut Chart for total customers by country, Column Chart for customers by product category, Line Chart for customers over time, top customers table with data bars, insights cards for top customer, date slicer.

### 3. Product Detail
- **Visuals**: Product descriptions, revenue, customer count, order count, profit per order, slicer toolbar for product category and country.

### 4. Stores Map
- **Visuals**: Map visual with geography hierarchy and Profit YTD bubbles, country slicer, drill-through page for store performance, top products table, column chart, profit gauges, store card, custom tooltip for profit gauge.

## Cross Filtering
- **Executive Summary Page**: Product Category bar chart and Top 10 Products table do not filter card visuals or KPIs.
- **Customer Detail Page**: Top 20 Customers table does not filter other visuals; Total Customers by Product Donut Chart does not affect Customers line graph; Total Customers by Country donut chart cross-filters Total Customers by Product donut Chart.
- **Product Detail Page**: Orders vs. Profitability scatter graph and Top 10 Products table do not affect other visuals.

## Navigation Bar
- **Buttons**: Custom icons for each report page with hover effects.
- **Actions**: Page navigation for each button.
- **Grouping**: Buttons grouped and copied across all pages.

### SQL Queries for Non-Power BI Users

For users who do not have access to Power BI, the following SQL queries were written to answer specific questions about the dataset. The results of these queries were exported as CSV files and are available in the GitHub repository along with the corresponding SQL query files.

#### 1. How many staff are there in all of the UK stores?
A query was created to count the total number of staff employed in all stores located in the United Kingdom. 

#### 2. Which month in 2022 had the highest revenue?
A query was written to determine the month in the year 2022 with the highest revenue. This involved aggregating sales data by month and identifying the month with the maximum revenue. 

#### 3. Which German store type had the highest revenue for 2022?
A query was developed to find out which type of store in Germany generated the most revenue in 2022. The revenue data was aggregated by store type, and the type with the highest revenue was identified. 

#### 4. Created a view.
A view was created to display store types with corresponding columns for total sales, percentage of total sales, and the count of orders. This view provided a summary of sales performance by store type. 

#### 5. Which product category generated the most profit for the "Wiltshire, UK" region in 2021?
A query was executed to identify which product category generated the highest profit in the "Wiltshire, UK" region for the year 2021. 
