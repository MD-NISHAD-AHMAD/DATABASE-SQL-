USE db;
SELECT  * FROM salaries;

SELECT work_year, COUNT(*) AS EMPLOYEE_COUNT_PER_YEAR
FROM salaries
GROUP  BY work_year
ORDER BY EMPLOYEE_COUNT_PER_YEAR DESC
LIMIT 1;

SELECT work_year
FROM Salaries
GROUP BY work_year
ORDER BY COUNT(*) DESC
LIMIT 1;

SELECT 
job_title,
AVG(salary_in_usd) AS
AVERAGE_SALARY,
COUNT(*) AS TOTAL_EMPLOYEES,
MIN(salary_in_usd) AS MINIMUM_SALARY,
MAX(salary_in_usd) AS MAXIMUM_SALARY
FROM 
  salaries
  GROUP BY job_title
  HAVING AVERAGE_SALARY >= 100000 AND
  TOTAL_EMPLOYEES >=10
  ORDER BY TOTAL_EMPLOYEES ASC;

SELECT 
    job_title,
    AVG(salary_in_usd) AS AVERAGE_SALARY,
    COUNT(*) AS TOTAL_EMPLOYEES, 
    MIN(salary_in_usd) AS MINIMUM_SALARY, 
    MAX(salary_in_usd) AS MAXIMUM_SALARY 
FROM
    salaries
GROUP BY job_title
HAVING AVG(salary_in_usd) >= 100000 AND COUNT(*) >= 10
ORDER BY TOTAL_EMPLOYEES ASC; 

-- get the minimum and maximum salary for all the job_roles who are hired in the year 2023 such that the minimum salary must be greater than 100000.
 
 SELECT job_title,
 MIN(salary_in_usd) AS MINIMUM_SALARY,
 MAX(salary_in_usd) AS MAXIMUM_SALARY
 FROM salaries
 WHERE work_year = 2023
 GROUP BY job_title
 HAVING MIN(salary_in_usd) > 100000
 ORDER BY MIN(salary_in_usd);
 
 SELECT job_title, COUNT(*)
 FROM salaries
 GROUP BY job_title
 ORDER BY COUNT(*) DESC;
 
 -- creating a variable to store the average salary of data engineers.

SET @AVG_SAL_DE = (SELECT
AVG(salary_in_usd)
FROM salaries
WHERE job_title = 'Data Engineer'
);

SELECT *
FROM salaries
WHERE job_title = 'Data Engineer'
AND salary_in_usd > @AVG_SAL_DE;

-- Alternate Approach --> sub-query (Not for now)

SELECT *
FROM salaries
WHERE job_title = 'Data Engineer'
AND salary_in_usd > (SELECT
AVG(salary_in_usd)
FROM salaries 
WHERE job_title = 'Data Engineer');


SET @EMP_THRESHOLD = 100;

SELECT job_title, COUNT(*) AS
TOTAL_EMPLOYEES
FROM salaries
GROUP BY job_title
HAVING COUNT(*) > @EMP_THRESHOLD
ORDER BY COUNT(*) ASC;

