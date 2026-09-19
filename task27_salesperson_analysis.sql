-- Task 27: Salesperson Performance Analysis
-- SQLite-compatible SQL
-- Dataset: superstore_sales_clean.csv
-- Salesperson assignments are included in the working dataset.

DROP TABLE IF EXISTS superstore;
CREATE TABLE superstore (
    row_id INTEGER,
    order_id TEXT,
    order_date DATE,
    ship_date DATE,
    ship_mode TEXT,
    customer_id TEXT,
    salesperson TEXT,
    segment TEXT,
    country TEXT,
    city TEXT,
    state TEXT,
    postal_code INTEGER,
    region TEXT,
    product_id TEXT,
    category TEXT,
    sub_category TEXT,
    product_name TEXT,
    sales REAL,
    quantity INTEGER,
    discount REAL,
    profit REAL
);

-- Import the CSV using your SQL client. Example for SQLite CLI:
-- .mode csv
-- .import superstore_sales_clean.csv superstore

-- 1) Overall KPIs
SELECT ROUND(SUM(sales),2) AS total_sales,
       ROUND(SUM(profit),2) AS total_profit,
       ROUND(SUM(profit)/SUM(sales)*100,2) AS profit_margin_pct,
       COUNT(DISTINCT order_id) AS total_orders,
       ROUND(SUM(sales)/COUNT(DISTINCT order_id),2) AS avg_order_value
FROM superstore;

-- 2) Salesperson performance
SELECT salesperson,
       region AS territory,
       ROUND(SUM(sales),2) AS sales,
       ROUND(SUM(profit),2) AS profit,
       COUNT(DISTINCT order_id) AS orders,
       ROUND(SUM(sales)/COUNT(DISTINCT order_id),2) AS avg_order_value,
       ROUND(SUM(profit)/SUM(sales)*100,2) AS profit_margin_pct
FROM superstore
GROUP BY salesperson, region
ORDER BY profit DESC;

-- 3) 2017 vs 2016 growth
WITH annual AS (
    SELECT salesperson,
           SUM(CASE WHEN strftime('%Y',order_date)='2016' THEN sales ELSE 0 END) AS sales_2016,
           SUM(CASE WHEN strftime('%Y',order_date)='2017' THEN sales ELSE 0 END) AS sales_2017
    FROM superstore
    GROUP BY salesperson
)
SELECT salesperson,
       ROUND(sales_2016,2) AS sales_2016,
       ROUND(sales_2017,2) AS sales_2017,
       ROUND((sales_2017-sales_2016)/NULLIF(sales_2016,0)*100,2) AS growth_pct
FROM annual
ORDER BY growth_pct DESC;

-- 4) Territory comparison
SELECT region,
       ROUND(SUM(sales),2) AS sales,
       ROUND(SUM(profit),2) AS profit,
       COUNT(DISTINCT order_id) AS orders,
       ROUND(SUM(sales)/COUNT(DISTINCT order_id),2) AS aov,
       ROUND(AVG(discount)*100,2) AS avg_discount_pct,
       ROUND(SUM(profit)/SUM(sales)*100,2) AS profit_margin_pct
FROM superstore
GROUP BY region
ORDER BY sales DESC;

-- 5) Category / sub-category profitability
SELECT category, sub_category,
       ROUND(SUM(sales),2) AS sales,
       ROUND(SUM(profit),2) AS profit,
       ROUND(AVG(discount)*100,2) AS avg_discount_pct,
       ROUND(SUM(profit)/SUM(sales)*100,2) AS margin_pct
FROM superstore
GROUP BY category, sub_category
ORDER BY profit ASC;

-- 6) Discount vs profit
SELECT
    CASE
      WHEN discount=0 THEN '0%'
      WHEN discount<=0.10 THEN '1-10%'
      WHEN discount<=0.20 THEN '11-20%'
      WHEN discount<=0.40 THEN '21-40%'
      ELSE '41%+'
    END AS discount_band,
    COUNT(*) AS line_items,
    ROUND(SUM(sales),2) AS sales,
    ROUND(SUM(profit),2) AS profit,
    ROUND(SUM(profit)/SUM(sales)*100,2) AS margin_pct
FROM superstore
GROUP BY discount_band
ORDER BY MIN(discount);

-- 7) Loss-making salesperson lines
SELECT salesperson, region,
       COUNT(*) AS loss_lines,
       ROUND(SUM(sales),2) AS loss_line_sales,
       ROUND(SUM(profit),2) AS loss_profit
FROM superstore
WHERE profit < 0
GROUP BY salesperson, region
ORDER BY loss_profit ASC;

-- 8) Top products by profit
SELECT product_name, category, sub_category,
       ROUND(SUM(sales),2) AS sales,
       ROUND(SUM(profit),2) AS profit
FROM superstore
GROUP BY product_name, category, sub_category
ORDER BY profit DESC
LIMIT 10;
