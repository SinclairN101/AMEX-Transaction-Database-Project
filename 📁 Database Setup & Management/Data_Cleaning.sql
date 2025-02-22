-- Create temp table and insert amounts as text 

CREATE TABLE temp_payment_activity (
    transaction_date DATE,
    date_processed DATE,
    description TEXT,
    amount TEXT,  -- Store as TEXT temporarily
    foreign_spend_amount TEXT,
    commission TEXT,
    exchange_rate TEXT,
    merchant TEXT,
    merchant_address TEXT,
    additional_information TEXT,
    card_type TEXT
);

--Load data as TEXT 

COPY temp_payment_activity FROM '/tmp/AMEX_Transaction_Analysts.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

--- Convert and Insert into Main Table

INSERT INTO payment_activity (
    transaction_date,
    date_processed,
    description,
    amount,
    foreign_spend_amount,
    commission,
    exchange_rate,
    merchant,
    merchant_address,
    additional_information,
    card_type
)
SELECT
    transaction_date,
    date_processed,
    description,
-- Convert text to numeric, remove "$" and fix negative signs
    TO_NUMBER(REPLACE(amount, '$', ''), '9999999.99') AS amount,
    TO_NUMBER(REPLACE(foreign_spend_amount, '$', ''), '9999999.99'),
    TO_NUMBER(REPLACE(commission, '$', ''), '9999999.99'),
    TO_NUMBER(REPLACE(exchange_rate, '$', ''), '9999.9999'),
    merchant,
    merchant_address,
    additional_information,
    card_type
FROM temp_payment_activity;