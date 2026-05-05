-- ========================================
-- SUPERSTORE SALES ANALYTICS
-- Reporting Layer SQL Script
-- ========================================

USE SCHEMA superstore_db.reporting;

-- TABLE 1: Regional Summary
CREATE TABLE regional_summary AS
SELECT
    region,
    category,
    COUNT(DISTINCT order_id)        AS total_orders,
    SUM(sales)                      AS total_sales,
    SUM(profit)                     AS total_profit,
    ROUND(AVG(discount) * 100, 2)   AS avg_discount_pct,
    ROUND(SUM(profit)/SUM(sales)*100, 2) AS profit_margin_pct
FROM superstore_db.clean.orders_clean
GROUP BY region, category
ORDER BY total_sales DESC;

-- TABLE 2: Monthly Trend
CREATE TABLE monthly_trend AS
SELECT
    DATE_TRUNC('month', order_date)  AS order_month,
    region,
    SUM(sales)                       AS monthly_sales,
    SUM(profit)                      AS monthly_profit,
    COUNT(DISTINCT order_id)         AS order_count,
    
    -- Cumulative sales with window function
    SUM(SUM(sales)) OVER (
        PARTITION BY region 
        ORDER BY DATE_TRUNC('month', order_date)
    ) AS cumulative_sales_by_region

FROM superstore_db.clean.orders_clean
GROUP BY DATE_TRUNC('month', order_date), region
ORDER BY order_month;

-- TABLE 3: Customer Analysis
CREATE TABLE customer_analysis AS
SELECT
    customer_id,
    customer_name,
    segment,
    region,
    COUNT(DISTINCT order_id)    AS total_orders,
    SUM(sales)                  AS total_spent,
    SUM(profit)                 AS total_profit_generated,
    MIN(order_date)             AS first_order_date,
    MAX(order_date)             AS last_order_date,
    
    -- Rank customer by spend within segment
    RANK() OVER (
        PARTITION BY segment 
        ORDER BY SUM(sales) DESC
    ) AS rank_in_segment,
    
    -- Row number per customer
    ROW_NUMBER() OVER (
        PARTITION BY customer_id 
        ORDER BY MIN(order_date)
    ) AS customer_order_sequence

FROM superstore_db.clean.orders_clean
GROUP BY customer_id, customer_name, segment, region;

-- Verify all tables
SELECT 'regional_summary' AS table_name, COUNT(*) AS rows FROM regional_summary
UNION ALL
SELECT 'monthly_trend', COUNT(*) FROM monthly_trend
UNION ALL
SELECT 'customer_analysis', COUNT(*) FROM customer_analysis;