USE db;

CREATE TABLE Customers (
    customer_id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    phone_number VARCHAR(15),
    address VARCHAR(255)
);

-- Insert 10 sample entries for Customers
INSERT INTO Customers (customer_id, name, email, phone_number, address) VALUES
(1, 'John Doe', 'johndoe@gmail.com', '1234567890', '123 Main St, City A'),
(2, 'Jane Smith', 'janesmith@yahoo.com', '9876543210', '456 Market St, City B'),
(3, 'Mike Johnson', 'mikej@gmail.com', '1122334455', '789 Elm St, City C'),
(4, 'Alice Brown', 'aliceb@hotmail.com', '6677889900', '321 Pine St, City D'),
(5, 'Robert Lee', 'robertl@outlook.com', '9988776655', '654 Oak St, City E'),
(6, 'Emily Davis', 'emilyd@gmail.com', '5566778899', '987 Cedar St, City F'),
(7, 'Chris Wilson', 'chrisw@company.com', '1231231234', '432 Birch St, City G'),
(8, 'Laura Martin', 'lauram@gmail.com', '3213214321', '213 Maple St, City H'),
(9, 'James White', 'jamesw@gmail.com', '4445556666', '789 Aspen St, City I'),
(10, 'Olivia Green', 'oliviag@yahoo.com', '1112223333', '159 Spruce St, City J');

SELECT * FROM customers;


CREATE TABLE Products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    category VARCHAR(50),
    price DECIMAL(10, 2),
    stock_quantity INT
);

-- Insert 10 sample entries for Products
INSERT INTO Products (product_id, product_name, category, price, stock_quantity) VALUES
(101, 'Smartphone', 'Electronics', 299.99, 100),
(102, 'Laptop', 'Electronics', 899.99, 50),
(103, 'Desk Chair', 'Furniture', 149.99, 200),
(104, 'Gaming Console', 'Electronics', 499.99, 75),
(105, 'Blender', 'Home Appliances', 79.99, 150),
(106, 'Electric Kettle', 'Home Appliances', 39.99, 120),
(107, 'Bookshelf', 'Furniture', 89.99, 80),
(108, 'Tablet', 'Electronics', 199.99, 100),
(109, 'Headphones', 'Electronics', 59.99, 300),
(110, 'Microwave Oven', 'Home Appliances', 129.99, 90);

SELECT * FROM Products;

CREATE TABLE Categories (
    category_id INT PRIMARY KEY,
    category_name VARCHAR(50) NOT NULL
);

-- Insert 10 sample entries for Categories
INSERT INTO Categories (category_id, category_name) VALUES
(1, 'Electronics'),
(2, 'Furniture'),
(3, 'Home Appliances'),
(4, 'Books'),
(5, 'Toys'),
(6, 'Sports'),
(7, 'Clothing'),
(8, 'Footwear'),
(9, 'Beauty'),
(10, 'Automotive');

SELECT * FROM Categories;

CREATE TABLE Orders (
    order_id INT PRIMARY KEY,
    order_date DATE,
    customer_id INT,
    total_amount DECIMAL(10, 2),
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);

-- Insert 10 sample entries for Orders
INSERT INTO Orders (order_id, order_date, customer_id, total_amount) VALUES
(1001, '2024-10-01', 1, 499.99),
(1002, '2024-10-02', 2, 299.99),
(1003, '2024-10-03', 3, 79.99),
(1004, '2024-10-04', 4, 129.99),
(1005, '2024-10-05', 5, 899.99),
(1006, '2024-10-06', 6, 59.99),
(1007, '2024-10-07', 7, 39.99),
(1008, '2024-10-08', 8, 149.99),
(1009, '2024-10-09', 9, 199.99),
(1010, '2024-10-10', 10, 89.99);

SELECT * FROM Orders;

CREATE TABLE OrderDetails (
    order_details_id INT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT,
    price DECIMAL(10, 2),
    FOREIGN KEY (order_id) REFERENCES Orders(order_id),
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
);

-- Insert 10 sample entries for OrderDetails
INSERT INTO OrderDetails (order_details_id, order_id, product_id, quantity, price) VALUES
(1, 1001, 101, 2, 299.99),
(2, 1002, 108, 1, 199.99),
(3, 1003, 105, 1, 79.99),
(4, 1004, 110, 1, 129.99),
(5, 1005, 102, 1, 899.99),
(6, 1006, 109, 2, 59.99),
(7, 1007, 106, 1, 39.99),
(8, 1008, 103, 1, 149.99),
(9, 1009, 108, 1, 199.99),
(10, 1010, 107, 1, 89.99);

SELECT * FROM OrderDetails;

CREATE TABLE Payments (
    payment_id INT PRIMARY KEY,
    order_id INT,
    payment_type VARCHAR(50),
    payment_date DATE,
    amount DECIMAL(10, 2),
    FOREIGN KEY (order_id) REFERENCES Orders(order_id)
);

-- Insert 10 sample entries for Payments
INSERT INTO Payments (payment_id, order_id, payment_type, payment_date, amount) VALUES
(5001, 1001, 'Credit Card', '2024-10-01', 499.99),
(5002, 1002, 'Debit Card', '2024-10-02', 299.99),
(5003, 1003, 'PayPal', '2024-10-03', 79.99),
(5004, 1004, 'Net Banking', '2024-10-04', 129.99),
(5005, 1005, 'Credit Card', '2024-10-05', 899.99),
(5006, 1006, 'Debit Card', '2024-10-06', 59.99),
(5007, 1007, 'UPI', '2024-10-07', 39.99),
(5008, 1008, 'PayPal', '2024-10-08', 149.99),
(5009, 1009, 'Net Banking', '2024-10-09', 199.99),
(5010, 1010, 'Credit Card', '2024-10-10', 89.99);

SELECT * FROM Payments;

CREATE TABLE Reviews (
    review_id INT PRIMARY KEY,
    product_id INT,
    customer_id INT,
    rating INT,
    review_text VARCHAR(500),
    review_date DATE,
    FOREIGN KEY (product_id) REFERENCES Products(product_id),
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);

-- Insert 10 sample entries for Reviews
INSERT INTO Reviews (review_id, product_id, customer_id, rating, review_text, review_date) VALUES
(1, 101, 1, 5, 'Great smartphone, totally worth the price!', '2024-10-02'),
(2, 102, 2, 4, 'Good laptop but battery life could be better.', '2024-10-03'),
(3, 103, 3, 5, 'Comfortable chair, perfect for office use.', '2024-10-04'),
(4, 104, 4, 3, 'Console has heating issues after long use.', '2024-10-05'),
(5, 105, 5, 5, 'Excellent blender, powerful motor!', '2024-10-06'),
(6, 106, 6, 4, 'Kettle boils water quickly, good build.', '2024-10-07'),
(7, 107, 7, 3, 'Bookshelf is a bit wobbly, not very sturdy.', '2024-10-08'),
(8, 108, 8, 5, 'Tablet is smooth and user-friendly.', '2024-10-09'),
(9, 109, 9, 4, 'Headphones have good sound quality but a bit uncomfortable.', '2024-10-10'),
(10, 110, 10, 5, 'Microwave is spacious and heats evenly.', '2024-10-11');

SELECT * FROM Reviews;

-- CONNECTION OF TABLES.

-- FINAL APPROACH.

SELECT *
FROM customers AS C
JOIN orders AS O
ON C.customer_id = O.customer_id
JOIN payments AS P
ON O.order_id = P.order_id
JOIN reviews AS R
ON R.customer_id = C.customer_id
JOIN products AS PR
ON PR.product_id = R.product_id; 



