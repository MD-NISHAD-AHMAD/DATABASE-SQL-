CREATE DATABASE xyz_company;
USE xyz_company;

CREATE TABLE employee(
id INT PRIMARY KEY,
name VARCHAR(50),
salary INT
);

INSERT INTO employee (id, name, salary)
VALUES
(1, "Adam", 25000),
(2, "Rohan", 20000),
(3, "karan", 35000),
(4, "Mehfooz", 45000),
(5, "Sohail", 55000);

SELECT * FROM employee;