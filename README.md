# Sales-performance-analyzer
A comprehensive sales data analysis solution using PostgreSQL window functions, Excel Power Pivot, and Power BI visualizations to track performance metrics and identify business insights.

## Project Overview

The Sales Performance Analyzer is a comprehensive business intelligence solution that transforms raw sales data into actionable insights. This project demonstrates the use of advanced SQL window functions, Excel Power Pivot with interactive dashboards, and Power BI visualizations to create a complete sales analytics ecosystem.

## Features

- **PostgreSQL Database**: Custom schema with window functions for advanced analysis
- **Excel Power Pivot & Dashboard**: Data modeling with calculated measures and interactive Excel dashboard
- **Power BI Dashboard**: Rich visualizations across multiple analytical dimensions
- **Multi-dimensional Analysis**: Revenue, profitability, regional, product, and time-based metrics

## Technical Components

### 1. PostgreSQL Database & Window Functions

The project begins with a PostgreSQL database that stores comprehensive sales data. Advanced SQL window functions are used to:

- Rank countries by total sales and profitability
- Analyze product category performance with profitability metrics
- Track monthly sales with running totals
- Compare regional and product performance
- Calculate year-over-year growth metrics

Sample queries:
```sql
-- Rank Countries by Total Sales
WITH Countries_Ranking AS (
    SELECT 
        country, 
        SUM(total_revenue) AS Total_Revenue,
        SUM(total_cost) AS Total_Cost,
        SUM(total_profit) AS Total_Profit
    FROM sales
    GROUP BY country
)
SELECT 
    country,
    Total_Revenue,
    Total_Cost,
    Total_Profit,
    RANK() OVER(ORDER BY Total_Revenue DESC) AS Revenue_Rank,
    RANK() OVER(ORDER BY Total_Profit DESC) AS Profit_Rank
FROM Countries_Ranking;
2. Excel Power Pivot & Dashboard
The SQL query results are imported into Excel and processed using Power Pivot to create:

Data Models: Relationships between different data views
Calculated Measures: Custom calculations using DAX formulas
Interactive Dashboard: Excel-based dashboard with:
Product Category Profitability charts
Regional Profit Contribution analysis
Yearly Sales Trend visualization
Top 10 Countries by Revenue
Product Category Performance metrics
The Excel solution provides a familiar interface for business users while leveraging the power of Power Pivot for advanced analytics.

3. Power BI Dashboard
The project also includes a comprehensive Power BI dashboard with multiple analytical pages:

Executive Summary: High-level KPIs and performance metrics
Product Performance: Detailed analysis of product categories and profitability
Regional Analysis: Geographic distribution of sales and performance metrics
Time Intelligence: Period-over-period comparisons and growth trends
Dashboard Highlights
Excel Dashboard
The Excel dashboard features:

Dynamic slicers for filtering by time period, item type and region
Stacked column charts showing product category profitability
Regional contribution analysis with conditional formatting
Yearly sales trend with profit overlay
Interactive top 10 countries ranking
Power BI Dashboard
The Power BI solution includes:

Interactive Filters: Dynamic slicers for time periods, regions, and product categories
Performance Metrics: Revenue, profit, profit margin, and growth indicators
Geographical Visualization: Sales distribution map with regional performance
Time Series Analysis: Monthly trends with YoY comparisons
Product Mix Analysis: Category profitability and volume comparisons
Database Schema
CopyCREATE TABLE sales (
    id SERIAL PRIMARY KEY,
    region VARCHAR(100),
    country VARCHAR(100),
    item_type VARCHAR(100),
    sales_channel VARCHAR(50),
    order_priority CHAR(1),
    order_date DATE,
    order_id BIGINT,
    ship_date DATE,
    units_sold INT,
    unit_price DECIMAL(10,2),
    unit_cost DECIMAL(10,2),
    total_revenue DECIMAL(12,2),
    total_cost DECIMAL(12,2),
    total_profit DECIMAL(12,2)
);
Key Insights
The analysis reveals several important business insights:

Cosmetics and Office Supplies are the most profitable product categories with margins of 39.77% and 19.39% respectively
Sub-Saharan Africa and Europe are the highest revenue-generating regions
Q4 consistently outperforms other quarters in sales volume (43M vs 35-37M in other quarters)
Online sales channels show higher profit margins than offline channels
Year-over-year growth shows positive trends across most product categories with an overall growth of 8.09%
Clothes have the highest profit margin at 67.20% but lower overall revenue compared to other categories
Skills Demonstrated
Advanced SQL window functions and Common Table Expressions (CTEs)
Excel data modeling and Power Pivot
Excel interactive dashboard design
Power BI dashboard development
Data visualization best practices
Business performance analysis
Multi-platform analytics solution design
Setup Instructions
Create a PostgreSQL database and run the schema creation script
Import the sample sales data CSV file
Execute the SQL window function queries
Import the results into Excel and create the Power Pivot model
Build the Excel dashboard using PivotTables, PivotCharts and slicers
Connect the Excel data to Power BI and build the Power BI dashboard
Files in this Repository
/sql/ - SQL scripts for creating database schema and window function queries
/excel/ - Excel workbook with Power Pivot model and interactive dashboard
/powerbi/ - Power BI dashboard file
/data/ - Sample sales data in CSV format
/docs/ - Additional documentation
Future Enhancements
Add predictive analytics models for sales forecasting
Implement automated data refresh pipeline
Create mobile-optimized dashboard version
Add customer demographic analysis
Integrate with real-time sales data
Develop executive KPI scorecard
