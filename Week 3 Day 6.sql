CREATE TABLE sales (
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

SELECT * FROM sales
--1. Rank Countries by Total Sales
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


--2. Rank Product Categories by Profitability
WITH Category_Rankings AS (
    SELECT 
        item_type, 
        SUM(total_profit) AS Total_Profit,
        SUM(total_revenue) AS Total_Revenue
    FROM sales
    GROUP BY item_type
),
ranked_summary AS (
    SELECT 
        item_type,
        Total_Profit,
        Total_Revenue,
        (Total_Profit / Total_Revenue) * 100 AS Profit_Margin,
        RANK() OVER(ORDER BY Total_Profit DESC) AS Profit_Rank
    FROM Category_Rankings
)
SELECT 
    item_type,
    Total_Profit,
    Total_Revenue,
    Profit_Margin,
    Profit_Rank
FROM ranked_summary
ORDER BY Profit_Rank;


--3. Sales Performance by Month with Running Totals
WITH Monthly_Sales AS (
    SELECT 
        EXTRACT(YEAR FROM order_date) AS Year,
        EXTRACT(MONTH FROM order_date) AS Month,
        SUM(total_revenue) AS Monthly_Revenue,
        SUM(total_profit) AS Monthly_Profit,
        SUM(total_cost) AS Monthly_Cost
    FROM sales
    GROUP BY Year, Month
)
SELECT 
    Year,
    Month,
    Monthly_Revenue,
    Monthly_Profit,
    Monthly_Cost,
    SUM(Monthly_Revenue) OVER(PARTITION BY Year ORDER BY Month) AS Yearly_Revenue,
    SUM(Monthly_Profit) OVER(PARTITION BY Year ORDER BY Month) AS Yearly_Profit,
    SUM(Monthly_Cost) OVER(PARTITION BY Year ORDER BY Month) AS Yearly_Cost
FROM Monthly_Sales
ORDER BY Year, Month;

--4. Top Sales People by Region and Item Type
WITH Sales_region AS (
    SELECT 
        region,
        item_type,
        SUM(total_revenue) AS Total_Revenue,
        SUM(total_profit) AS Total_Profit
    FROM sales
    GROUP BY region, item_type
)
SELECT 
    region,
    item_type,
    Total_Revenue,
    Total_Profit,
    RANK() OVER(PARTITION BY item_type ORDER BY Total_Revenue DESC) AS Item_Type_Rank,
    RANK() OVER(PARTITION BY region ORDER BY Total_Revenue DESC) AS Region_Rank
FROM Sales_region
ORDER BY region, Region_Rank;


--5. Calculate Year-over-Year Growth
WITH Yearly_Sales AS (
    SELECT 
        EXTRACT(YEAR FROM order_date) AS Year,
        SUM(total_revenue) AS Yearly_Revenue,
        SUM(total_profit) AS Yearly_Profit,
        SUM(total_cost) AS Yearly_Cost
    FROM sales
    GROUP BY Year
)
SELECT 
    Year,
    Yearly_Revenue,
    Yearly_Profit,
    Yearly_Cost,
    LAG(Yearly_Revenue) OVER(ORDER BY Year) AS Previous_Year_Revenue,
    (Yearly_Revenue - LAG(Yearly_Revenue) OVER(ORDER BY Year)) / LAG(Yearly_Revenue) OVER(ORDER BY Year) * 100 AS YoY_Revenue_Growth,
    (Yearly_Profit - LAG(Yearly_Profit) OVER(ORDER BY Year)) / LAG(Yearly_Profit) OVER(ORDER BY Year) * 100 AS YoY_Profit_Growth,
    (Yearly_Cost - LAG(Yearly_Cost) OVER(ORDER BY Year)) / LAG(Yearly_Cost) OVER(ORDER BY Year) * 100 AS YoY_Cost_Growth
FROM Yearly_Sales
ORDER BY Year;
















