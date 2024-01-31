
## Customer Segmentation Using RFM Analysis

## Introduction:
RFM (Recency, Frequency, Monetary) analysis is necessary for businesses as it provides a systematic method to understand and categorize customer behavior based on their transaction history. This analysis helps identify valuable customer segments by evaluating how recently a customer made a purchase, how frequently they make purchases, and how much money they spend. By segmenting customers based on RFM, businesses can tailor their marketing strategies, personalize communication, and optimize resource allocation, ultimately improving customer retention, engagement, and overall profitability. The analysis is conducted using MySQL for data retrieving, and PowerBI for data visualization.

## Data Used:
The analysis is based on Github data consisting of over 2823 rows from the year 2021 to 2023. The dataset includes information such as Order IDs, Customer names, date, Address, Country, Sales, education, Product Lines etc.

**Data Transformation using Power Query Editor** - 
Date column included different date formats, Using Excel Formula converted all dates in 'dd-mm-yyyy' format. Cleaned Contact Numbers by removing unwanted spaces and dashlines. Renamed Column Names. Applied Changes and Loaded query in Power BI for Visualization.

**SQL Analysis** -

**1. Creating a Database:**
```sql
CREATE DATABASE sales_data_sample;
```
This code creates a new database named 'sales_data_sample'.

**2. Selecting the Database:**
```sql
USE sales_data_sample;
```
This code selects the database 'sales_data_sample' for further operations.

**3. Viewing Table Structure:**
```sql
SELECT * FROM sales_data_sample;
```
This code displays the structure of the 'sales_data_sample' table, including the column names and data types.

**4. Retrieving data:**
```sql
SELECT DISTINCT STATUS FROM sales_data_sample;
SELECT DISTINCT YEAR_ID FROM sales_data_sample;
SELECT DISTINCT PRODUCTLINE FROM sales_data_sample;
SELECT DISTINCT COUNTRY FROM sales_data_sample;
SELECT DISTINCT DEALSIZE FROM sales_data_sample;
SELECT DISTINCT TERRITORY FROM sales_data_sample;
```
Above SQL queries using the SELECT DISTINCT statement to retrieve unique values from specific columns in the 'sales_data_sample' table. 

**5. Grouping sales by PRODUCTLINE:**
```sql
SELECT PRODUCTLINE, SUM(SALES) AS REVENUE
FROM sales_data_sample
GROUP BY PRODUCTLINE
ORDER BY 2 DESC; 
```
This SQL query retrieves the total sales revenue for each product line from the 'sales_data_sample' table and orders the results based on the second column.

**6. Grouping sales by YEAR_ID:**
```sql
SELECT YEAR_ID, SUM(SALES) AS REVENUE
FROM sales_data_sample
GROUP BY YEAR_ID
ORDER BY 2 DESC;
```
This SQL query retrieves the total sales revenue for each year from the 'sales_data_sample' table.

**7. What was the best month for sales in a specific year? How Much was earned that month?**
```sql
SELECT MONTH_ID, SUM(SALES) AS REVENUE, COUNT(ORDERNUMBER) AS FREQUENCY
FROM sales_data_sample
WHERE YEAR_ID = 2022 -- change year to see the rest 
GROUP BY MONTH_ID
ORDER BY 2 DESC;
```
Based on purchasing Frequency we can retrieve 'the best month for sales' in specific year.

**8. What product did they sell in the best month?**
```sql
SELECT MONTH_ID, PRODUCTLINE, SUM(SALES) AS REVENUE, COUNT(ORDERNUMBER) AS FREQUENCY
FROM sales_data_sample
WHERE YEAR_ID = 2022 and MONTH_ID = 11 -- change year to see the rest 
GROUP BY MONTH_ID, PRODUCTLINE
ORDER BY 3 DESC;
```
The provided SQL query retrieves the sales revenue and frequency of orders for each product line in a specific month and year from the 'sales_data_sample' table.

**9. Who is our best customer?**

This SQL script creates an RFM (Recency, Frequency, Monetary) analysis and segments customers into different categories based on their RFM scores. Here's a breakdown of the script:

 **Creating the RFM Table:**
   - The first CTE (`rfm`) calculates RFM metrics for each customer, including monetary value, average monetary value, frequency, last order date, and recency.
   - The second CTE (`rfm_cal`) assigns quartile rankings for recency, frequency, and monetary value using the NTILE function.
   - The final query selects the results from `rfm_cal` along with a combined RFM score and a string representation of the RFM cell.

```sql
CREATE TABLE rfm AS
WITH rfm AS (
    -- ... (Same as provided)
),
rfm_cal AS (
    -- ... (Same as provided)
)
SELECT 
    c.*, 
    rfm_recency + rfm_frequency + rfm_monetary AS rfm_cell,
    CONCAT(CAST(rfm_recency AS CHAR), CAST(rfm_frequency AS CHAR), CAST(rfm_monetary AS CHAR)) AS rfm_cell_string
FROM rfm_cal c;
```

 **Segmenting Customers based on RFM Scores:**
   - The second part of the script selects the customer name along with their RFM scores and segments them into different categories using a CASE statement.

```sql
SELECT 
    CUSTOMERNAME, 
    rfm_recency, 
    rfm_frequency, 
    rfm_monetary,
    CASE
        WHEN rfm_cell_string IN (111, 112, 121) THEN 'Lost'
        WHEN rfm_cell_string IN (133, 134, 234, 243, 244) THEN 'At Risk'
        WHEN rfm_cell_string IN (311, 411, 412, 422) THEN 'New'
        WHEN rfm_cell_string IN (344, 444) THEN 'Loyal'
        WHEN rfm_cell_string IN (122, 132, 211, 222, 233, 322, 332) THEN 'Hibernating'
        WHEN rfm_cell_string IN (221, 312, 321) THEN 'About to sleep'
        WHEN rfm_cell_string IN (443, 334, 343, 434) THEN 'Need Attention'
        WHEN rfm_cell_string IN (323, 333, 423, 433) THEN 'Potential Loyalist'
    END AS rfm_segment
FROM rfm;
```

This script is designed to segment customers into different categories based on their RFM scores, allowing for targeted marketing strategies and customer relationship management. Each category represents a different level of customer engagement and potential behavior.
![1_YWJYf6hl1jo0RqjHkkw7Xw](https://github.com/DA-dipali/Portfolio_Projects/assets/155884974/030ff6e9-7baa-4e0d-ba55-5e6490bce446)

**9. What products are most often sold together?**

This SQL query aims to identify and count the frequency of unique combinations of product codes within orders where more than one distinct product code is present. Here's a breakdown of the query:

```sql
SELECT 
    PRODUCT_COMBINATION,
    COUNT(*) AS frequency
FROM (
    SELECT 
        GROUP_CONCAT(DISTINCT s.PRODUCTCODE ORDER BY s.PRODUCTCODE ASC SEPARATOR ',') AS PRODUCT_COMBINATION,
        s.ORDERNUMBER
    FROM sales_data_sample s
    JOIN (
        SELECT ORDERNUMBER
        FROM sales_data_sample
        GROUP BY ORDERNUMBER
        HAVING COUNT(DISTINCT PRODUCTCODE) > 1
    ) m ON s.ORDERNUMBER = m.ORDERNUMBER
    GROUP BY s.ORDERNUMBER
) subquery
GROUP BY PRODUCT_COMBINATION
ORDER BY frequency DESC;
```

1. **Inner Subquery (`m`):**
   - Identifies orders (`ORDERNUMBER`) where there is more than one distinct product code (`PRODUCTCODE`) using the `HAVING` clause.

2. **Main Subquery (`subquery`):**
   - Uses a join to associate each product code combination with its respective order number.
   - Utilizes `GROUP_CONCAT` to concatenate distinct product codes for each order, creating a `PRODUCT_COMBINATION` string.
   - Groups the results by order number.

3. **Outer Query:**
   - Groups the results of the subquery by the `PRODUCT_COMBINATION`.
   - Counts the frequency of each unique product combination using `COUNT(*)`.
   - Orders the results by frequency in descending order.

This query provides information on the frequency of unique combinations of product codes for orders with more than one distinct product. It can be useful for analyzing patterns and understanding customer purchasing behavior when multiple products are bought together.

## Key Performance Indicators
1. Grouping sales by DEALSIZE, PRODUCTLINE, and YEAR_ID.
2. The best month for sales in a specific year and revenue earned in that month.
3. What products did they sell in the best month?
4. Who is our best customer?
5. What products are most often sold together?

 **Data Visualization Using Power BI** -

**Ad hoc Analysis:** Ad hoc customer segmentation allows for flexibility in adapting to changing business needs and identifying unique customer groups that may not be apparent in traditional segmentation approaches. 

To identify different parameters' impact on sales and sales trends over time, different charts such as Pareto, Bar, Funnel, and Area charts were used.

**RFM Analysis:** Segment score table and segment information table loaded into Power BI. Created RFM table using DAX measures, columns, and table. Managed relationships in data models. Calculated Average Revenue Per User, Churn Status, Recency, Frequency, Monetary, Pareto Category, Top 3 Product category and so on. Implemented visuals to Identify the best, recent, hibernating, and loyal customers by using RFM scores.

## Summary of Findings
 - Learned to analyze the transactional data variables used to perform customer segmentation based on customer purchase behavior.
 - Learned how to measure the three purchase behavior attributes, i.e., recency of purchase, Frequency of purchase, and monetary value of purchase.
 - Learned the calculation and logic behind RFM-Scores.
 - Learned how to create and name different customer groups based on their RFM scores.
 - Explored different features, functions, and visualizations in Tableau to analyze the customer groups.
 - The Recommended Actions to be taken based on segments.
     ![1_l5UZF8m91a4Zl8FULwNPJA](https://github.com/DA-dipali/Portfolio_Projects/assets/155884974/7d76181b-c4af-4b4a-8751-da61219f71f8)

## Conclusion

RFM analysis provides a data-driven approach to segmenting and understanding customer behavior, allowing marketers to make informed decisions, optimize marketing efforts, and enhance customer satisfaction and loyalty.

