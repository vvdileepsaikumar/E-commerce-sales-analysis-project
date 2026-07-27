-- Basic Exploration

SELECT COUNT(*) AS total_orders,
       MIN(order_date) AS first_order,
       MAX(order_date) AS last_order
FROM ecommerce_orders;

-- Sales & Profit by Region

SELECT region,
       COUNT(*) AS order_count,
       SUM(sales) AS total_sales,
       SUM(profit) AS total_profit
FROM ecommerce_orders
GROUP BY region
ORDER BY total_sales DESC;

-- Sales by Category

SELECT category,
       SUM(sales) AS total_sales,
       SUM(profit) AS total_profit
FROM ecommerce_orders
GROUP BY category
ORDER BY total_sales DESC;

-- Payment Mode Analysis

SELECT payment_mode,
       COUNT(*) AS total_orders,
       SUM(sales) AS total_sales
FROM ecommerce_orders
GROUP BY payment_mode
ORDER BY total_sales DESC;

-- Top 10 Cities by Sales

SELECT city,
       SUM(sales) AS total_sales
FROM ecommerce_orders
GROUP BY city
ORDER BY total_sales DESC
LIMIT 10;

-- Monthly Sales Trend

SELECT DATE_TRUNC('month', order_date) AS month,
       SUM(sales) AS total_sales,
       SUM(profit) AS total_profit
FROM ecommerce_orders
GROUP BY DATE_TRUNC('month', order_date)
ORDER BY month;

-- Top 10 Orders by Sales

SELECT order_id,
       customer_name,
       category,
       sales,
       profit
FROM ecommerce_orders
ORDER BY sales DESC
LIMIT 10;

-- Average Discount by Category

SELECT category,
       ROUND(AVG(discount),2) AS avg_discount
FROM ecommerce_orders
GROUP BY category
ORDER BY avg_discount DESC;

-- Top 20 Customers by Sales

SELECT customer_name,
       COUNT(*) AS total_orders,
       SUM(sales) AS total_sales
FROM ecommerce_orders
GROUP BY customer_name
ORDER BY total_sales DESC
LIMIT 20;

-- Top Category in Each Region

WITH region_category AS (
SELECT region,
       category,
       SUM(sales) AS total_sales,
       ROW_NUMBER() OVER(PARTITION BY region ORDER BY SUM(sales) DESC) AS rn
FROM ecommerce_orders
GROUP BY region, category
)
SELECT region,
       category,
       total_sales
FROM region_category
WHERE rn = 1;