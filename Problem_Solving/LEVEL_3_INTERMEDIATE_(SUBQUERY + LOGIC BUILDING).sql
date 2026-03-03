-- LEVEL-3 INTERMEDIATE (SUBQUERY + LOGIC BUILDING).

USE db;

-- 21. find Employees who earn more than overall average salary.

SELECT AVG(salary_in_usd)
FROM salaries;

SELECT *
FROM salaries
WHERE salary_in_usd > (
     SELECT AVG(salary_in_usd)
FROM salaries ); 

-- 22. find employees who earn more than average salary of their own job_title.

/* first we have to find average of every job_title*/

SELECT job_title, AVG(salary_in_usd)
FROM salaries
GROUP BY job_title;

/* now compare the employees of on a salary basis.*/

SELECT *
FROM salaries s1
WHERE salary_in_usd > (
     SELECT AVG(salary_in_usd)
     FROM salaries s2
     WHERE s1.job_title = s2.job_title
     );
     
-- 23. find the second highest salary in the table.

SELECT MAX(salary_in_usd)
FROM salaries;

SELECT MAX(salary_in_usd)
FROM salaries
WHERE salary_in_usd < (
     SELECT MAX(salary_in_usd)
     FROM salaries
);

-- 24. show highest paid employee in each company_location.

SELECT company_location, MAX(salary_in_usd)
FROM salaries
GROUP BY company_location;

SELECT * 
FROM salaries s1
WHERE salary_in_usd = (
     SELECT MAX(salary_in_usd)
     FROM salaries s2
     WHERE s1.company_location = s2.company_location
); 

-- 25.  find the job title that have more than 2 employees.

SELECT job_title, COUNT(*)
FROM salaries
GROUP BY job_title;

-- add condition 

SELECT job_title
FROM salaries
GROUP BY job_title
HAVING COUNT(*) > 2;

-- 26. show employees whose salary is equal to the maximum salary of their job_title.

SELECT job_title, MAX(salary_in_usd)
FROM salaries
GROUP BY job_title;

SELECT *
FROM salaries s1
WHERE salary_in_usd = (
      SELECT MAX(salary_in_usd)
      FROM salaries s2
      WHERE s1.job_title = s2.job_title
);

-- 27. find employees working in the same location as highest paid employees.

SELECT MAX(salary_in_usd)
FROM salaries;

SELECT company_location
FROM salaries
WHERE salary_in_usd = (
      SELECT MAX(salary_in_usd)
	  FROM salaries
);

SELECT *
FROM salaries
WHERE company_location = (
      SELECT company_location
      FROM salaries
      WHERE salary_in_usd = (
            SELECT MAX(salary_in_usd)
            FROM salaries
    )
);

-- 28. find the job_title with highest average salary,

SELECT job_title, AVG(salary_in_usd)
FROM salaries
GROUP BY job_title;

SELECT MAX(avg_salary)
FROM (
     SELECT AVG(salary_in_usd) AS avg_salary
     FROM salaries
     GROUP BY job_title
) t;

SELECT job_title
FROM salaries
GROUP BY job_title
HAVING AVG(salary_in_usd) = (
       SELECT MAX(avg_salary)
       FROM (
       SELECT AVG(salary_in_usd) AS avg_salary
       FROM salaries
       GROUP BY job_title
	) T
);

-- 29. show employees whose salary is below average salary of their company_location.

SELECT company_location, AVG(salary_in_usd)
FROM salaries
GROUP BY company_location;

SELECT * 
FROM salaries s1
WHERE salary_in_usd < (
      SELECT AVG(salary_in_usd)
      FROM salaries s2
      WHERE s1.company_location = s2.company_location
);

/* 30. create a new coulmn using CASE that categorizes salary as:
 1. High (>150000)
 2. Medium (80000-150000)
 3. Low (<80000)*/ 
 
 SELECT salary_in_usd
 FROM salaries;
 
  -- USING CASE:
  
  SELECT *,
  CASE
      WHEN salary_in_usd > 150000 THEN 'HIGH'
      WHEN salary_in_usd BETWEEN 80000 AND 150000 THEN 'MEDIUM'
      ELSE 'LOW'
  END AS salary_category
  FROM salaries;
  