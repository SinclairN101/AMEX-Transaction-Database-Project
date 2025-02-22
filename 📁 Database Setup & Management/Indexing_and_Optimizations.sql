ALTER TABLE public.payment_activity OWNER TO postgres;

CREATE INDEX idx_transaction_date ON public.payment_activity(transaction_date);
CREATE INDEX idx_merchant ON public.payment_activity(merchant);
CREATE INDEX idx_card_type ON public.payment_activity(card_type);