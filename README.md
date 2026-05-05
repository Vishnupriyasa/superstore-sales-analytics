
# Superstore Sales Analytics
3-layer Snowflake data warehouse + Power BI dashboard for retail sales analytics

**End-to-end data analytics project** using Snowflake, Python, SQL, and Power BI.

Built a 3-layer data warehouse (raw → clean → reporting) to process 10,000+ retail transactions. Connected to Power BI for sales and customer insights.

## Tech Stack
- **Database**: Snowflake
- **ETL**: Python (pandas, snowflake-connector)
- **Transformations**: SQL (CTEs, window functions, CASE statements)
- **Visualization**: Power BI
  
## 🏗️ Architecture

## 🏗️ Architecture

### Data Flow

**Step 1: Data Source**
- Sample - Superstore.csv
- ~10,000 rows, 21 columns

**Step 2: Python ETL Script**
- File: load_to_snowflake_py.py
- pandas reads CSV
- Column names cleaned (spaces → underscores)
- Batch insert into Snowflake (500 rows/batch)

**Step 3: Snowflake — RAW Layer**
- Table: superstore_db.raw.orders_raw
- All columns as VARCHAR
- No transformations, exactly as CSV

**Step 4: Snowflake — CLEAN Layer**
- Table: superstore_db.clean.orders_clean
- TO_DATE() for date conversion
- DATEDIFF() for shipping duration
- CAST() for numbers (DECIMAL, INT)
- CASE() for profit_status (Profitable / Loss / Break-even)

**Step 5: Snowflake — REPORTING Layer**
- Three tables created:
  - regional_summary → region + category aggregates
  - monthly_trend → time series + cumulative window function
  - customer_analysis → RANK, ROW_NUMBER per customer

**Step 6: Power BI Dashboard**
- 4-page connected dashboard
- Page 1: Overview
- Page 2: Regional Performance
- Page 3: Product Analysis
- Page 4: Customer Insights

## 📁 File-by-File Explanation

| File | Purpose | Key Details |
|------|---------|-------------|
| `Sample - Superstore.csv` | Raw dataset | 10,000+ rows, 21 columns (Order ID, Sales, Profit, Category, etc.) |
| `load_to_snowflake_py.py` | Python ETL script | Reads CSV with pandas → batch inserts into Snowflake RAW table |
| `sql_clean_layer.sql` | Data cleaning SQL | Converts VARCHAR to proper types, adds `days_to_ship`, `profit_status` |
| `sql_reporting_layer.sql` | Aggregation SQL | Creates 3 tables with window functions (RANK, ROW_NUMBER, SUM OVER) |
| `Power BI Dashboard Screenshots.docx` | Screenshots of the powerbi dashboards |
| `.gitignore` | Git config | Prevents uploading credentials, CSV duplicates, Python cache |
| `README.md` | This file | Project documentation |
