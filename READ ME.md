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