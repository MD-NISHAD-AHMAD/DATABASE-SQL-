-- STORE AND PROCEDURES.

USE db;

-- temporary table.

CREATE TEMPORARY TABLE emp_2024 AS 
SELECT *
FROM salaries
WHERE work_year = 2024;

SELECT 
    *
FROM
    EMP_2024;

-- VIEW.

CREATE VIEW wfh_emp AS
    SELECT 
        *
    FROM
        salaries
    WHERE
        remote_ratio = 100;

SELECT 
    *
FROM
    wfh_emp;

-- COMMON TABLE EXPRESSION.

/*
WITH CTE_NAME AS
(
)
 SELECT * FROM CTE_NAME;
*/

WITH temp_emp AS
(   
   SELECT * FROM salaries
   WHERE salary_in_usd >= 100000
)
 SELECT * FROM temp_emp;
 
WITH emp_2020 AS
(
SELECT * FROM salaries 
WHERE work_year = 202
)
,
emp_2021 AS
(
SELECT * FROM salaries
WHERE work_year = 2021
)
,
emp_2022 AS
(
SELECT * FROM salaries
WHERE work_year = 2022
)
,
emp_2023 AS
(
SELECT * FROM salaries
WHERE work_year = 2023
)
,
enp_2024 AS
(
SELECT * FROM salaries
WHERE work_year = 2024
)

SELECT DISTINCT work_year
FROM
(
SELECT * FROM emp_2024
UNION
SELECT * FROM emp_2022
) AS T;

/*
6.Picture yourself AS a workforce strategist employed by a global 
HR tech startup. Your Mission is to Determine the percentage of 
fully remote work for each experience level IN 2021 and compare 
it WITH the corresponding figures for 2024, Highlighting any 
significant Increases or decreases IN remote work Adoption 
over the years.
*/

WITH total_2021 AS 
(
SELECT experience_level, COUNT(*) AS TOTAL_EMP_2021
FROM salaries 
WHERE work_year = 2021
GROUP BY experience_level
), 
wfh_2021 AS 
(
SELECT experience_level, COUNT(*) AS WFH_EMP_2021
FROM salaries 
WHERE work_year = 2021 AND remote_ratio = 100 
GROUP BY experience_level
), 
PERCENTAGE_2021 AS 
(
SELECT 
	T21.experience_level, W21.WFH_EMP_2021, T21.TOTAL_EMP_2021, 
    ROUND((W21.WFH_EMP_2021 / T21.TOTAL_EMP_2021) * 100, 2)  AS PERCENTAGE_WFH_2021
FROM wfh_2021 AS W21
JOIN total_2021 AS T21
ON W21.experience_level = T21.experience_level
), 
FINAL_2021 AS 
(
SELECT EXPERIENCE_LEVEL, PERCENTAGE_WFH_2021
FROM PERCENTAGE_2021
), 
total_2024 AS 
(
SELECT experience_level, COUNT(*) AS TOTAL_EMP_2024
FROM salaries 
WHERE work_year = 2024
GROUP BY experience_level
), 
wfh_2024 AS 
(
SELECT experience_level, COUNT(*) AS WFH_EMP_2024
FROM salaries 
WHERE work_year = 2024 AND remote_ratio = 100 
GROUP BY experience_level
), 
PERCENTAGE_2024 AS 
(
SELECT 
	T24.experience_level, W24.WFH_EMP_2024, T24.TOTAL_EMP_2024, 
    ROUND((W24.WFH_EMP_2024 / T24.TOTAL_EMP_2024) * 100, 2)  AS PERCENTAGE_WFH_2024
FROM wfh_2024 AS W24
JOIN total_2024 AS T24
ON W24.experience_level = T24.experience_level
), 
FINAL_2024 AS 
(
SELECT EXPERIENCE_LEVEL, PERCENTAGE_WFH_2024
FROM PERCENTAGE_2024
), 
FINAL AS (  
SELECT F21.experience_level, F21.PERCENTAGE_WFH_2021, F24.PERCENTAGE_WFH_2024 
FROM FINAL_2021 AS F21 
JOIN FINAL_2024 AS F24 
ON F21.experience_level = F24.experience_level 
) 
SELECT 
	*, 
    CASE 
		WHEN PERCENTAGE_WFH_2021 > PERCENTAGE_WFH_2024 THEN 'INCREASE' 
        ELSE 'DECREASE'
        END AS PERCENTAGE_DELTA 
FROM FINAL;			

DELIMITER //

CREATE PROCEDURE GETdata(IN WY INT)
BEGIN
      SELECT * FROM salaries
      WHERE work_year = WY;
END //
DELIMITER ;

CALL GETdata(2020);

CREATE TABLE EMPLOYEEDATA(
      EMP_NAME VARCHAR(50),
      SALARY DECIMAL(10, 2)
);

SELECT * FROM EMPLOYEEDATA;

INSERT INTO EMPLOYEEDATA(EMP_NAME, SALARY)
VALUES('JACK SPARROW', 100000);

DELIMITER //
CREATE PROCEDURE INSERTEMPLYEEDATA(IN EMPLOYEE_NAME VARCHAR(50),
IN SAL DECIMAL(10, 2))
BEGIN 
     INSERT INTO EMPLOYEEDATA(EMP_NAME, SALARY)
     VALUES(EMPLOYEE_NAME, SAL);
     
END //
DELIMITER ;

CALL INSERTEMPLYEEDATA('IRON MAN', 500050);

SELECT * FROM EMPLOYEEDATA;