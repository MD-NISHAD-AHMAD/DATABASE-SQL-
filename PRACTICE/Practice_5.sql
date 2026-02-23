CREATE DATABASE HOSPITAL;

USE HOSPITAL;

CREATE TABLE patient (
    patient_id INT PRIMARY KEY AUTO_INCREMENT,
    patient_name VARCHAR(50),
    age INT,
    gender VARCHAR(10),
    disease VARCHAR(40),
    admission_date DATE,
    city VARCHAR(30)
);

INSERT INTO patient VALUES
(1, 'Ramesh', 45, 'Male', 'Diabetes', '2024-01-10', 'Mumbai'),
(2, 'Sunita', 30, 'Female', 'Fever', '2024-02-05', 'Pune'),
(3, 'Aakash', 60, 'Male', 'Heart Problem', '2024-01-20', 'Delhi'),
(4, 'Neha', 25, 'Female', 'Fever', '2024-02-15', 'Mumbai'),
(5, 'Vijay', 50, 'Male', 'BP', '2024-01-05', 'Pune'),
(6, 'Anjali', 35, 'Female', 'Diabetes', '2024-02-01', 'Delhi');

SELECT * FROM patient;

SELECT * FROM patient
WHERE age < 60;
