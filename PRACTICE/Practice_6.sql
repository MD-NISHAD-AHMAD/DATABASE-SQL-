CREATE DATABASE college_db;

USE college_db;

CREATE TABLE students (
  id INT PRIMARY KEY AUTO_INCREMENT,
  name VARCHAR(50),
  age INT,
  course VARCHAR(50),
  marks INT
);

INSERT INTO students (name, age, course, marks)
VALUES
('RAHUL', 20, 'BCA', 75),
('AMIT', 21, 'BCA', 82),
('SNEHA', 19, 'BCA', 68),
('PRIYA', 22, 'BCA', 90),
('ARJUN', 20, 'BCA', 55);

SELECT * FROM students;

-- Where marks > 60.

SELECT * 
FROM students WHERE marks > 60;

-- ORDER BY marks desc

SELECT * 
FROM students
ORDER BY marks DESC;

-- INTERMEDIATE LEVEL.
-- AND CONDITION.

SELECT *
FROM students 
WHERE COURSE = 'BCA' AND marks > 70; 

-- UPDATE MARKS.

UPDATE students SET marks = 85
WHERE id = 1;

-- DELETE marks < 40.

SET SQL_SAFE_UPDATES = 0;

DELETE FROM students 
WHERE marks < 40;

-- GROUP BY course.

SELECT course, COUNT(*) AS
TOTAL_STUDENTS
FROM students
GROUP BY course;

-- HAVING > 2 students.

SELECT course, COUNT(*) AS
TOTAL_STUDENTS
FROM students
GROUP BY course
HAVING COUNT(*) > 2;

-- THIS IS 2ND TABLE

CREATE TABLE courses (
course_id INT  PRIMARY KEY AUTO_INCREMENT,
course_name VARCHAR(50),
duration VARCHAR(50),
fees INT
); 

SELECT * FROM courses;

INSERT INTO courses (course_name, duration, fees)
VALUES
('BCA', '3 years', 90000),
('BBA', '3 years', 85000);

-- INNER JOIN.

SELECT s.name, c.course_name, c.fees
FROM students s
INNER JOIN courses c
ON s.course = c.course_name;

-- subquery (Above Average marks)

SELECT name FROM students
WHERE marks > (SELECT AVG(marks)
FROM students);

-- HIGHEST MARKS.

SELECT name, marks FROM students 
WHERE marks = (SELECT MAX(marks)
FROM students);

-- LOWEST MARKS.

SELECT name, marks FROM students
WHERE marks = (SELECT MIN(marks)
FROM students);

-- CREATE VIEW.

CREATE VIEW top_students AS

SELECT * FROM students 
WHERE marks > 75; 

-- BONUS.
-- TOP 3 STUDENTS.

SELECT * FROM students 
ORDER BY marks DESC LIMIT 3;

-- SECOND HIGHEST MARKS.

SELECT MAX(marks) FROM students
WHERE marks < (SELECT MAX(marks)
FROM students);