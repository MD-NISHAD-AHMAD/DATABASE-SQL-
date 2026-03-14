USE db;

-- WINDOW FUNCTIONS.

-- TYPE 1 : ROW_NUMBER, RANK, DENSE_RANK, N_TILE

-- GET ME THE PERSON WITH MAXIMUM SALARY.

-- OPTION 1

SELECT * 
FROM salaries
ORDER BY salary_in_usd DESC
LIMIT 1;

-- OPTION 2

SELECT *
FROM salaries
WHERE salary_in_usd = (SELECT MAX(salary_in_usd)
FROM salaries);

-- SECOND HIGHEST 

SELECT MAX(salary_in_usd)
FROM salaries
WHERE salary_in_usd < (SELECT 
MAX(salary_in_usd) FROM salaries);

-- get the highest salaried person from each department.

SELECT job_title, MAX(salary_in_usd) AS MAXIMUM_SALARY
FROM salaries
GROUP BY job_title;

-- WINDOW.

SELECT  
       work_year, experience_level, job_title, salary_in_usd,
        ROW_NUMBER() OVER (ORDER BY salary_in_usd DESC) AS 
        ROW_NUMBER_FUNCTION,
           RANK() OVER (ORDER BY salary_in_usd DESC) AS
           RANK_FUNCTION,
            DENSE_RANK() OVER (ORDER BY salary_in_usd DESC) AS
            DENSE_RANK_FUNCTION
FROM salaries;

-- GET THE TOP 3 SALARY EARNER FROM EACH DEPARTMENT.

SELECT *
FROM
(
SELECT 
	work_year, experience_level, job_title, salary_in_usd, 
    DENSE_RANK() OVER (PARTITION BY job_title ORDER BY salary_in_usd DESC)
    AS SALARY_RANKING
    
FROM salaries
) AS T
WHERE SALARY_RANKING = 1;


SELECT * 
FROM 
(
SELECT 
	*, 
    DENSE_RANK() OVER (PARTITION BY job_title ORDER BY salary_in_usd DESC)
    AS SALARY_RANKING
FROM 
	salaries
) AS T
WHERE SALARY_RANKING <= 3; 


SELECT *
FROM
(
SELECT 
       *,
       DENSE_RANK() OVER (PARTITION BY 
       job_title ORDER BY salary_in_usd DESC) 
       AS SALARY_RANKING
       FROM salaries
) AS T
WHERE SALARY_RANKING BETWEEN 10 AND 20;

-- N-TILE.

SELECT QUARTERS, COUNT(QUARTERS)
AS FREQUENCY_COUNT
FROM
(
SELECT
       *,
       NTILE(6) OVER (ORDER BY
       salary_in_usd) AS QUARTERS
       FROM salaries
) AS T
GROUP BY QUARTERS;


-- TYPE 2 (VALUE WINDOW FUNCTIONS)

SELECT 
       *,
       FIRST_VALUE(salary_in_usd) OVER (PARTITION BY job_title
       ORDER BY salary_in_usd ASC) AS
       LOWEST_SALARY_PER_JOB_TITLE
       FROM salaries;
       
SELECT *, (((salary_in_usd - 
LOWEST_SALARY_PER_JOB_TITLE) /
LOWEST_SALARY_PER_JOB_TITLE) * 100)
AS CHANGE_IN_PERCENTAGE_OF_SALARY
FROM 
(
SELECT 
       *, 
       FIRST_VALUE(salary_in_usd) OVER
       (PARTITION BY job_title
        ORDER BY salary_in_usd ASC) AS
        LOWEST_SALARY_PER_JOB_TITLE
        FROM salaries
) AS T;


SELECT
        work_year, experience_level, job_title,
        salary_in_usd,
            DENSE_RANK() OVER (PARTITION BY job_title ORDER BY salary_in_usd DESC)
		FROM salaries;
   
SELECT T1.work_year,
 T1.experience_level, T1.job_title, T1.salary_in_usd, T2.AVERAGE_SALARY 
FROM
(
SELECT *
FROM salaries
WHERE job_title IN ( 
SELECT job_title
FROM
(
SELECT job_title, COUNT(*)
FROM salaries
GROUP BY job_title
HAVING COUNT(*) >= 50
) AS T
)
) AS T1
JOIN
(
SELECT job_title, COUNT(*) AS EMPLOYEE_COUNT , AVG(salary_in_usd) AS AVERAGE_SALARY
FROM salaries 
GROUP BY job_title 
HAVING COUNT(*) >= 50
) AS T2 
ON  T1.job_title = T2.job_title
WHERE T1.salary_in_usd > T2.AVERAGE_SALARY; 

SELECT *
FROM salaries
WHERE job_title IN (
SELECT job_title
FROM
(
SELECT job_title, COUNT(*)
FROM salaries
GROUP BY job_title
HAVING COUNT(*) >= 50
) AS T
) AND salary_in_usd > 200000;

-- FIND EMPLOYEES WHOSE SALARY IS HIGHER THAN AVERAGE SALARY FROM THEIR COUNTRY 

SELECT * FROM salaries;

 
SELECT AVG(salary_in_usd)
FROM salaries
WHERE company_location = 'IN';

SELECT *
FROM salaries
WHERE company_location = 'IN' AND 
salary_in_usd > (SELECT
AVG(salary_in_usd)
FROM salaries
WHERE company_location = 'IN');

SELECT company_location, 
AVG(salary_in_usd) AS AVERAGE_SALARY_PER_COMPANY_LOCATION
FROM salaries 
GROUP BY company_location; 

SELECT *
FROM salaries
JOIN
(

SELECT company_location, 
AVG(salary_in_usd) AS AVERAGE_SALARY_PER_COMPANY_LOCATION 
FROM salaries
GROUP BY company_location
) AS T
ON SALARIES.company_location = T.company_location
WHERE SALARIES.SALARY_IN_USD > T.AVERAGE_SALARY_PER_COMPANY_LOCATION;

-- FIND EMPLOYEES WHOSE SALARY IS NOT EQUAL TO ANY SALARY IN 2021

SELECT *
FROM salaries
WHERE salary_in_usd != ANY(SELECT distinct
salary_in_usd
FROM salaries
WHERE work_year = 2021);

SELECT * 
FROM salaries
WHERE salary_in_usd NOT IN (SELECT
DISTINCT salary_in_usd
FROM salaries
WHERE work_year = 2021);

-- VALUE WINDOW FUNCTION.

SELECT * FROM salaries;

SELECT *, (100 * (salary_in_usd - minimum_salary) /minimum_salary) 
AS CHANGE_IN_SALARY
FROM
(
SELECT 
        work_year, experience_level, job_title,
        salary_in_usd, remote_ratio, company_location, company_size,
        FIRST_VALUE(salary_in_usd) OVER (PARTITION BY job_title ORDER BY salary_in_usd)
        AS minimum_salary
        FROM 
             salaries
) AS T;


SELECT 
    work_year, 
    experience_level, 
    job_title,
    salary_in_usd, 
    remote_ratio, 
    company_location, 
    company_size,

    FIRST_VALUE(salary_in_usd) 
    OVER (PARTITION BY job_title ORDER BY salary_in_usd) 
    AS minimum_salary,

    (100 * (salary_in_usd - FIRST_VALUE(salary_in_usd) 
    OVER (PARTITION BY job_title ORDER BY salary_in_usd)) 
    / FIRST_VALUE(salary_in_usd) 
    OVER (PARTITION BY job_title ORDER BY salary_in_usd)) 
    AS change_in_salary

FROM salaries;    

SELECT *, (100 * (MAXIMUM_SALARY - SALARY_IN_USD)/MAXIMUM_SALARY)
         AS CHANGE_IN_SALARY
FROM
(
SELECT 
      work_year, 
    experience_level, 
    job_title,
    salary_in_usd, 
    remote_ratio, 
    company_location, 
    company_size,
    
    FIRST_VALUE(salary_in_usd) OVER (PARTITION BY job_title ORDER BY salary_in_usd DESC) 
    AS MAXIMUM_SALARY
    FROM 
         salaries
) AS T;


SELECT 
        work_year, 
    experience_level, 
    job_title,
    salary_in_usd, 
    remote_ratio, 
    company_location, 
    company_size,
         
         LAST_VALUE(salary_in_usd) OVER (PARTITION BY job_title ORDER BY 
         salary_in_usd DESC ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)
         AS MINIMUM_SALARY
FROM 
      salaries;
      
SELECT 
       work_year, 
    experience_level, 
    job_title,
    salary_in_usd, 
    remote_ratio, 
    company_location, 
    company_size,
	
    LAST_VALUE(salary_in_usd) OVER (PARTITION BY job_title ORDER BY salary_in_usd
        ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)
        AS MAXIMUM_SALARY
FROM
      salaries;
      
SELECT *
FROM
(
SELECT *, DENSE_RANK() OVER (PARTITION BY job_title ORDER BY CHANGE_IN_PERCENTAGE DESC)
AS CHANGE_IN_PERCENTAGE_RANKING
FROM
(
SELECT 
       work_year, experience_level, job_title, salary_in_usd, 
    remote_ratio, company_location, company_size,
    FIRST_VALUE(salary_in_usd) OVER (PARTITION BY job_title ORDER BY salary_in_usd)
    AS MINIMUM_SALARY, 
    (100 * ((salary_in_usd - FIRST_VALUE(salary_in_usd) OVER 
    (PARTITION BY job_title ORDER BY salary_in_usd))/FIRST_VALUE(salary_in_usd) OVER 
    (PARTITION BY job_title ORDER BY salary_in_usd))) AS CHANGE_IN_PERCENTAGE

FROM salaries
) AS T
) AS T1
WHERE CHANGE_IN_PERCENTAGE_RANKING <= 3;

-- LEAD AND LAG FUNCTIONS.

SELECT *, (100 * ((SALARY_IN_USD - 
PREVIOUS_PERSON_SALARY) /
PREVIOUS_PERSON_SALARY)) AS CHANGE_IN_PERSON
FROM
(
SELECT   
	   work_year, 
    experience_level, 
    job_title,
    salary_in_usd, 
    remote_ratio, 
    company_location, 
    company_size,
          LAG(salary_in_usd, 1, salary_in_usd) OVER (PARTITION BY
          job_title ORDER BY salary_in_usd) AS
          PREVIOUS_PERSON_SALARY
FROM
     salaries
) AS T;


SELECT *, (100 * ((NEXT_PERSON_SALARY - SALARY_IN_USD)/ SALARY_IN_USD))
AS CHANGE_IN_PERCENTAGE
FROM
(
SELECT
        work_year, 
    experience_level, 
    job_title,
    salary_in_usd, 
    remote_ratio, 
    company_location, 
    company_size,
         LEAD(salary_in_usd, 1, salary_in_usd) OVER (PARTITION BY
         job_title ORDER BY salary_in_usd) AS
         NEXT_PERSON_SALARY
FROM
      salaries
) AS T;

-- WINDOWS AGGREGATE FUNCTIONS (MIN, MAX, SUM, COUNT, AVG ).

-- MIN

SELECT 
      work_year, 
    experience_level, 
    job_title,
    salary_in_usd, 
    remote_ratio, 
    company_location, 
    company_size,
          MIN(salary_in_usd) OVER (PARTITION BY job_title ORDER BY
          work_year ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) AS MINIMUM_SALARY
          
	FROM 
         salaries;
  
  -- AVG
  
SELECT 
        work_year, 
    experience_level, 
    job_title,
    salary_in_usd, 
    remote_ratio, 
    company_location, 
    company_size,
               AVG(salary_in_usd) OVER (PARTITION BY job_title ORDER BY
                work_year ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) 
                AS RUNNING_AVERAGE
	FROM
         salaries;
         
	
SELECT 
	work_year, 
    experience_level, 
    job_title, 
    salary_in_usd, 
    remote_ratio, 
    company_location,
    company_size, 
    AVG(salary_in_usd) OVER (PARTITION BY job_title ORDER BY work_year
    ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) AS RUNNING_AVERAGE 
FROM 
	salaries; 
    
  -- SUM
  
SELECT 
	work_year, 
    experience_level, 
    job_title, 
    salary_in_usd, 
    remote_ratio, 
    company_location, 
    company_size, 
    SUM(salary_in_usd) OVER (PARTITION BY job_title ORDER BY work_year
    ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS RUNNING_AVERAGE 
FROM 
	salaries; 

         
SELECT 
	work_year, 
    experience_level, 
    job_title, 
    salary_in_usd, 
    remote_ratio, 
    company_location, 
    company_size, 
    SUM(salary_in_usd) OVER (PARTITION BY job_title ORDER BY work_year
     ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS RUNNING_AVERAGE 
     
FROM 
	salaries;     
    
    	