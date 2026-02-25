CREATE DATABASE college;
USE college;

CREATE TABLE student (
rollno INT PRIMARY KEY,
name VARCHAR(50),
marks INT NOT NULL,
grade VARCHAR(50),
city VARCHAR(50)
);

INSERT INTO student
(rollno, name, marks, grade, city)
VALUES
(101, "SHALINI", 75, "B", "Bihar"),
(102, "KOMAL", 85, "A", "UP"),
(103, "KHUSHI", 65, "B", "Pune"),
(104, "NILESH", 55, "C", "Mumbai"),
(105, "SUNITA", 45, "C", "Muzaffarpur"),
(106, "KIRTIKA", 89, "A", "Delhi");

SELECT * FROM student;

SELECT *
FROM student
WHERE marks < 80;

-- SQL SUB QUERIES.

-- 1. get names of all the students who scored more than class average.

-- step1. find the average of class.
-- step2. find the names of students with marks > avg.

SELECT AVG(marks)
FROM student;

SELECT name, marks
FROM student
WHERE marks > 69.0000;

SELECT name, marks
FROM student 
WHERE marks > (SELECT AVG(marks)
FROM student);

-- SQL sub queries.

-- 2. find the names of all student with even roll numbers.

-- step1- find the even roll number.

SELECT rollno
FROM student
WHERE rollno % 2 = 0;

-- step2. 

SELECT name, rollno
FROM student
    WHERE rollno IN (
       SELECT rollno
       FROM student
  WHERE rollno % 2 = 0);
  
  
  SELECT *
  FROM student
  WHERE city = "muzaffarpur";
  
  
  -- 2nd table.
  
  CREATE TABLE student1 (
   rollno INT PRIMARY KEY AUTO_INCREMENT,
   name VARCHAR(50),
   marks INT NOT NULL,
   grade VARCHAR(1),
   city VARCHAR(20)
  );
  
  -- inserting values.
  
  INSERT INTO student1 (rollno, name, marks, grade, city)
  VALUES
  (101, "anil", 78, "C", "Pune"),
  (102, "bhumika", 93, "A", "Mumbai"),
  (103, "chetan", 85, "B", "Mumbai"),
  (104, "dhruv", 96, "A", "Delhi"),
  (105, "emanuel", 12, "F", "Delhi"),
  (106, "farah", 82, "B", "Delhi");
  
  SELECT * FROM student1;
  
  SELECT DISTINCT city FROM student1;
  
  -- OPERATORS.
  
  -- AND (to check for both condition be true)
  
  SELECT * 
  FROM student1
  WHERE marks > 90 AND city = "Mumbai";
  
  -- OR (to check for one condtion be true).
  
  SELECT * 
  FROM student1
  WHERE marks > 90 OR city = "Mumbai";
  
  -- BETWEEN (select for given range)
  
  SELECT *
  FROM student1
  WHERE marks BETWEEN 80 AND 90;
  
  -- IN (matches any value in the list)
  
  SELECT * 
  FROM student1
  WHERE city IN ("Delhi", "Mumbai");
  
  -- NOT (to negate the given condtion)
  
  SELECT *
  FROM student1
  WHERE city NOT IN ("Delhi", "Mumbai");
  
  -- LIMIT clause
  
SELECT * 
FROM student1
WHERE marks > 75
LIMIT 3;

-- ORDER BY clause (to sort in (ASC) or (DESC) order).

SELECT *
FROM student1
ORDER BY city ASC;

SELECT * 
FROM student1
ORDER BY marks DESC
LIMIT 3;

/* AGGREGATE FUNCTION: aggregate function perfrom a calculation on a set
of values, and return a single value.
.COUNT()
.MAX() 
.MIN()
.SUM()
.AVG()*/

-- MAX().

SELECT MAX(marks)
FROM student1;

-- MIN().

SELECT MIN(marks)
FROM student1;

-- AVG().

SELECT AVG(marks)
FROM student1;

-- COUNT().

SELECT COUNT(rollno)
FROM student1;

-- GROUP BY clause.

SELECT city, COUNT(rollno)
FROM student1
GROUP BY city;

-- practice Qs:- write the query to find the avg marks in each city in asc order.

SELECT city, AVG(marks)
FROM student1
GROUP BY city 
ORDER BY city;

SELECT grade, COUNT(rollno) AS TOTAL_COUNT
FROM student1
GROUP BY grade
ORDER BY grade;

/*HAVING clause:- similar to where i,e.applies some condition on rows.
Used when we want to apply any condition after grouping */

SELECT city, COUNT(rollno)
FROM student1
GROUP BY city
HAVING MAX(marks) > 90;

/*GENERAL ORDER
SELECT column(s)
FROM tabel_name
WHERE codntion
GROUP BY column(s)
OREDR BY column(ASC)*/

SELECT city
FROM student1
WHERE grade = "A"
GROUP BY city
HAVING MAX(marks) >= 93
ORDER BY city DESC;


-- table related queries
-- UPDATE (to update existing rows)

SET SQL_SAFE_UPDATES = 0;

UPDATE student1
SET grade = "O"
WHERE grade = "A";

SELECT * FROM student1;

UPDATE student1
SET marks = 12
WHERE rollno = 105;

UPDATE student1
SET grade = "B"
WHERE marks BETWEEN 80 AND 90;

UPDATE student1
SET marks = marks + 1;

-- DELETE (to delete existing rows)

DELETE 
FROM student1
WHERE marks < 33;

-- 3rd table.

CREATE TABLE dept (
  id INT PRIMARY KEY,
  name VARCHAR(50)
);

-- 4th TABLE.

CREATE TABLE teacher(
 id INT PRIMARY KEY,
 name VARCHAR(50),
 dept_id INT,
 FOREIGN KEY (dept_id) REFERENCES dept(id)
 
);

SELECT * FROM student1;

-- TABLE RELATED QUERIES.

-- ALTER (to change the schema)
-- ADD (add the column)

ALTER TABLE  student1
ADD COLUMN age INT NOT NULL DEFAULT 19;



-- DROP (delete the column)

ALTER TABLE student1
DROP age;

-- Change Column (RENAME)

ALTER TABLE student1
CHANGE age stu_age INT;

ALTER TABLE student1
DROP COLUMN stu_age;

-- RENAME TABLE.

ALTER TABLE STU
RENAME TO student1;

-- TRUNCATE TABLE (to deletes table data's)

TRUNCATE TABLE student1;

-- 	QuestionS
-- 1. Change the name of column name to full_name.

ALTER TABLE student1
CHANGE  name full_name VARCHAR(50);

-- 2. Delete all the students who score marks less than 80.

DELETE FROM
student1
WHERE marks < 80;
 
-- 3. Delete the columns for grades.

ALTER TABLE student1
DROP COLUMN grade;


