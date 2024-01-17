## Employee Retention Analysis

## Introduction:
In today's data-driven world, organizations rely on data analysis to gain valuable insights into various aspects of their operations. One crucial area is human resources (HR), where analyzing employee data can provide valuable information about the workforce. In this article, we will explore a comprehensive analysis of HR data, including the gender breakdown, work-life balance and job satisfaction Impact on turnover, age demographics, distance from home wise distribution, employment length, gender distribution across departments and job titles, job title distribution, turnover rate by department, and changes in employee count over time. The analysis is conducted using MySQL for data cleaning and analysis, and Excel, Tableau and PowerBI for data visualization.
## Data Used:
The analysis is based on HR data consisting of over 50,000 rows from the year 1982 to 2021. The dataset includes information such as employee IDs, gender, work-life balance, job satisfaction rating, age, Business Travel, education, monthly rate, distance from home, attrition, hire and termination dates, departments, and job roles.

**Data Transformation using Power Query Editor** - Calculated necessary measures like Financial Month, and Financial Quarter using Excel Formulas, combined 'hr-1' and 'hr-2' files using Merge Queries, changed data types, created new columns to meet needs. Loaded data in Excel And Power BI.

**Data Cleaning & Analysis** -
The provided MySQL code performs various data cleaning and transformation steps on the 'hr-1' and 'hr-2' tables in the 'employee_retention' database. Here's a breakdown of each step:

1. Creating a Database:
```sql
CREATE DATABASE employee_retention;
```
This code creates a new database named 'employee_retention'.

2. Selecting the Database:
```sql
USE employee_retention;
```
This code selects the 'employee_retention' database for further operations.

3. Viewing Table Structure:
```sql
SELECT * FROM hr_1;
```
This code displays the structure of the 'hr_1' table, including the column names and data types.

4. Cleaning Attrition Column:
```sql
SELECT count(Attrition) AS AttirationCount  FROM employee_retention.hr_1
WHERE Attrition="Yes";
```
```sql
SELECT count(Attrition) AS AttirationCount  FROM employee_retention.hr_1
WHERE Attrition="No";
```
The above 2 codes separate the 'Attrition' column values into Attrition Count and Retention Count for ease of analysis. 

5. Calculating Department wise Attrition Rate :
```sql
SELECT 
	Department,
    COUNT(EmployeeNumber) AS total_employees,
    SUM(CASE WHEN Attrition="Yes" THEN 1 ELSE 0 END) AS attrited_employees,
    (sum(CASE WHEN Attrition="Yes" THEN 1 ELSE 0 END) / COUNT(EmployeeNumber)) * 100 AS attrition_rate
FROM 
    hr_1
GROUP BY 
    Department;
```
This code Calculates the attrition rate as a percentage by dividing the count of attrited employees by the total number of employees and multiplying by 100.

5. Calculating the Average Hourly Rate of Male Research Scientists:
```sql
SELECT AVG(HourlyRate) AS Avg_HourlyRate
FROM hr_1
WHERE Gender="Male" AND JobRole="Research Scientist";
```
This code Calculates the average hourly rate for male employees with the job role "Research Scientist" in the hr_1 table.

Similarly, the following KPIs are given by the company to conclude:

## Key Performance Indicators
1. Average Attrition rate for all Departments
2. Average Hourly rate of Male Research Scientist
3. Attrition rate vs. monthly income stats
4. Average working years for each Department
5. Department-wise No of Employees
6. Count of Employees based on Educational Fields
7. Job Role Vs Work-life balance
8. Attrition rate vs. year since last promotion relation
9. Gender-based Percentage of Employee
10. Monthly New Hire vs Attrition Trendline
11. Department / Job Role wise job satisfaction

**Data Visualization**
- **Power BI:** Used for in-depth data visualization and analysis.
- **Tableau:** Employed for additional visualizations and interactive dashboards.
- **Excel:** Utilized for data extraction, transformation, and analyzed above-mentioned KPIs with Charts and Pivot tables.


## Summary of Findings
 - Every year nearly the same no of employees leave the company. The lowest attrition was in 1990 and 2012 due to the high retention rate of employees from 5 departments because the maximum no of training programs were conducted.
 - Total No of Active Emp is lowest in 2018-2021.
 - 3 age groups were created (18-32, 33-47, 48-60). A large number of employees were between 18-32 followed by 33-47 while the smallest group was 48-60.
 - A large number of employees work in the Software Department versus others.
 - The average length of employment for terminated employees is around 11 years.
 - The gender distribution across departments is fairly balanced but there are generally more male than female employees.
 - The Research and Development department has the highest turnover rate followed by Sales. The lowest turnover rate is in the Hardware department.
- Employees from the Research and Development, Software, and HR Departments were dissatisfied with their jobs.
- Laboratory Technicians and Sales Executives had given poor work-life balance ratings due to low salaries over these years which caused the highest attrition rate for these job roles.   

## Limitations

- Some records need to be modified for proper insights such as attrition was given in yes/no format. calculated measures used to count attrition rate, attrition count, etc. 
- Age Bins and distance from Home Bins calculated for meaningful outcomes.
- Rating Fields such as work-life balance, and job satisfaction were in numbers. These fields are recreated for quick understanding.

## Conclusion

Employee retention is not only about saving costs but also about ensuring the stability, productivity, and long-term success of a company. 
