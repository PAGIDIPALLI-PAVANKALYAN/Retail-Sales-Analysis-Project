# AI-Assisted Retail Sales Data Analysis

## 1. Project Overview

An end-to-end retail sales analytics project focused on preparing transactional data, analyzing sales and profitability, identifying trends, and communicating business insights using Microsoft Excel, Python, MySQL, and Power BI.

## 2. Business Problem

The retail business has a large volume of transaction records, but raw transactional data alone does not provide management with a clear and convenient view of business performance. Without structured analysis, it can be difficult to:

- Monitor revenue, costs, profit, and profit margins.
- Understand monthly and year-over-year sales trends.
- Identify product and customer-segment performance.
- Trust reports when source data contains missing values, duplicates, or inconsistent entries.
- Turn transaction-level records into useful information for business decisions.

**Main business question:** How can retail transaction data be transformed into reliable performance measures and clear insights that help management monitor sales, profitability, products, customers, and trends?

## 3. Project Objectives

- Prepare a reliable dataset by handling data-quality issues.
- Calculate key business performance indicators (KPIs).
- Analyze sales and profitability over time.
- Examine product and customer-segment performance.
- Compare equivalent periods across years to avoid misleading comparisons.
- Present findings through an interactive Power BI dashboard.

## 4. Tools & Technologies

- **Microsoft Excel:** Dataset inspection, missing-value handling, duplicate removal, and data validation.
- **Python:** Pandas, NumPy, Matplotlib, and Seaborn for data preparation, KPI calculations, and exploratory data analysis.
- **MySQL:** Data querying, aggregations, joins, CTEs, subqueries, KPI calculations, monthly analysis, and year-over-year comparisons.
- **Power BI:** Interactive dashboards, KPI cards, DAX measures, and business reporting.

## 5. Project Workflow and Solution

1. Inspected the source dataset and understood its structure.
2. Cleaned and validated the data in Excel, including handling missing values and duplicates.
3. Performed exploratory data analysis and calculated KPIs using Python.
4. Loaded and analyzed the prepared data using MySQL.
5. Analyzed customer and product performance.
6. Evaluated monthly revenue, costs, and profitability.
7. Compared year-over-year performance for matching periods.
8. Built an interactive Power BI dashboard to communicate the results.
9. Summarized findings and practical areas for management to investigate.

## 6. Overall Business KPIs

| KPI | Result |
|---|---:|
| Total Revenue | ₹215,489,969.15 |
| Total Profit | ₹100,662,489.15 |
| Total Cost | ₹114,827,480.00 |
| Total Transactions | 124,754 |
| Total Units Sold | 268,592 |
| Average Transaction Value | ₹1,727.32 |
| Profit Margin | 46.71% |

## 7. SQL Analysis: Comparable-Period Results

The following comparison covers **January through September** in both years, avoiding a misleading comparison between a complete year and a partial year.

| Metric | Jan–Sep 2024 | Jan–Sep 2025 |
|---|---:|---:|
| Transactions | 53,432 | 53,366 |
| Revenue | ₹92,531,289.45 | ₹91,770,031.55 |
| Cost | ₹49,380,915.00 | ₹48,864,580.00 |
| Profit | ₹43,150,374.45 | ₹42,905,451.55 |
| Profit Margin | 46.63% | 46.75% |
| Average Order Value | ₹1,731.76 | ₹1,719.63 |

## 8. Key Findings

- Revenue decreased by approximately **0.82%** in Jan–Sep 2025 compared with the same period in 2024.
- Profit decreased by approximately **0.57%**.
- Profit margin increased by approximately **0.12 percentage points**.
- Transaction volume was nearly unchanged between the two comparable periods.
- April 2025 recorded the highest positive monthly year-over-year revenue growth in the comparison, at **5.01%**.
- October 2025 contains transactions dated only October 1 in the analyzed dataset and is therefore flagged as an incomplete month. November and December 2025 records were not present in the analyzed dataset.

## 9. Business Interpretation and Recommendations

The comparable-period analysis indicates a slight decline in revenue and profit, while transaction volume remained almost unchanged and profit margin improved modestly. This provides management with a starting point for further investigation rather than proving a specific cause.

Based on these findings, management could:

- Investigate the products, categories, or customer segments contributing most to the revenue decline.
- Review pricing, discounting, and cost patterns to understand the small improvement in profit margin.
- Monitor monthly revenue and profit trends to identify changes early.
- Continue tracking product and customer-segment performance to support inventory and sales planning.
- Compare only complete and equivalent periods when evaluating year-over-year performance.

## 10. How the Project Addresses the Business Problem

The project transforms transaction-level data into a structured analytical workflow:

- **Excel** improves data readiness through cleaning and validation.
- **Python** provides exploratory analysis and calculated KPIs.
- **MySQL** answers focused business questions through repeatable queries.
- **Power BI** presents important metrics and trends in an interactive dashboard.

Together, these outputs give decision-makers clearer visibility into sales, costs, profitability, and performance trends. The project demonstrates a data-driven decision-support process; it does not claim that business performance was improved as a measured result.

## 11. Author

**Pavan Kalyan**  
Aspiring AI Data Analyst  
Skills: SQL | Python | Excel | Power BI
