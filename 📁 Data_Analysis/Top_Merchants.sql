--Who are my top merchants by total spending, and how do they contribute 
--to my overall expenses?

WITH MerchantSpending AS (
    SELECT 
        merchant, 
        SUM(amount) AS total_spent,
        COUNT(*) AS transaction_count,
        AVG(amount) AS avg_transaction_value
    FROM payment_activity
    GROUP BY merchant
),
TotalSpending AS (
    SELECT SUM(total_spent) AS grand_total FROM MerchantSpending
)
SELECT 
    ms.merchant,
    ms.total_spent,
    ms.transaction_count,
    ms.avg_transaction_value,
    ROUND((ms.total_spent / ts.grand_total) * 100, 2) AS percentage_of_total_spending
FROM MerchantSpending ms
CROSS JOIN TotalSpending ts
ORDER BY ms.total_spent DESC
LIMIT 10;