-- Which product category generated the most profit for the "Wiltshire, UK" region in 2021?
-- Homeware

SELECT 
    category,
    SUM(sale_price - cost_price) AS profit
FROM 
    forquerying2
WHERE 
    full_region = 'Wiltshire, UK'
    AND EXTRACT(YEAR FROM TO_DATE(dates, 'YYYY/MM/DD')) = 2021
GROUP BY
    category 
ORDER BY 
    profit DESC   
LIMIT 1;    
