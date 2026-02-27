/*
SELECT * FROM customers LIMIT 5;
SELECT * FROM products LIMIT 5;
SELECT * FROM orders LIMIT 5;
SELECT * FROM order_items LIMIT 5;
*/

-- ===========================
-- Query: Show customers ordered by latest signup
-- Select specific columns
-- Return each customer's name, city, and signup date. No other columns.
-- ===========================
/*
SELECT name, city, signup_date
FROM customers
ORDER BY signup_date DESC;
*/

-- ===========================
-- Query : Find all orders that have been delivered.
-- ===========================
/*
SELECT order_id, customer_id, total_amount, order_date
FROM orders
WHERE status = 'delivered'
ORDER BY order_date DESC;
*/

-- ===========================
-- Find all products priced between 1000 and 5000 rupees.
-- Write it two ways and confirm both give
-- identical results.
-- ===========================
/*
-- Method A: BETWEEN
SELECT product_name, category, price
FROM products
WHERE price BETWEEN 1000 AND 5000
ORDER BY price;
-- Method B: comparison operators
SELECT product_name, category, price
FROM products
WHERE price >= 1000 AND price <= 5000
ORDER BY price;
*/

-- ===========================
-- Query: List the 10 highest-value orders
-- with their order ID, customer ID, total amount, and status.
-- ===========================
/*
SELECT order_id, customer_id, total_amount, status
FROM orders
ORDER BY total_amount DESC
LIMIT 10;
*/

-- =========================== 
-- Query: Find all delivered orders placed in 2025
-- with a total above 10,000 rupees. Sort by total, highest first.
-- ===========================
/*
SELECT *
FROM orders
WHERE status = 'delivered'
AND order_date >= '2025-01-01'
AND total_amount > 10000
ORDER BY total_amount DESC;
*/

-- ===========================
-- Query: Find all customers who are yahoo users.
-- ===========================
/*
SELECT name, email, city
FROM customers
WHERE email ILIKE '%yahoo%'
ORDER BY name;
*/

-- ===========================
-- Query: Find all orders that have not yet shipped
-- meaning the shipped_date column has no value.
-- ===========================
/*
SELECT order_id, customer_id, order_date, status, total_amount
FROM orders
WHERE shipped_date IS NULL
ORDER BY order_date;
*/

-- ===========================
-- Query: Display each product's name, category, original price,
-- and a discounted price column showing a 20% discount. Also
-- add a column showing the discount amount in rupees.
--  Round both to 2 decimal places.
-- ===========================
/*
SELECT product_name,
category,
price AS original_price,
ROUND(price * 0.80, 2) AS discounted_price,
ROUND(price * 0.20, 2) AS you_save
FROM products
ORDER BY discounted_price DESC;
*/

-- ===========================
-- Query: Find the top 5 highest-value unshipped
-- orders from 2025. Add a column called priority that shows
-- 'URGENT' for orders above 10,000 and 'NORMAL' for the rest.
-- ===========================
/*
SELECT order_id,
customer_id,
total_amount,
order_date,
status,
CASE
WHEN total_amount > 10000 THEN 'URGENT'
ELSE 'NORMAL'
END AS priority
FROM orders
WHERE shipped_date IS NULL
AND order_date >= '2025-01-01'
ORDER BY total_amount DESC
LIMIT 5;
*/

/*
