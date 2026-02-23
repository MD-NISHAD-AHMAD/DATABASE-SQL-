USE db;
SELECT COUNT(*) FROM salaries;

SHOW TABLES;

SELECT * FROM salaries;

-- display the multiple column from the salaries table.

SELECT work_year, job_title, salary_in_usd, remote_ratio,
company_location FROM salaries;

-- display work_year column from the table.alter

SELECT work_year FROM salaries;

-- display all the unique elements from a particular column.

SELECT DISTINCT work_year FROM salaries;

-- Display all the job roles in the given database.

SELECT DISTINCT job_title FROM salaries;

-- OPERATORS.
-- (Comparison)
-- display all the 2020 employees.

SELECT * FROM salaries
WHERE work_year = 2020;

-- Display all the employees for the job role "AI Engineer"

SELECT * FROM salaries
WHERE job_title = "AI Engineer";

SELECT * FROM salaries
WHERE remote_ratio != 0;

-- display all the employees having salary less than 200000.

SELECT * FROM salaries
WHERE salary_in_usd < 2000000;

-- display all the emplyees having salary more than 100000.

SELECT * FROM salaries
WHERE salary_in_usd > 100000;

-- less than equal to.
SELECT*
FROM salaries
WHERE salary_in_usd<=200000;

-- greater than equal to.
SELECT*
FROM salaries 
WHERE salary_in_usd>=200000;

/* 
DISPLAY ALL EMPLOYESS WHOSE EXPRIENCE LEVEL IS
ENTRY LEVEL AND SALARY GREATER THEN 100000.
*/
SELECT *
FROM salaries 
WHERE experience_level = 'EN';

SELECT *
FROM salaries
WHERE salary_in_usd >100000;

SELECT DISTINCT
job_title
FROM
salaries
WHERE
salary_in_usd > 100000
AND experience_level = 'EN'
AND work_year = 2024;

/* 
 DISPLAY ALL EMPLOYEES WHOSE EXPRIENCE LEVEL IS EITHER EN OR MI
 */
 
 SELECT *
FROM salaries
WHERE experience_level = 'EN' OR experience_level ='MI'; 
 

/*
DISPLAY ALL EMPLOYEES WHO EITHER HAVE WORK FROM HOME
OR HAVE SALARY GREATHER THEN 100000.
*/

SELECT*
FROM salaries
WHERE salary_in_usd >100000 OR remote_ratio=100;

/*
DISPLAY EMPLOYEES HAVING SALARY GREATHER THAN 100000
AND ENJOY FULLY REMOTE JOB.
*/

SELECT*
FROM salaries
WHERE remote_ratio=100 AND salary_in_usd > 100000;

/* display all emplyees who does not work in small company
*/

SELECT DISTINCT company_size
FROM salaries;

SELECT*
FROM salaries
WHERE company_size != 's';

/* 
DISPLAY ALL EMPLOYEES HAVING SALARY GREATER THAN 100000
BUT JOB TITLE COUNT BE EITHER DATA ANALYST OR DATA SCIENTIST
*/

SELECT
    *
FROM
salaries
WHERE
salary_in_usd >=100000
AND (job_title = 'DATA ANALYST'
OR job_title = 'DATA SCIENTIST');

-- Range operator.

-- select all employees having salary greater than 1 lakh and 2 lakh.alter

SELECT * FROM salaries
WHERE salary_in_usd >= 100000 AND salary_in_usd <= 200000;

SELECT * 
FROM salaries
WHERE salary_in_usd BETWEEN 100000 AND 200000;

-- membership operartor.
SELECT * 
FROM salaries
WHERE job_title = 'AI Engineer';

SELECT * 
FROM salaries 
WHERE job_title = 'Data Scientist'; 

SELECT * 
FROM salaries 
WHERE job_title = 'Data Analyst'; 

SELECT * 
FROM salaries
WHERE job_title = 'AI Engineer' OR job_title = 
'Data Analyst' OR job_title = 'Data Scientist';

 SELECT * 
 FROM salaries
 WHERE job_title NOT IN ('AI Engineer',
 'Data Analyst', 'Data Scientist');



-- SEARCHING.

SELECT DISTINCT job_title
FROM salaries
WHERE job_title LIKE '%Analyst%';


SELECT DISTINCT job_title
FROM salaries
WHERE job_title LIKE 'Data%';

SELECT DISTINCT job_title
FROM salaries
WHERE job_title LIKE '%Data%';

SELECT DISTINCT employment_type
FROM salaries;

SELECT DISTINCT employment_type
FROM salaries
WHERE employment_type LIKE '_T';

SELECT DISTINCT employment_type
FROM salaries
WHERE NOT employment_type LIKE '_T';

SELECT *
FROM salaries
WHERE NOT employment_type LIKE '_T';

-- sorting.

SELECT * 
FROM salaries
ORDER BY salary_in_usd;

SELECT * FROM salaries
ORDER BY work_year, job_title
DESC, salary_in_usd; 

-- GET THE TOP 5 SALARY EARNER FROM THE GIVEN TABLE

SELECT * 
FROM salaries
ORDER BY salary_in_usd DESC
LIMIT 5;

-- GET THE SALARY RANKING FROM 6 TO 10

SELECT * 
FROM salaries
ORDER BY salary_in_usd DESC
LIMIT 5
OFFSET 5;

-- all the entries from company_location column

SELECT company_location
FROM salaries; 

-- get all the unique entries from company_location column

SELECT DISTINCT company_location
FROM salaries;

SELECT DISTINCT work_year, experience_level
FROM salaries;

SELECT DISTINCT work_year, experience_level
FROM salaries
ORDER BY work_year ASC, experience_level DESC;

-- Aggregate function.

/* MIN, MAX, SUM, COUNT, AVG
*/

-- GET THE MAXIMUM SALARY FROM THE TABLE

SELECT * 
FROM salaries
ORDER BY salary_in_usd DESC
LIMIT 1;

SELECT MAX(salary_in_usd) AS MAXIMUM_SALARY
FROM salaries;

SELECT job_title AS DESIGNATIONS
FROM salaries;

SELECT
MIN(salary_in_usd) AS MINIMUM_SALARY,
    MAX(salary_in_usd) AS MAXIMUM_SALARY,
    SUM(salary_in_usd) AS TOTAL_SALARY,
    AVG(salary_in_usd) AS AVERAGE_SALARY,
    COUNT(*) AS TOTAL_EMPLOYEES
FROM salaries; 

SELECT DISTINCT experience_level
FROM salaries;

SELECT experience_level, AVG(salary_in_usd) AS AVERAGE_SALARY_PER_EXPERIENCE_LEVEL
FROM salaries
GROUP BY experience_level; 

SELECT
    job_title,
    MIN(salary_in_usd) AS MINIMUM_SALARY,
    MAX(salary_in_usd) AS MAXIMUM_SALARY,
    SUM(salary_in_usd) AS TOTAL_SALARY,
    AVG(salary_in_usd) AS AVERAGE_SALARY,
    COUNT(*) AS TOTAL_EMPLOYEES
FROM
    salaries
GROUP BY job_title
ORDER BY TOTAL_EMPLOYEES DESC;





















