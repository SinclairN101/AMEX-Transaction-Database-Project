/* What are my monthly spending trends compared to my credit card payments, 
and is my spending increasing or decreasing relative to my payments?"
*/

SELECT 
    TO_CHAR(transaction_date, 'YYYY-MM') AS Month,
    SUM(CASE WHEN amount < 0 THEN amount ELSE 0 END) AS  Total_Paid,
    SUM(CASE WHEN amount > 0 THEN amount ELSE 0 END) AS Total_Spent
FROM payment_activity
GROUP BY month
ORDER BY month;