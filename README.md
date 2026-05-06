# 🍕 Pizza Sales Data Analysis: SQL Data Cleaning & Business Analytics
**Full report with screenshots:** [Download PDF](./Pizza_Sales_Analysis_Report.pdf)

**Tools:** SQL Server, SSMS, SQL

## Project Overview
This end-to-end project demonstrates a complete data workflow in SQL:
- Imported a raw CSV file with format inconsistencies
- Performed all data cleaning and type conversion in SQL
- Answered 18 real-world business questions
- Validated data quality

## Data Cleaning in SQL
The raw CSV had a `DD-MM-YYYY` date format, causing import failures. I solved this by:
1. Importing all columns as `VARCHAR(MAX)`
2. Using `TRY_CONVERT` (with format `105`) and `TRY_CAST` to safely convert data types
3. Validating rows for any conversion failures (none found)
4. Renaming the raw table as an audit backup and promoting the clean table to production

## Key Business Insights
- Classic pizzas generate the highest revenue.
- Friday and Saturday are the busiest revenue days.
- Most orders occur between 12:00-14:00 and 17:00-19:00.
- Pizza sizes L and M dominate sales.

The repo includes the full set of 18 KPIs and analytical queries.

## Files in this Repository
| File | Description |
|------|-------------|
| `01_data_cleaning.sql` | Complete data import and type conversion script |
| `02_analysis_queries.sql` | 18 SQL queries for business insights, data quality, etc. |
|`Pizza_Sales_Analysis_Report.pdf` | Full report with screenshots (Word doc exported to PDF) |
| `pizza_sales_sample.csv` | Sample of the cleaned data (first 100 rows) |

## How to Run This Project
1. Create a new database in SSMS: `CREATE DATABASE PizzaSalesDB;`
2. Run `01_data_cleaning.sql` to import and clean the data.
3. Run `02_analysis_queries.sql` to reproduce all results.

## Skills Demonstrated
- SQL data cleaning: staging tables, `TRY_CAST`, `TRY_CONVERT`, date format handling (105)
- Business analytics: aggregations, `CASE` statements, date/time functions
- Data validation: missing value checks, type conversion validation
- Documentation: clean, readable project structure

## About Me
I'm an aspiring data analyst with a focus on SQL and business intelligence.


