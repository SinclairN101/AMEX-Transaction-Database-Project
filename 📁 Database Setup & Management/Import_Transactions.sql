COPY payment_activity FROM '/tmp/AMEX_Transaction_Analysts.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');