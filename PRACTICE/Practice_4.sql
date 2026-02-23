CREATE DATABASE SHOP;
USE SHOP;

CREATE TABLE products(
product_id INT PRIMARY KEY AUTO_INCREMENT,
product_name VARCHAR(50),
category VARCHAR(50),
price INT,
stock INT
);

INSERT INTO products (product_name, category, price, stock)
VALUES
('LAPTOP', 'COMPUTER', 55000, 10),
('MOBILE PHONE', 'ACCESSORIES', 25000, 25),
('HEADPHONES', 'AUDIO', 1500, 35),
('KEYBOARD', 'GADGETS', 2000, 20),
('MOUSE', 'GADGETS', 1000, 8);

SELECT * FROM products;

SELECT * FROM products
WHERE price < 25000;





