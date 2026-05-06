-- Pizza Sales Data Cleaning Script
-- Purpose: Import messy CSV (DD-MM-YYYY dates) and convert to clean, typed table
-- ============================================================

-- Step 1: Create a staging table with all VARCHAR(MAX) columns
-- (Assumes you have already run the Import Flat File wizard into dbo.pizza_sales)

-- Step 2: Create clean table with proper data types
CREATE TABLE dbo.pizza_sales_clean (
    pizza_id INT,
    order_id INT,
    pizza_name_id VARCHAR(50),
    quantity INT,
    order_date DATE,
    order_time TIME,
    unit_price DECIMAL(6,2),
    total_price DECIMAL(8,2),
    pizza_size VARCHAR(50),
    pizza_category VARCHAR(50),
    pizza_ingredients VARCHAR(MAX),
    pizza_name VARCHAR(100)
);

-- Step 3: Convert and insert data safely using TRY_CAST / TRY_CONVERT
INSERT INTO dbo.pizza_sales_clean
SELECT
    TRY_CAST(pizza_id AS INT) AS pizza_id,
    TRY_CAST(order_id AS INT) AS order_id,
    pizza_name_id,
    TRY_CAST(quantity AS INT) AS quantity,
    TRY_CONVERT(DATE, order_date, 105) AS order_date,  -- 105 = dd-mm-yyyy
    TRY_CONVERT(TIME, order_time) AS order_time,
    TRY_CAST(unit_price AS DECIMAL(6,2)) AS unit_price,
    TRY_CAST(total_price AS DECIMAL(8,2)) AS total_price,
    pizza_size,
    pizza_category,
    pizza_ingredients,
    pizza_name
FROM dbo.pizza_sales;  -- source table (all varchar max)

-- Step 4: Validate – check for any conversion failures
SELECT *
FROM dbo.pizza_sales_clean
WHERE pizza_id IS NULL
   OR order_id IS NULL
   OR quantity IS NULL
   OR order_date IS NULL
   OR order_time IS NULL
   OR unit_price IS NULL
   OR total_price IS NULL;

-- Additional validation: find any rows in raw table that failed date conversion
SELECT order_date, pizza_id
FROM dbo.pizza_sales
WHERE TRY_CONVERT(DATE, order_date, 105) IS NULL
  AND order_date IS NOT NULL;

-- Step 5: Rename tables (preserve raw data as backup, promote clean table to production)
EXEC sp_rename 'dbo.pizza_sales', 'pizza_sales_raw';
EXEC sp_rename 'dbo.pizza_sales_clean', 'pizza_sales';

-- Final check: view top 10 rows of cleaned table
SELECT TOP 10 * FROM dbo.pizza_sales;