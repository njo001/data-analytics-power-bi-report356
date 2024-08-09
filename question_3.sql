-- Which German store type had the highest revenue for 2022? Local   

SELECT
    store_type,
    SUM(sale_price - cost_price) AS revenue
FROM 
    forquerying2
WHERE 
    country = 'Germany' 
    AND EXTRACT(YEAR FROM TO_DATE(dates, 'YYYY/MM/DD')) = 2022
GROUP BY
    store_type
ORDER BY 
    revenue DESC
LIMIT 1;