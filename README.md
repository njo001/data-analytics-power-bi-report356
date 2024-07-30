** Data Analytics Power BI Report **

** Data import **

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

## Milestone 3 info. to refine. 
Create a measure called Total Profit which performs the following calculation:

For each row, subtract the Products[Cost_Price] from the Products[Sale_Price], and then multiply the result by the Orders[Product Quantity]

Total Profit = SUMX(Orders, Orders[Product Quantity] * (Products[Sale Price]-Products[Cost Price]))


Create a measure called Total Customers that counts the number of unique customers in the Orders table. This measure needs to change as the Orders table is filtered, so do not just count the rows of the Customers table!

Total Customers = DISTINCTCOUNT(Orders[Customer ID])



Create a measure called Total Quantity that counts the number of items sold in the Orders table

Total Quantity = SUM(Orders[Product Quantity])


Create a measure called Profit YTD that calculates the total profit for the current year

Profit YTD = TOTALYTD([Total Profit], Orders[Order Date])


Create a measure called Revenue YTD that calculates the total revenue for the current year

Revenue YTD = TOTALYTD([Total Revenue], Orders[Order Date])


one for dates, to facilitate drill-down in your line charts, and one for geography, to allow you to filter our data by region, country and province/state.


Create a date hierarchy using the following levels:

Start of Year
Start of Quarter
Start of Month
Start of Week
Date



Create a new calculated column in the Stores table called Country that creates a full country name for each row, based on the Stores[Country Code] column, according to the following scheme:
GB : United Kingdom
US : United States
DE : Germany

Country = 
IF(Stores[Country Code] = "GB", "United Kingdom",
IF(Stores[Country Code] = "US", "United States",
IF(Stores[Country Code] = "DE", "Germany",
"Other")))


In addition to the country hierarchy, it can sometimes be helpful to have a full geography column, as in some cases this makes mapping more accurate. Create a new calculated column in the Stores table called Geography that creates a full geography name for each row, based on the Stores[Country Region], and Stores[Country] columns, separated by a comma and a space.
