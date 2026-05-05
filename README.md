
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
┌─────────────────────────────────────────────────────────────────┐
│ DATA SOURCE │
│ Sample - Superstore.csv │
│ (~10,000 rows) │
└─────────────────────────────┬───────────────────────────────────┘
│
▼
┌─────────────────────────────────────────────────────────────────┐
│ PYTHON ETL SCRIPT │
│ load_to_snowflake_py.py │
│ │
│ • pandas reads CSV │
│ • Column names cleaned (spaces → underscores) │
│ • Batch insert into Snowflake (500 rows/batch) │
└─────────────────────────────┬───────────────────────────────────┘
│
▼
┌─────────────────────────────────────────────────────────────────┐
│ SNOWFLAKE │
│ │
│ ┌─────────────────────────────────────────────────────────┐ │
│ │ RAW LAYER │ │
│ │ superstore_db.raw.orders_raw │ │
│ │ All columns as VARCHAR │ │
│ │ (no transformations, exactly as CSV) │ │
│ └─────────────────────────────┬───────────────────────────┘ │
│ │ │
│ ▼ │
│ ┌─────────────────────────────────────────────────────────┐ │
│ │ CLEAN LAYER │ │
│ │ superstore_db.clean.orders_clean │ │
│ │ │ │
│ │ • TO_DATE() for dates │ │
│ │ • DATEDIFF() for shipping duration │ │
│ │ • CAST() for numbers (DECIMAL, INT) │ │
│ │ • CASE() for profit_status (Profitable/Loss/Break-even)│ │
│ └─────────────────────────────┬───────────────────────────┘ │
│ │ │
│ ▼ │
│ ┌─────────────────────────────────────────────────────────┐ │
│ │ REPORTING LAYER │ │
│ │ │ │
│ │ • regional_summary (region + category aggregates) │ │
│ │ • monthly_trend (time series + cumulative window fn) │ │
│ │ • customer_analysis (RANK, ROW_NUMBER per customer) │ │
│ └─────────────────────────────┬───────────────────────────┘ │
│ │ │
└────────────────────────────────┼─────────────────────────────────┘
│
▼
┌─────────────────────────────────────────────────────────────────┐
│ POWER BI DASHBOARD │
│ │
│ ┌──────────┐ ┌──────────┐ ┌──────────┐ ┌──────────┐ │
│ │ Overview │ │ Regional │ │ Product │ │ Customer │ │
│ │ Page 1 │ │ Page 2 │ │ Page 3 │ │ Page 4 │ │
│ └──────────┘ └──────────┘ └──────────┘ └──────────┘ │
└─────────────────────────────────────────────────────────────────┘


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
