-- ============================================================
-- Pizza Sales Analytical Queries
-- 18 business questions with answers
-- ============================================================

-- A. KPI's

-- 1. Total Revenue
SELECT SUM(total_price) AS Total_Revenue FROM pizza_sales;

-- 2. Total Revenue by Pizza Category
SELECT pizza_category, SUM(total_price) AS category_revenue
FROM pizza_sales
GROUP BY pizza_category
ORDER BY category_revenue DESC;

-- 3. Total Revenue by Month
SELECT YEAR(order_date) AS order_year,
       MONTH(order_date) AS order_month,
       SUM(total_price) AS monthly_revenue
FROM pizza_sales
GROUP BY YEAR(order_date), MONTH(order_date)
ORDER BY order_year, order_month;

-- 4. Average Order Value
SELECT SUM(total_price) / COUNT(DISTINCT order_id) AS avg_order_value
FROM pizza_sales;

-- 5. Total Pizzas Sold
SELECT SUM(quantity) AS total_pizza_sold FROM pizza_sales;

-- 6. Total Orders
SELECT COUNT(DISTINCT order_id) AS total_orders FROM pizza_sales;

-- 7. Average Pizzas Per Order
SELECT SUM(quantity) * 1.0 / COUNT(DISTINCT order_id) AS avg_pizzas_per_order
FROM pizza_sales;

-- B. Product & Sales Analysis

-- 8. Best-Selling Pizza (by quantity)
SELECT pizza_name, SUM(quantity) AS total_sold
FROM pizza_sales
GROUP BY pizza_name
ORDER BY total_sold DESC;

-- 9. Peak Order Hours
SELECT DATEPART(HOUR, order_time) AS hour_of_day,
       COUNT(DISTINCT order_id) AS order_count
FROM pizza_sales
GROUP BY DATEPART(HOUR, order_time)
ORDER BY order_count DESC;

-- 10. Revenue by Pizza Size
SELECT pizza_size, SUM(total_price) AS size_revenue
FROM pizza_sales
GROUP BY pizza_size
ORDER BY size_revenue DESC;

-- 11. Most Popular Pizza by Size and Category (ranked within category)
SELECT pizza_category, pizza_size, SUM(quantity) AS qty_sold
FROM pizza_sales
GROUP BY pizza_category, pizza_size
ORDER BY pizza_category, qty_sold DESC;

-- 12. Bottom 3 Pizzas by Revenue
SELECT TOP 3 pizza_name, SUM(total_price) AS revenue
FROM pizza_sales
GROUP BY pizza_name
ORDER BY revenue ASC;

-- 13. Daily Sales Trend (Revenue by Day of Week)
SELECT DATENAME(WEEKDAY, order_date) AS day_name,
       SUM(total_price) AS daily_revenue
FROM pizza_sales
GROUP BY DATENAME(WEEKDAY, order_date)
ORDER BY daily_revenue DESC;

-- 14. High-Value Orders (Top 5 by total spending)
SELECT TOP 5 order_id, SUM(total_price) AS order_total
FROM pizza_sales
GROUP BY order_id
ORDER BY order_total DESC;

-- 15. What Did the Largest Order Contain? (example: order_id 18845)
SELECT pizza_name, quantity, total_price
FROM pizza_sales
WHERE order_id = 18845;

-- C. Data Quality & Distribution

-- 16. Missing Values Check
SELECT
    COUNT(CASE WHEN order_id IS NULL THEN 1 END) AS missing_order_id,
    COUNT(CASE WHEN order_date IS NULL THEN 1 END) AS missing_order_date,
    COUNT(CASE WHEN order_time IS NULL THEN 1 END) AS missing_order_time,
    COUNT(CASE WHEN pizza_name IS NULL THEN 1 END) AS missing_pizza_name,
    COUNT(CASE WHEN quantity IS NULL THEN 1 END) AS missing_quantity,
    COUNT(CASE WHEN total_price IS NULL THEN 1 END) AS missing_total_price
FROM pizza_sales;

-- 17. Order Size Distribution
SELECT order_size, COUNT(*) AS number_of_orders
FROM (
    SELECT order_id, SUM(quantity) AS order_size
    FROM pizza_sales
    GROUP BY order_id
) AS order_totals
GROUP BY order_size
ORDER BY order_size;

-- 18. Pizza Popularity by Hour (Lunch vs. Dinner)
SELECT
    CASE
        WHEN DATEPART(HOUR, order_time) BETWEEN 12 AND 14 THEN 'Lunch'
        WHEN DATEPART(HOUR, order_time) BETWEEN 17 AND 19 THEN 'Dinner'
        ELSE 'Other'
    END AS meal_period,
    pizza_name,
    SUM(quantity) AS total_sold
FROM pizza_sales
WHERE DATEPART(HOUR, order_time) BETWEEN 12 AND 14
   OR DATEPART(HOUR, order_time) BETWEEN 17 AND 19
GROUP BY
    CASE
        WHEN DATEPART(HOUR, order_time) BETWEEN 12 AND 14 THEN 'Lunch'
        WHEN DATEPART(HOUR, order_time) BETWEEN 17 AND 19 THEN 'Dinner'
        ELSE 'Other'
    END,
    pizza_name
ORDER BY meal_period, total_sold DESC;