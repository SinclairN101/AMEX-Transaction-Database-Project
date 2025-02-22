SELECT 
    TO_CHAR(transaction_date, 'YYYY') AS Year,
    SUM(CASE WHEN amount < 0 THEN CAST(amount AS NUMERIC) ELSE 0 END) AS Total_Spent,
    SUM(CASE WHEN amount > 0 THEN CAST(amount AS NUMERIC) ELSE 0 END) AS Total_Paid
FROM payment_activity
GROUP BY Year
ORDER BY Year;