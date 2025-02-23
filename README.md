# 💳 AMEX-Transaction-Database-Project

## 📝 Description

A personal project to build a **PostgreSQL database** from scratch using my own **AMEX transaction data**.

This project covers the **full data pipeline**:
✅ Importing raw data  
✅ Cleaning and transforming it  
✅ Optimizing queries  
✅ Analyzing spending trends

🎯 **Goal**: Gain insights into spending habits while practicing **SQL and database management**.

---

## 🏗️ Project Setup

### 🛢️ Database Schema & Table Creation

#### 📂 `payment_activity` Table

Stores transaction details:

```sql
CREATE TABLE public.payment_activity (
    transaction_date DATE,
    date_processed DATE,
    description TEXT,
    amount NUMERIC(10,2),
    foreign_spend_amount NUMERIC(10,2),
    commission NUMERIC(10,2),
    exchange_rate NUMERIC(10,4),
    merchant TEXT,
    merchant_address TEXT,
    additional_information TEXT,
    card_type TEXT
);
```

🔹 **NUMERIC(10,2)** ensures proper decimal formatting.  
🔹 **Indexes** improve query performance:

```sql
CREATE INDEX idx_transaction_date ON public.payment_activity(transaction_date);
CREATE INDEX idx_merchant ON public.payment_activity(merchant);
CREATE INDEX idx_card_type ON public.payment_activity(card_type);
```

---

## 📥 Data Import & Cleaning

### 🚀 Importing Data

Using the `COPY` command to insert CSV data into PostgreSQL:

```sql
COPY payment_activity FROM '/tmp/AMEX_Transaction_Analysts.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');
```

### ⚠️ Errors I Encountered During This Process & How I Fixed Them

| Issue                                     | Solution                                                  |
| ----------------------------------------- | --------------------------------------------------------- |
| **❌ Permissions Error**                  | I Moveed the file to `/tmp/`                              |
| **❌ Incorrect File Path**                | I Ensure absolute path was correct                        |
| **❌ Currency Formatting Error ($38.21)** | Remove `$` symbol before inserting into the payment table |

🔧 **Fixing Currency Format**:

```sql
SELECT TO_NUMBER(REPLACE(amount, '$', ''), '9999999.99') AS clean_amount
FROM temp_payment_activity;
```

## See more in the Data_Cleaning.sql file.

## 📊 Analysis: Top 10 Merchants

A key analysis in this project is identifying the **top 10 merchants** based on total spending.

### 🔍 SQL Query

```sql
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
```

### 📈 Visualization

Here’s a chart displaying the **Top 10 Merchants by Spending**:

![Top 10 Merchants](<📁 Database Setup & Management/Top_Merchant.png>)

🔹 _Insight:_ I need to cook more!! 🤣

---

## 🚀 Next Steps

✅ Perform deeper analysis on **spending patterns**  
✅ Integrate **Tableau / Looker** for better visualization  
✅ Implement **Machine learning** models for predictive analysis – I will work on this with my Data Scientist friend, but I need to master SQL first before thinking more about this. 🎓

---

## 👨‍💻 Author

📌 **Nathan**  
💬 Have questions or want to contribute? Feel free to reach out! 🚀
