-- display all the databases.
SHOW DATABASES;

-- created a new database named db.
CREATE DATABASE DB;

-- entering into the database.alter

USE db;

-- check for existing tables in the database

SHOW TABLES;

-- creating a new table.

CREATE TABLE emp (
emp_id INT PRIMARY KEY AUTO_INCREMENT,
emp_name VARCHAR(50),
emp_email VARCHAR(100) UNIQUE,
emp_gender ENUM("MALE", "FEMALE", "OTHER"),
emp_age INT,
emp_salary DECIMAL(10, 2)
);

SELECT * FROM emp;

-- inserting single entry into table

INSERT INTO emp(emp_name, emp_email, emp_gender, emp_age, emp_salary)
VALUES("NISHAD", "nishadahmadm@gamil.com", "MALE", 22, 35000.25);

-- inserting multiples entries into the table.alter

INSERT INTO emp(emp_name, emp_email, emp_gender, emp_age, emp_salary)
VALUES
("NILESH", "nileshyadav@gmail.com", "MALE", 25, 25000.35),
("DEEPAK", "deepak@gmail.com", "MALE", 20, 18000),
("ABDUL", "abdul@gamil.com", "MALE", 22, 20000),
("AAKIL", "aakil@gamil.com", "MALE", 26, 21000);

SELECT * FROM emp;


