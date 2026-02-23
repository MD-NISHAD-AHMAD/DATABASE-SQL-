USE db;

SELECT * FROM salaries;

-- Adding a new column

SELECT
  work_year, experience_level, job_title, salary_in_usd, remote_ratio,
  (salary_in_usd * 0.10) AS standard_salary_bonus,
  (salary_in_usd * 1.10) AS final_salary
FROM salaries;

-- conditional

SELECT 
  work_year, experience_level, job_title,
  salary_in_usd, remote_ratio,
  CASE
       WHEN experience_level = 'EN' THEN salary_in_usd * 0.07
       WHEN experience_level = 'MI' THEN salary_in_usd * 0.12
       WHEN experience_level = 'SE' THEN salary_in_usd * 0.15
       ELSE salary_in_usd * 0.20
       END AS CUSTOM_SALARY_BONUS
       
    FROM
         salaries
    HAVING
         CUSTOM_SALARY_BONUS > 5000;

-- Yaha hum condition ke basis par different bonus de rahe hain
-- Agar remote_ratio alag hoga to bonus percentage bhi alag hoga

SELECT 
   work_year, experience_level, job_title, salary_in_usd, remote_ratio,
   CASE
   WHEN remote_ratio = 0 THEN salary_in_usd * 0.10
   WHEN remote_ratio = 50 THEN salary_in_usd * 0.15
   WHEN remote_ratio = 100 THEN salary_in_usd * 0.20
 
   END AS CUSTOM_SALARY_BONUS
   
FROM salaries;


-- Data Engineer ka average salary calculate karke
-- usse ek user-defined variable me store kar rahe hain

SET @AVG_SAL_DE = (
    SELECT AVG(salary_in_usd)
    FROM salaries 
    WHERE job_title = 'Data Engineer'
);  

-- Ab un Data Engineers ko select kar rahe hain
-- jinki salary average se zyada hai

SELECT * 
FROM salaries 
WHERE job_title = 'Data Engineer' 
      AND salary_in_usd > @AVG_SAL_DE;  
      
      
-- Machine Learning Engineer ka average salary variable me store karna

SET @AVG_SAL_MLE = (
    SELECT AVG(salary_in_usd)
    FROM salaries 
    WHERE job_title = 'Machine Learning Engineer'
); 

-- Yaha directly subquery ka use karke compare kar rahe hain
-- Variable use nahi kiya

SELECT * 
FROM salaries 
WHERE job_title = 'Machine Learning Engineer'
      AND salary_in_usd > 
        (
            SELECT AVG(salary_in_usd)
            FROM salaries
            WHERE job_title = 'Machine Learning Engineer'
        ); 
        
        
SELECT @MLM_MAX AS MACHINE_LEARNING_MANAGER_MAXIMUM_SALARY;  


SELECT job_title
FROM salaries 
GROUP BY job_title 
HAVING MIN(salary_in_usd) > 
	(SELECT MAX(salary_in_usd) 
		FROM salaries 
        WHERE job_title = 'Machine Learning Manager');   

SELECT job_title 
FROM 
(
SELECT job_title , COUNT(*) AS EMPLOYEE_COUNT 
FROM salaries 
GROUP BY job_title
HAVING EMPLOYEE_COUNT BETWEEN 10 AND 20 
) AS T; 


    SELECT job_title
FROM salaries 
GROUP BY job_title 
HAVING MIN(salary_in_usd) > 
	(SELECT MAX(salary_in_usd) 
		FROM salaries 
        WHERE job_title = 'Machine Learning Manager');   

SELECT job_title 
FROM 
(
SELECT job_title , COUNT(*) AS EMPLOYEE_COUNT 
FROM salaries 
GROUP BY job_title
HAVING EMPLOYEE_COUNT BETWEEN 10 AND 20 
) AS T; 


