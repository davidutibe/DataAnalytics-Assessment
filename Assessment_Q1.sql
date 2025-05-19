USE adashi_staging;

-- List of customers with at least one savings plan and one investment plan
WITH plans_count AS (
	SELECT
		owner_id,
        COUNT(CASE WHEN is_regular_savings = 1 THEN 1 END) AS savings_count,
        COUNT(CASE WHEN is_a_fund = 1 THEN 1 END) AS investments_count
	FROM
		plans_plan
	GROUP BY
		owner_id
	HAVING
		COUNT(CASE WHEN is_regular_savings = 1 THEN 1 END) > 0
        AND
        COUNT(CASE WHEN is_a_fund = 1 THEN 1 END) > 0
	),
-- Total deposits per customer
desposits_per_customer AS (
	SELECT
		owner_id,
        ROUND(SUM(confirmed_amount/ 100), 2) as total_deposit -- division by 100 to convert from kobo to naira. 
	FROM
		savings_savingsaccount
	GROUP BY
		owner_id
	HAVING
		SUM(confirmed_amount/ 100) > 0 -- filters out customers with zero deposits
	)
-- Joining users with valid plans and deposits
SELECT
	U.id AS owner_id,
    CONCAT(U.first_name, " ", U.last_name) AS name,
    P.savings_count,
    P.investments_count,
    D.total_deposit
FROM
	users_customuser U
	JOIN plans_count P ON U.id = P.owner_id
	JOIN desposits_per_customer D ON U.id = D.owner_id
ORDER BY
	D.total_deposit DESC;
