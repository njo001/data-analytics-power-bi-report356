-- Create a view where the rows are the store types and the columns are the total sales, percentage of total sales and the count of orders

CREATE VIEW store_sales AS
SELECT 
    store_type,
    SUM(sale_price * product_quantity) AS total_sales,
    (SUM(sale_price * product_quantity)/ SUM(SUM(sale_price*product_quantity))OVER())*100 AS percentage_total_sales,
    SUM(product_quantity) AS order_count
FROM 
    forquerying2
GROUP BY
    store_type;   


