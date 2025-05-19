USE adashi_staging;	

-- Aggregation of month
WITH avg_monthly_transactions as (
	SELECT 
		owner_id,
		AVG(monthly_transactions) as avg_monthly_transactions_per_customer
	FROM (
		SELECT 	
			U.id AS owner_id,
			DATE_FORMAT(transaction_date, '%Y-%m') AS month,
			COUNT(s.transaction_reference) AS monthly_transactions
		FROM 
			users_customuser U
		JOIN 
			savings_savingsaccount S on U.id = S.owner_id
		GROUP BY
			U.id,
			DATE_FORMAT(transaction_date, '%Y-%m')
		) AS transactions_per_month  -- subquery calculates total transactions per month
	GROUP BY owner_id
	),             
-- Categorization of each customer based on their monthly purchase frequency
categorization_per_customer AS (
	SELECT 
		owner_id,
		avg_monthly_transactions_per_customer,
		CASE
			WHEN avg_monthly_transactions_per_customer >= 10 THEN 'High Frequency'
			WHEN avg_monthly_transactions_per_customer BETWEEN 3 AND 9 THEN 'Medium Frequency'
			ELSE 'Low Frequency'
		END AS frequency_category
	FROM avg_monthly_transactions
	GROUP BY 
		owner_id
	)
-- Final query to count customers within each purchase frequency
SELECT
	frequency_category,
    COUNT(*) AS customer_count,
    ROUND(AVG(avg_monthly_transactions_per_customer), 2) AS avg_transaction_per_month
FROM
	categorization_per_customer
GROUP BY
	frequency_category;
