USE adashi_staging;

-- Tenure in months per customer
WITH customer_tenure AS (
	SELECT 
		id,
        CONCAT(first_name, " ", last_name) AS name,
		TIMESTAMPDIFF(MONTH, created_on, NOW()) AS tenure_months
	FROM 
		users_customuser
	),
-- Total Transactions and profit per transaction per customer
customer_transactions AS (
	SELECT
		owner_id,
        COUNT(*) AS total_transactions,
        SUM(confirmed_amount) AS total_amount,
        (SUM(confirmed_amount) / COUNT(*)) * 0.001 AS avg_profit_per_transaction
	FROM
		savings_savingsaccount
	GROUP BY
		owner_id
	)
-- Final Query to estimate CLV (Customer Lifetime Value) per customer
SELECT
	te.id AS customer_id,
    te.name,
    te.tenure_months,
    tr.total_transactions,
    ROUND(tr.total_transactions/NULLIF(te.tenure_months,0) * 12 * avg_profit_per_transaction, 2) AS estimated_clv
FROM
	customer_tenure Te 
JOIN customer_transactions Tr ON Te.id = Tr.owner_id
ORDER BY
	estimated_clv DESC;
 