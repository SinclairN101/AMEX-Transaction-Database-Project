--How often do I use points for purchases, 
--and what is the total value of my redemptions by card type?


SELECT 
    TO_CHAR(transaction_date, 'YYYY-MM') AS Month,
    card_type,  
    SUM(CAST(amount AS NUMERIC)) AS Total_Points_Redeemed,
    COUNT(*) AS Redemption_Count  
FROM temp_payment_activity
WHERE description ILIKE 'Use Points for Purchases'
GROUP BY Month, card_type 
ORDER BY Month, card_type;