-- Which month in 2022 has had the highest revenue? October

SELECT 
    month_name AS month, 
    SUM(sale_price - cost_price) AS revenue
FROM 
    forquerying2
WHERE 
    EXTRACT(YEAR FROM TO_DATE(dates, 'YYYY/MM/DD')) = 2022
GROUP BY 
    month
ORDER BY 
    revenue DESC   
LIMIT 1;    


