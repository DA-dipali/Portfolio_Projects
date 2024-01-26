CREATE DATABASE sales_data_sample;
USE sales_data_sample;
SELECT * FROM sales_data_sample;

#Checking Unique Values
SELECT DISTINCT STATUS FROM sales_data_sample;
SELECT DISTINCT YEAR_ID FROM sales_data_sample;
SELECT DISTINCT PRODUCTLINE FROM sales_data_sample;
SELECT DISTINCT COUNTRY FROM sales_data_sample;
SELECT DISTINCT DEALSIZE FROM sales_data_sample;
SELECT DISTINCT TERRITORY FROM sales_data_sample;

SELECT DISTINCT MONTH_ID FROM sales_data_sample
WHERE YEAR_ID = 2022;

#Grouping sales by PRODUCTLINE
SELECT PRODUCTLINE, SUM(SALES) AS REVENUE
FROM sales_data_sample
GROUP BY PRODUCTLINE
ORDER BY 2 DESC;

#Grouping sales by YEAR_ID
SELECT YEAR_ID, SUM(SALES) AS REVENUE
FROM sales_data_sample
GROUP BY YEAR_ID
ORDER BY 2 DESC;

#Grouping sales by DEALSIZE
SELECT DEALSIZE, SUM(SALES) AS REVENUE
FROM sales_data_sample
GROUP BY DEALSIZE
ORDER BY 2 DESC;

#What was the best month for sales in a specific year? How Much was earned that month?
SELECT MONTH_ID, SUM(SALES) AS REVENUE, COUNT(ORDERNUMBER) AS FREQUENCY
FROM sales_data_sample
WHERE YEAR_ID = 2022 -- change year to see the rest 
GROUP BY MONTH_ID
ORDER BY 2 DESC;

# November seems to be the month, what product they sell in November?
SELECT MONTH_ID, PRODUCTLINE, SUM(SALES) AS REVENUE, COUNT(ORDERNUMBER) AS FREQUENCY
FROM sales_data_sample
WHERE YEAR_ID = 2022 and MONTH_ID = 11 -- change year to see the rest 
GROUP BY MONTH_ID, PRODUCTLINE
ORDER BY 3 DESC;

# Who is our best customer? (This could be best answered with RFM)
-- Drop the table if it exists
DROP TABLE IF EXISTS rfm;

-- Create the table
CREATE TABLE rfm AS
WITH rfm AS (
    SELECT
        CUSTOMERNAME,
        SUM(SALES) AS Monetary_Value,
        AVG(SALES) AS AvgMonetaryValue,
        COUNT(ORDERNUMBER) AS Frequency,
        MAX(NEW_ORDERDATE) AS last_order_date,
        (SELECT MAX(NEW_ORDERDATE) FROM sales_data_sample) AS Recency
    FROM sales_data_sample
    GROUP BY CUSTOMERNAME
),
rfm_cal AS (
    SELECT r.*,
        NTILE(4) OVER (ORDER BY Recency DESC) AS rfm_recency,
        NTILE(4) OVER (ORDER BY Frequency DESC) AS rfm_frequency,
        NTILE(4) OVER (ORDER BY Monetary_Value DESC) AS rfm_monetary
    FROM rfm r
)
SELECT 
    c.*, 
    rfm_recency + rfm_frequency + rfm_monetary AS rfm_cell,
    CONCAT(CAST(rfm_recency AS CHAR), CAST(rfm_frequency AS CHAR), CAST(rfm_monetary AS CHAR)) AS rfm_cell_string
FROM rfm_cal c;

SELECT CUSTOMERNAME, rfm_recency, rfm_frequency, rfm_monetary,
	CASE
		WHEN rfm_cell_string in (111, 112, 121) THEN 'Lost' -- lowest rfm score
        WHEN rfm_cell_string in (133, 134, 234, 243, 244) THEN 'At Risk' -- (big spenders who haven't purchased lately) slipping away
        WHEN rfm_cell_string in (311, 411, 412, 422) THEN 'New' -- Bought Most Recently, but not often
        WHEN rfm_cell_string in (344, 444) THEN 'Loyal' -- spend good money often, responsive to promotions
        WHEN rfm_cell_string in (122, 132, 211, 222, 233, 322, 332) THEN 'Hibernating' -- last purchase was long back, low spenders and low no of orders
        WHEN rfm_cell_string in (221, 312, 321) THEN 'About to sleep' -- below avg r, f and m values. will lose if not reactivated
        WHEN rfm_cell_string in (443, 334, 343, 434) THEN 'Need Attention' -- Above avg r, f and m values, may not have bought very recently though
        WHEN rfm_cell_string in (323, 333, 423, 433) THEN 'Potential Loyalist' -- recent customers but spent a good amount and bought more than once
	end rfm_segment
FROM rfm;

# What products are most often sold together?
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













        
        
        
        
        
        
        
        
        
        
        
        
        



        
        
        
        
        
        
        
        
        
        
        

