/* TCL --> TRANSACTION CONTROL LANGUAGES */

USE db;

SET SQL_SAFE_UPDATES = 0;

CREATE TABLE bank_details(
id INT PRIMARY KEY,
name VARCHAR(50),
balance DECIMAL(10, 2)
);

INSERT INTO bank_details(id, name,balance)
VALUES
(1, 'JACK SPARROW', 10000),
(2, 'WILLIAM TURNER', 5000),
(3, 'ELIZEBETH SWARN', 15000);

SELECT * FROM bank_details;

START TRANSACTION;

UPDATE bank_details
SET balance = balance - 200
WHERE ID = 1;

SAVEPOINT LEVEL_1;

SELECT * FROM bank_details;


UPDATE bank_details
SET balance = balance - 1000
WHERE id = 2;


SAVEPOINT LEVEL_2;

ROLLBACK TO LEVEL_1;

SELECT * FROM bank_details;

COMMIT;

START TRANSACTION;

UPDATE bank_details
SET balance = balance - (balance * 0.01);

SAVEPOINT LEVEL_3;

SELECT * FROM bank_details; 

UPDATE bank_details
SET balance = balance - (balance * 0.10);

SAVEPOINT LEVEL_4;

SELECT * FROM bank_details;

ROLLBACK TO LEVEL_3;

SELECT * FROM bank_details;