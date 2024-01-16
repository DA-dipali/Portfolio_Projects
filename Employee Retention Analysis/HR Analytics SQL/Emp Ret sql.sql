CREATE DATABASE employee_retention;
USE employee_retention;
SELECT * FROM hr_1;
SELECT * FROM hr_2;

# Full Outer Join of 2 tables  
SELECT * FROM hr_1
LEFT JOIN hr_2 ON hr_1.EmployeeNumber = hr_2.EmployeeID
UNION
SELECT * FROM hr_2
RIGHT JOIN hr_1 ON hr_1.EmployeeNumber = hr_2.EmployeeID;

# Total Employee Number
SELECT count(EmployeeNumber) AS EmployeeCount FROM hr_1;

# Attiration Count 
SELECT count(Attrition) AS AttirationCount  FROM employee_retention.hr_1
WHERE Attrition="Yes";

# 1.Attrition Rate for All Departments
SELECT 
	Department,
    COUNT(EmployeeNumber) AS total_employees,
    SUM(CASE WHEN Attrition="Yes" THEN 1 ELSE 0 END) AS attrited_employees,
    (sum(CASE WHEN Attrition="Yes" THEN 1 ELSE 0 END) / COUNT(EmployeeNumber)) * 100 AS attrition_rate
FROM 
    hr_1
GROUP BY 
    Department;
    
# 2.Average Hourly rate of Male Research Scientist
SELECT AVG(HourlyRate) AS Avg_HourlyRate
FROM hr_1
WHERE Gender="Male" AND JobRole="Research Scientist";
    
# 3.Attrition rate Vs Monthly income stats
SELECT 
    COUNT(EmployeeNumber) AS total_employees,
    SUM(CASE WHEN Attrition="Yes" THEN 1 ELSE 0 END) AS attrited_employees,
    (sum(CASE WHEN Attrition="Yes" THEN 1 ELSE 0 END) / COUNT(EmployeeNumber)) * 100 AS attrition_rate,
    AVG(MonthlyIncome) AS Avg_MonthlyIncome
FROM 
    hr_1
LEFT JOIN hr_2 ON hr_1.EmployeeNumber = hr_2.EmployeeID;
    
# 4.Average working years for each Department
SELECT 
	Department, AVG(TotalWorkingYears) AS AvgWorking_years 
FROM 
	hr_2
RIGHT JOIN hr_1 ON hr_1.EmployeeNumber = hr_2.EmployeeID
GROUP BY Department;

# 5.Department wise No of Employees
SELECT
	Department, COUNT(EmployeeNumber) AS No_of_Employees
FROM
	hr_1
GROUP BY Department;

# 6.Count of Employees based on Educational Fields
SELECT
	EducationField, COUNT(EmployeeNumber) AS No_of_Employees
FROM
	hr_1
GROUP BY EducationField;

# 7.Job Role Vs Work life balance
SELECT
    hr_1.JobRole,
    hr_2.WorkLifeBalance,
    CASE
        WHEN WorkLifeBalance = 1 THEN 'Best'
        WHEN WorkLifeBalance = 2 THEN 'Better'
        WHEN WorkLifeBalance = 3 THEN 'Good'
        ELSE 'Bad'
    END AS WorkLifeBalance_Status
FROM
    hr_1
RIGHT JOIN hr_2 ON hr_1.EmployeeNumber = hr_2.EmployeeID;


# 8. Attrition rate Vs Year since last promotion relation
SELECT
	hr_2.YearsSinceLastPromotion, 
    SUM(CASE WHEN hr_1.Attrition="Yes" THEN 1 ELSE 0 END) AS Attrition_Count,
    (sum(CASE WHEN Attrition="Yes" THEN 1 ELSE 0 END) / COUNT(EmployeeNumber)) * 100 AS Attrition_rate
FROM 
	hr_2
LEFT JOIN hr_1 ON hr_1.EmployeeNumber = hr_2.EmployeeID
GROUP BY YearsSinceLastPromotion
ORDER BY YearsSinceLastPromotion ASC;

# 9.Gender based Percentage of Employee
SELECT
    Gender,
    COUNT(*) AS total_employees,
    (COUNT(*) / (SELECT COUNT(*) FROM hr_1)) * 100 AS percentage
FROM
    hr_1
GROUP BY
    Gender;
    
# 10.Monthly New Hire vs Attrition Trendline
SELECT
	hr_2.Joining_Month, 
    count(hr_2.employeeID) as New_hire, 
    SUM(CASE WHEN hr_1.Attrition="Yes" THEN 1 ELSE 0 END) AS Attrition_Count
FROM 
	hr_2
LEFT JOIN hr_1 ON hr_1.EmployeeNumber = hr_2.EmployeeID
GROUP BY joining_month
ORDER BY joining_month ASC;

# 11.Department / Job Role wise job satisfaction
SELECT
    hr_1.JobRole,
    hr_1.JobSatisfaction,
    CASE
        WHEN JobSatisfaction = 1 THEN 'Low'
        WHEN JobSatisfaction = 2 THEN 'Medium'
        WHEN JobSatisfaction = 3 THEN 'High'
        ELSE 'Very High'
    END AS JobSatisfaction_Status
FROM
    hr_1
RIGHT JOIN hr_2 ON hr_1.EmployeeNumber = hr_2.EmployeeID;



