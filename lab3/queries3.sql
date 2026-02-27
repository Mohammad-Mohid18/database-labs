/*
-- COUNT: how many rows
SELECT COUNT(*) AS total_orders FROM orders;
-- COUNT on a column: counts non-NULL values only
SELECT COUNT(shipped_date) AS shipped_orders FROM orders;
-- SUM: total value
SELECT SUM(total_amount) AS total_revenue FROM orders;
-- AVG: average value
SELECT AVG(total_amount) AS avg_order_value FROM orders;
-- MIN and MAX: extremes
*/
/*
-- Revenue by order status
SELECT status,
COUNT(*) AS num_orders,
SUM(total_amount) AS total_revenue
FROM orders
GROUP BY status
ORDER BY total_revenue DESC;
-- Average session duration by device
SELECT device,
COUNT(*) AS sessions,
ROUND(AVG(duration_mins), 2) AS avg_duration_mins
FROM user_sessions
GROUP BY device
ORDER BY avg_duration_mins DESC;
*/

/*
SELECT status,
COUNT(*) AS num_orders,
SUM(total_amount) AS total_revenue
FROM orders
WHERE order_date >= '2025-01-01' -- filter rows first
GROUP BY status
HAVING COUNT(*) > 3 -- then filter groups
ORDER BY total_revenue DESC;

SELECT category,
COUNT(*) AS products,
ROUND(AVG(price), 2) AS avg_price
FROM products
GROUP BY category
HAVING AVG(price) > 3000
ORDER BY avg_price DESC;
*/

/*
SELECT customer_id,
order_date,
total_amount,
ROW_NUMBER() OVER (
PARTITION BY customer_id
ORDER BY total_amount DESC
) AS order_rank_by_customer
FROM orders;

-- DENSE_RANK: ties get the same rank, but no gaps in numbering
-- (two at rank 1 means next is rank 2, not rank 3)
SELECT customer_id,
total_amount,
DENSE_RANK() OVER (ORDER BY total_amount DESC) AS dense_rank
FROM orders;
*/

/*
-- Month-over-month revenue comparison using LAG
SELECT TO_CHAR(order_date, 'YYYY-MM') AS month,
SUM(total_amount) AS revenue,
LAG(SUM(total_amount)) OVER (
ORDER BY TO_CHAR(order_date, 'YYYY-MM')
) AS prev_month_revenue
FROM orders
WHERE status = 'delivered'
GROUP BY TO_CHAR(order_date, 'YYYY-MM')
ORDER BY month;
*/



WITH
-- Step 1: Calculate each customer's total spend
customer_spend AS (
    SELECT customer_id,
           SUM(total_amount) AS total_spent,
           COUNT(*) AS num_orders
    FROM orders
    WHERE status = 'delivered'
    GROUP BY customer_id
),

-- Step 2: Classify customers by spend tier
customer_tiers AS (
    SELECT customer_id,
           total_spent,
           num_orders,
           CASE
               WHEN total_spent > 30000 THEN 'VIP'
               WHEN total_spent > 10000 THEN 'Regular'
               ELSE 'Occasional'
           END AS tier
    FROM customer_spend
)

-- Step 3: Count customers and revenue per tier
SELECT tier,
       COUNT(*) AS num_customers,
       SUM(total_spent) AS total_revenue
FROM customer_tiers
GROUP BY tier
ORDER BY total_revenue DESC;
