-- 1. Active MRR Calculation by Plan Type
SELECT 
    c.plan_type,
    COUNT(DISTINCT s.customer_id) AS active_customers,
    SUM(s.monthly_price) AS mrr
FROM subscriptions s
JOIN customers c ON s.customer_id = c.customer_id
WHERE s.status = 'Active'
GROUP BY c.plan_type
ORDER BY mrr DESC;

-- 2. Customer Churn Rate Percentage (CTE)
WITH total_customers AS (
    SELECT 
        c.plan_type,
        COUNT(s.subscription_id) AS total_subs,
        SUM(CASE WHEN s.status = 'Cancelled' THEN 1 ELSE 0 END) AS churned_subs
    FROM subscriptions s
    JOIN customers c ON s.customer_id = c.customer_id
    GROUP BY c.plan_type
)
SELECT 
    plan_type,
    total_subs,
    churned_subs,
    ROUND((churned_subs * 100.0 / total_subs), 2) AS churn_rate_percentage
FROM total_customers
ORDER BY churn_rate_percentage DESC;

-- 3. Geographic Customer Revenue Ranking (Window Function)
SELECT 
    c.customer_id,
    c.country,
    c.plan_type,
    SUM(s.monthly_price) AS total_revenue_generated,
    DENSE_RANK() OVER (PARTITION BY c.country ORDER BY SUM(s.monthly_price) DESC) AS rank_in_country
FROM customers c
JOIN subscriptions s ON c.customer_id = s.customer_id
GROUP BY c.customer_id, c.country, c.plan_type;
