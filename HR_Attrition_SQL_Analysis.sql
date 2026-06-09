CREATE DATABASE HR_Attrition

USE HR_Attrition


/* Calculate Overall Employee Attrition Rate */

SELECT COUNT(*) AS Total_Employees,
SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END)
AS Attrition_Count,
CONCAT
(CAST
(SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*) AS DECIMAL(10,2)),'%')
AS Attrition_Rate
FROM HR_Attrition_Raw;



/* Identify Department-wise Employee Attrition Count and Attrition Rate */

SELECT Department,
COUNT(*) AS Total_Employees,
SUM
(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) 
AS Attrition_Count,
CONCAT
(CAST
(SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*) AS DECIMAL(10,2)),'%') 
AS Attrition_Rate
FROM HR_Attrition_Raw
GROUP BY Department
ORDER BY Attrition_Count DESC;



/* Analyze Attrition by Job Role to Identify High-Risk Positions */

SELECT JobRole,
COUNT(*) AS Attrition_Count
FROM HR_Attrition_Raw
WHERE Attrition = 'Yes'
GROUP BY JobRole
ORDER BY Attrition_Count DESC;



/* Evaluate the Impact of Overtime on Employee Attrition */

SELECT OverTime,
COUNT(*) AS Attrition_Count
FROM HR_Attrition_Raw
WHERE Attrition = 'Yes'
GROUP BY OverTime
ORDER BY Attrition_Count DESC;



/* Analyze Attrition by Business Travel Frequency */

SELECT BusinessTravel,
COUNT(*) AS Attrition_Count
FROM HR_Attrition_Raw
WHERE Attrition = 'Yes'
GROUP BY BusinessTravel
ORDER BY Attrition_Count DESC;



/* Identify Age Groups with the Highest Employee Attrition */
SELECT CASE
       WHEN Age BETWEEN 18 AND 25 THEN '18-25'
       WHEN Age BETWEEN 26 AND 35 THEN '26-35'
       WHEN Age BETWEEN 36 AND 45 THEN '36-45'
       ELSE '46+'
       END AS Age_Group,
       COUNT(*) AS Attrition_Count
FROM HR_Attrition_Raw
WHERE Attrition = 'Yes'
GROUP BY CASE
         WHEN Age BETWEEN 18 AND 25 THEN '18-25'
         WHEN Age BETWEEN 26 AND 35 THEN '26-35'
         WHEN Age BETWEEN 36 AND 45 THEN '36-45'
         ELSE '46+'
         END
ORDER BY Attrition_Count DESC;



/* Compare Attrition Across Different Education Fields */

SELECT EducationField,
COUNT(*) AS Attrition_Count
FROM HR_Attrition_Raw
WHERE Attrition = 'Yes'
GROUP BY EducationField
ORDER BY Attrition_Count DESC;



/* Analyze Attrition Based on Job Satisfaction Levels */

SELECT CASE
       WHEN JobSatisfaction = 1 THEN 'Low'
       WHEN JobSatisfaction = 2 THEN 'Medium'
       WHEN JobSatisfaction = 3 THEN 'High'
       WHEN JobSatisfaction = 4 THEN 'Very High'
       END AS Job_Satisfaction,
       COUNT(*) AS Attrition_Count
FROM HR_Attrition_Raw
WHERE Attrition = 'Yes'
GROUP BY JobSatisfaction
ORDER BY Attrition_Count DESC;


/* Analyze Attrition Based on Work-Life Balance Ratings */

SELECT CASE
       WHEN WorkLifeBalance = 1 THEN 'Bad'
       WHEN WorkLifeBalance = 2 THEN 'Good'
       WHEN WorkLifeBalance = 3 THEN 'Better'
       WHEN WorkLifeBalance = 4 THEN 'Best'
       END AS WorkLifeBalance,
       COUNT(*) AS Attrition_Count
FROM HR_Attrition_Raw
WHERE Attrition = 'Yes'
GROUP BY WorkLifeBalance
ORDER BY Attrition_Count DESC;



/* Compare Average Monthly Income of Employees Who Left vs Stayed */

SELECT Attrition,
ROUND(AVG(MonthlyIncome),2) AS Avg_Monthly_Income
FROM HR_Attrition_Raw
GROUP BY Attrition;