CREATE DATABASE library;

USE library;

CREATE TABLE books(
book_id INT PRIMARY KEY,
title VARCHAR(50),
author VARCHAR(50),
price DECIMAL(10, 2)
);

INSERT INTO books (book_id, title, author, price)
VALUES
(1, "The psychology of money", "Morgan Housel", 250.12),
(2, "The monk who sold his ferrari", "Robin Sharma", 362.23),
(3, "Rich dad poor dad", "Robert kiyosaki", 550.35),
(4, "Wings of fire", "A.P.J Abdul Kalam", 450.65),
(5, "The subtle art of not giving a fuck", "Mark Manson", 750.55);

SELECT * FROM books;

-- we check which book price of more than 500.
SELECT * FROM books
WHERE price > 500;

-- we can show title and author.
SELECT title, author FROM books;

-- price between 300 and 600.
SELECT * FROM books
WHERE price BETWEEN 300 AND 600;

