/*
How much have I spent on international transactions, 
and how do my foreign expenses compare to my total spending over time?
*/

WITH ForeignSpending AS (
    SELECT 
        TO_CHAR(transaction_date, 'YYYY-MM') AS Month,
        SUM(amount) AS Total_Foreign_Spent,
        COUNT(*) AS Foreign_Transactions
    FROM payment_activity
    WHERE foreign_spend_amount IS NOT NULL
    GROUP BY Month
),
TotalSpending AS (
    SELECT 
        TO_CHAR(transaction_date, 'YYYY-MM') AS Month,
        SUM(amount) AS Total_Spent
    FROM payment_activity
    GROUP BY Month
)
SELECT 
    fs.Month,
    fs.Total_Foreign_Spent,
    fs.Foreign_Transactions,
    ts.Total_Spent
FROM ForeignSpending fs
JOIN TotalSpending ts ON fs.Month = ts.Month
ORDER BY fs.Month;