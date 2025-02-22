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