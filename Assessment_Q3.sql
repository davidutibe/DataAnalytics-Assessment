USE adashi_staging;
-- Categorize all plans as Savings or Investment
WITH plan_type AS (
	SELECT
		id,
        CASE 
			WHEN is_regular_savings = 1 THEN 'Savings'
			WHEN is_a_fund = 1 THEN 'Investment'
		END AS type
        FROM 
			plans_plan),
-- Retrieve the last transaction date
last_customer_transaction AS (
	SELECT
		S.plan_id,
		S.owner_id,
		P.type,
		DATE(MAX(S.transaction_date)) AS last_transaction_date
	FROM 
		savings_savingsaccount S
	JOIN 
		plan_type P ON S.plan_id = P.id
	WHERE
		p.type IS NOT NULL -- Filters out other plans asides savings and investments
	GROUP BY
		s.plan_id,
		s.owner_id,
		p.type
    )
-- Final query to retrieve customers inactive in the last one year (365 days)
SELECT
	plan_id,
	owner_id,
	type,
	last_transaction_date,
    datediff(NOW(), last_transaction_date) AS inactivity_days
FROM 
	last_customer_transaction
WHERE
	datediff(NOW(), last_transaction_date) <= 365
ORDER BY 
	inactivity_days DESC;
