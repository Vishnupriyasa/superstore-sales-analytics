-- ========================================
-- SUPERSTORE SALES ANALYTICS
-- Clean Layer SQL Script
-- ========================================

-- Use clean schema
USE SCHEMA superstore_db.clean;

-- Create clean table with proper data types
CREATE TABLE orders_clean AS
SELECT
    ROW_ID,
    ORDER_ID,
    
    -- Date conversion
    TO_DATE(ORDER_DATE, 'MM/DD/YYYY')   AS order_date,
    TO_DATE(SHIP_DATE,  'MM/DD/YYYY')   AS ship_date,
    
    -- Calculated column
    DATEDIFF('day', 
             TO_DATE(ORDER_DATE, 'MM/DD/YYYY'), 
             TO_DATE(SHIP_DATE,  'MM/DD/YYYY'))  AS days_to_ship,
    
    SHIP_MODE,
    CUSTOMER_ID,
    CUSTOMER_NAME,
    SEGMENT,
    CITY,
    STATE,
    REGION,
    CATEGORY,
    SUB_CATEGORY,
    PRODUCT_NAME,
    
    -- Type conversion
    CAST(SALES    AS DECIMAL(10,2)) AS sales,
    CAST(QUANTITY AS INT)           AS quantity,
    CAST(DISCOUNT AS DECIMAL(5,2))  AS discount,
    CAST(PROFIT   AS DECIMAL(10,2)) AS profit,
    
    -- Derived columns
    CAST(SALES AS DECIMAL(10,2)) * CAST(QUANTITY AS INT) AS revenue,
    
    CASE 
        WHEN CAST(PROFIT AS DECIMAL(10,2)) > 0 THEN 'Profitable'
        WHEN CAST(PROFIT AS DECIMAL(10,2)) = 0 THEN 'Break-even'
        ELSE 'Loss'
    END AS profit_status

FROM superstore_db.raw.orders_raw
WHERE ORDER_ID IS NOT NULL
  AND SALES IS NOT NULL;

-- Verify
SELECT COUNT(*) FROM orders_clean;
SELECT * FROM orders_clean LIMIT 5;