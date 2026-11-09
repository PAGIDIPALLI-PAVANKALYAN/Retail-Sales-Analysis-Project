CREATE DATABASE retail_sales_analysis;

USE retail_sales_analysis;

select * from retail_sales;

#total records:
select count(*) as Total_records from retail_sales;
select* from retail_sales limit 10;

#column name change:
alter table retail_sales rename column ï»¿Transaction_ID to Transaction_ID;

#Calculate business KPIs using SQL;
SELECT
    SUM(Sales_Amount_INR) AS Total_Revenue,
    SUM(Profit_INR) AS Total_Profit,
    SUM(Total_Cost_INR) AS Total_Cost,
    COUNT(DISTINCT Transaction_ID) AS Total_Transactions,
    SUM(Quantity) AS Total_Units_Sold,
    ROUND(
        SUM(Sales_Amount_INR) /
        COUNT(DISTINCT Transaction_ID), 2
    ) AS Average_Transaction_Value,
    ROUND(
        SUM(Profit_INR) /
        SUM(Sales_Amount_INR) * 100, 2
    ) AS Profit_Margin
FROM retail_sales;

# Monthly Revenue Trend (2024 vs 2025):
SELECT
    YEAR(Order_Date) AS Sales_Year,
    MONTH(Order_Date) AS Month_Number,
    MONTHNAME(Order_Date) AS Month_Name,
    ROUND(SUM(Sales_Amount_INR), 2) AS Total_Revenue,
    ROUND(SUM(Profit_INR), 2) AS Total_Profit,
    COUNT(DISTINCT Transaction_ID) AS Total_Transactions
FROM retail_sales
GROUP BY
    YEAR(Order_Date),
    MONTH(Order_Date),
    MONTHNAME(Order_Date)
ORDER BY
    Sales_Year,
    Month_Number;
    
# Top 10 Products by Revenue:
SELECT
    Product,
    SUM(Quantity) AS Total_Units_Sold,
    ROUND(SUM(Sales_Amount_INR), 2) AS Total_Revenue,
    ROUND(SUM(Profit_INR), 2) AS Total_Profit
FROM retail_sales
GROUP BY Product
ORDER BY Total_Revenue DESC
LIMIT 10;

# Regional Profitability Analysis:
SELECT
    Region,
    COUNT(DISTINCT Transaction_ID) AS Total_Transactions,
    SUM(Quantity) AS Total_Units_Sold,
    ROUND(SUM(Sales_Amount_INR), 2) AS Total_Revenue,
    ROUND(SUM(Profit_INR), 2) AS Total_Profit,
    ROUND(
        SUM(Profit_INR) / SUM(Sales_Amount_INR) * 100, 2
    ) AS Profit_Margin
FROM retail_sales
GROUP BY Region
ORDER BY Total_Profit DESC;

# Customer Segment Analysis:
SELECT
    Customer_Segment,
    COUNT(DISTINCT Customer_ID) AS Total_Customers,
    COUNT(DISTINCT Transaction_ID) AS Total_Transactions,
    SUM(Quantity) AS Total_Units_Sold,
    ROUND(SUM(Sales_Amount_INR), 2) AS Total_Revenue,
    ROUND(SUM(Profit_INR), 2) AS Total_Profit
FROM retail_sales
GROUP BY Customer_Segment
ORDER BY Total_Revenue DESC;

# Sales Channel Analysis:
SELECT
    Sales_Channel,
    COUNT(DISTINCT Transaction_ID) AS Total_Transactions,
    ROUND(SUM(Sales_Amount_INR), 2) AS Total_Revenue,
    ROUND(SUM(Profit_INR), 2) AS Total_Profit,
    ROUND(
        SUM(Profit_INR) / SUM(Sales_Amount_INR) * 100, 2
    ) AS Profit_Margin
FROM retail_sales
GROUP BY Sales_Channel
ORDER BY Total_Revenue DESC; 

#-----------Advanced SQL – CTEs and Window Functions---------

# Product Performance Analysis:
WITH ProductPerformance AS
(
    SELECT
        Product,
        SUM(Quantity) AS Total_Units_Sold,
        SUM(Sales_Amount_INR) AS Total_Revenue,
        SUM(Profit_INR) AS Total_Profit
    FROM retail_sales
    GROUP BY Product
)

SELECT
    Product,
    Total_Units_Sold,
    ROUND(Total_Revenue, 2) AS Total_Revenue,
    ROUND(Total_Profit, 2) AS Total_Profit
FROM ProductPerformance
ORDER BY Total_Revenue DESC;

# RANK(): Rank Products by Revenue:
WITH ProductPerformance AS
(
    SELECT
        Product,
        SUM(Sales_Amount_INR) AS Total_Revenue
    FROM retail_sales
    GROUP BY Product
)

SELECT
    Product,
    ROUND(Total_Revenue, 2) AS Total_Revenue,
    RANK() OVER (
        ORDER BY Total_Revenue DESC
    ) AS Revenue_Rank
FROM ProductPerformance;

# DENSE_RANK(): Rank Customer Segments:
WITH SegmentPerformance AS
(
    SELECT
        Customer_Segment,
        SUM(Sales_Amount_INR) AS Total_Revenue
    FROM retail_sales
    GROUP BY Customer_Segment
)

SELECT
    Customer_Segment,
    ROUND(Total_Revenue, 2) AS Total_Revenue,
    DENSE_RANK() OVER (
        ORDER BY Total_Revenue DESC
    ) AS Revenue_Rank
FROM SegmentPerformance;

# ROW_NUMBER() analysis :
SELECT
    Transaction_ID,
    Order_Date,
    Product,
    Customer_Segment,
    Sales_Amount_INR,
    Profit_INR,
    ROW_NUMBER() OVER (
        ORDER BY Sales_Amount_INR DESC
    ) AS Transaction_Rank
FROM retail_sales
ORDER BY Sales_Amount_INR DESC
LIMIT 20;

# Monthly Revenue Growth Analysis:
WITH MonthlySales AS
(
    SELECT
        DATE_FORMAT(Order_Date, '%Y-%m-01') AS Month_Start,
        YEAR(Order_Date) AS Sales_Year,
        MONTHNAME(Order_Date) AS Month_Name,
        SUM(Sales_Amount_INR) AS Total_Revenue
    FROM retail_sales
    GROUP BY
        DATE_FORMAT(Order_Date, '%Y-%m-01'),
        YEAR(Order_Date),
        MONTH(Order_Date),
        MONTHNAME(Order_Date)
),

RevenueGrowth AS
(
    SELECT
        Month_Start,
        Sales_Year,
        Month_Name,
        Total_Revenue,
        LAG(Total_Revenue) OVER (
            ORDER BY Month_Start
        ) AS Previous_Month_Revenue
    FROM MonthlySales
)

SELECT
    Sales_Year,
    Month_Name,
    ROUND(Total_Revenue, 2) AS Total_Revenue,
    ROUND(Previous_Month_Revenue, 2) AS Previous_Month_Revenue,
    ROUND(
        (Total_Revenue - Previous_Month_Revenue)
        / NULLIF(Previous_Month_Revenue, 0) * 100,
        2
    ) AS Revenue_Growth_Percentage
FROM RevenueGrowth
ORDER BY Month_Start;

# Check monthly data coverage:
SELECT
    YEAR(Order_Date) AS Sales_Year,
    MONTHNAME(Order_Date) AS Month_Name,
    COUNT(DISTINCT Transaction_ID) AS Total_Transactions,
    MIN(Order_Date) AS First_Order_Date,
    MAX(Order_Date) AS Last_Order_Date,
    ROUND(SUM(Sales_Amount_INR), 2) AS Total_Revenue
FROM retail_sales
GROUP BY
    YEAR(Order_Date),
    MONTH(Order_Date),
    MONTHNAME(Order_Date)
ORDER BY
    Sales_Year,
    MONTH(MIN(Order_Date));
    
# Year-over-Year Revenue Comparison:
WITH MonthlySales AS
(
    SELECT
        YEAR(Order_Date) AS Sales_Year,
        MONTH(Order_Date) AS Month_Number,
        MONTHNAME(Order_Date) AS Month_Name,
        SUM(Sales_Amount_INR) AS Total_Revenue
    FROM retail_sales
    GROUP BY
        YEAR(Order_Date),
        MONTH(Order_Date),
        MONTHNAME(Order_Date)
),

YearComparison AS
(
    SELECT
        Month_Number,
        Month_Name,
        MAX(CASE
            WHEN Sales_Year = 2024
            THEN Total_Revenue
        END) AS Revenue_2024,
        MAX(CASE
            WHEN Sales_Year = 2025
            THEN Total_Revenue
        END) AS Revenue_2025
    FROM MonthlySales
    GROUP BY Month_Number, Month_Name
)

SELECT
    Month_Name,
    ROUND(Revenue_2024, 2) AS Revenue_2024,
    ROUND(Revenue_2025, 2) AS Revenue_2025,
    ROUND(
        (Revenue_2025 - Revenue_2024)
        / NULLIF(Revenue_2024, 0) * 100,
        2
    ) AS YoY_Growth_Percentage
FROM YearComparison
ORDER BY Month_Number;