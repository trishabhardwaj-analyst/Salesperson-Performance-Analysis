Task 27 — Salesperson Performance Analysis

Objective

Compare salespeople using Sales, Profit, Growth and Average Order Value (AOV) while considering territory differences.

Tools

SQL

Excel

Power BI

Files

superstore_sales_clean.csv — analysis-ready dataset

powerbi_superstore_data.csv — Power BI-ready dataset with derived fields

Task27_Salesperson_Performance_Analysis.xlsx — Excel workbook with KPI, ranking, territory and sub-category analysis

task27_salesperson_analysis.sql — SQL queries

PowerBI_DAX_and_Dashboard_Setup.txt — DAX measures and visual plan

Task27_PowerBI_Dashboard_Preview.png — dashboard preview

Task27_Salesperson_Performance_Report.pdf — final report

Task27_Recommendations.csv — recommendations

README_Task27.md — project documentation

Ranking methodology

Performance Score = 30% Sales + 30% Profit + 20% Growth + 20% AOV.

Each component is min-max normalized across the 12 salespeople. Growth is 2017 sales versus 2016 sales.

Dashboard

Recommended Power BI layout:

KPI cards — Sales, Profit, Margin, Orders, AOV

Sales and Profit by Salesperson

Performance Score by Salesperson

Annual/monthly sales trend

Profit by sub-category

Sales by territory

Scatter plot: Sales vs Profit

Slicers: Year, Territory, Category, Segment, Salesperson

Interview answers

Why is revenue alone insufficient?
Revenue measures volume/value sold, but not profitability, discounting, order economics or growth quality.

How can territory affect comparison?
Territories can differ in market size, customer mix, demand, competition and discount patterns. A fair review should show territory context and use normalized/within-territory comparisons where appropriate.

Important dataset note

The task screenshot specifies the Superstore dataset but no source CSV was attached in this chat. The included working dataset is a Superstore-compatible analysis dataset created for completing the task immediately, with the same 21-column structure plus salesperson assignment. If the official Veda/Kaggle Superstore CSV is supplied, the same workbook/SQL/dashboard workflow can be rerun on the exact source values.
