

-------------------------------------SQLSERVER QUERY-6

CREATE DATABASE Sample;

USE Sample;

-- Create Customer table
CREATE TABLE Customer (
customer_id int Primary Key,
name varchar(100),
email varchar(100),
city varchar(50),
created_at Date
);

-- Create Products table
CREATE TABLE Products (
    product_id INT PRIMARY KEY,
    name VARCHAR(100),
    category VARCHAR(50),
    price DECIMAL(10, 2),
    stock INT
);

-- Create Orders table
CREATE TABLE Orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    product_id INT,
    quantity INT,
    order_date DATE,
    total_price DECIMAL(10, 2),
    FOREIGN KEY (customer_id) REFERENCES Customer(customer_id),
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
);


---------------------------------------------------------------------------------------

-- Insert data into Customer

INSERT INTO Customer (customer_id, name, email, city, created_at)
VALUES 
(1, 'Alice', 'alice@example.com', 'New York', '2023-01-01'),
(2, 'Bob', 'bob@example.com', 'Los Angeles', '2023-02-15'),
(3, 'Charlie', 'charlie@example.com', 'Chicago', '2023-03-20');

-- Insert data into Products
INSERT INTO Products (product_id, name, category, price, stock)
VALUES
(12, 'Laptop', 'Electronics', 999.99, 50),
(21, 'Phone', 'Electronics', 499.99, 100),
(35, 'Desk', 'Furniture', 199.99, 20);


-- Insert data into Orders
INSERT INTO Orders (order_id, customer_id, product_id, quantity, order_date, total_price)
VALUES
(1, 1, 12, 2, '2023-04-01', 1999.98),
(2, 2, 21, 1, '2023-05-01', 499.99),
(3, 3, 35, 1, '2023-06-01', 199.99);


-----------------------------------------------------------------------------------------------------

---DISPLAY DATA

SELECT * FROM Customer;

SELECT * FROM Products;

SELECT * FROM Orders;

--------------------------------------------------------------------------------------------------

-------
SELECT o.order_id, c.name AS customer_name, o.total_price
FROM Orders o JOIN Customer c ON o.customer_id = c.customer_id;

----------
SELECT DISTINCT c.name 
FROM Customer c JOIN Orders o ON c.customer_id = o.customer_id
WHERE YEAR(o.order_date) = 2023;

-----------
SELECT 
    p.name AS product_name, 
    SUM(o.quantity) AS total_sold,
    SUM(o.total_price) AS total_revenue
    FROM Orders o JOIN Products p ON o.product_id = p.product_id
    GROUP BY p.name;

-----------Identify the product with the highest revenue

SELECT TOP 1 
    p.name AS product_name,
    SUM(o.total_price) AS revenue
    FROM Orders o JOIN Products p ON o.product_id = p.product_id
    GROUP BY p.name
    ORDER BY revenue DESC;

--------------Calculate the average order value per customer.
SELECT 
    c.name AS customer_name,
    AVG(o.total_price) AS avg_order_value
    FROM Orders o JOIN Customer c ON o.customer_id = c.customer_id
    GROUP BY c.name;

-------------Retrieve customers who ordered products with stock below 30.
SELECT DISTINCT c.name 
    FROM Customer c 
    JOIN Orders o ON c.customer_id = o.customer_id
    JOIN Products p ON o.product_id = p.product_id
    WHERE p.stock < 30;

-------------Add a `referrer_id` column in Customers for this example.

ALTER TABLE Customer 
ADD referrer_id INT;

SELECT * FROM Customer;

-- Set referrer_id to NULL for the first customer (no referrer)

UPDATE Customer SET 
            referrer_id = NULL 
            WHERE customer_id = 1;

----- Assign customer 1 as the referrer for customers 2 and 3

UPDATE Customer 
    SET referrer_id = 1 
    WHERE customer_id IN (2,3);

---- Optionally, assign customer 2 as the referrer for customer 4

INSERT INTO Customer (customer_id, name, email, city, created_at, referrer_id) 
        VALUES
        (4, 'Zara', 'zara@gmail.com', 'London', '2024-04-23', NULL),
        (5, 'Alya', 'alya@gmail.com', 'France', '2025-10-28', NULL);
   
UPDATE Customer SET referrer_id = 2 
        WHERE customer_id = 4;

SELECT* FROM Customer;

-- Assign customer 3 as the referrer for customer 5

UPDATE Customer SET referrer_id = 3 
        WHERE customer_id = 5;


---------------------------------------------------------SQLSERVER QUERY-7

-----Sub Query

select* from Customer;
select* from Orders;
select* from Products;

SELECT name,email
    FROM Customer
    WHERE customer_id IN (
    SELECT customer_id FROM Orders WHERE total_price > 500
    );

SELECT c.customer_id,c.name,c.email,
        (SELECT COUNT(*) 
        FROM Orders o WHERE o.customer_id = c.customer_id) AS Total_orders 
FROM Customer c;

SELECT product_id,name FROM Products 
    WHERE product_id NOT IN (
        SELECT DISTINCT product_id FROM Orders
    );

SELECT name,email FROM Customer c
        WHERE customer_id IN (
            SELECT customer_id FROM Orders o 
            GROUP BY customer_id 
            HAVING SUM(total_price) > 
            (
            SELECT AVG(total_price) FROM Orders o
            ) 
        );

select* from Customer;
select*from Orders;

SELECT 
    c.name,
    t.total_spent
FROM 
    Customer c 
JOIN (
        SELECT 
            customer_id,
            SUM(total_price) AS total_spent
            FROM 
            Orders
            GROUP BY customer_id
      )
t ON c.customer_id = t.customer_id;


-------------------------------NEW TABLE

Use Sample;

CREATE TABLE employees (
    emp_id INT PRIMARY KEY,
    name VARCHAR(100),
    department_id VARCHAR(50),
    salary DECIMAL(10,2)
);

INSERT INTO employees (emp_id, name, department_id, salary) 
    VALUES 
    (1, 'Aliya', 402, 60000.00),
    (2, 'Lekha', 404, 45000.00),
    (3, 'Swetha', 401, 25000.00),
    (4, 'Ram', 402, 15000.00),
    (5, 'Raj', 404, 90000.00),
    (6, 'Ravina', 403, 28000.00);

SELECT * FROM employees;
            
--Find the Second Highest Salary
--You are given an employee table. Write a query to find the second highest salary using a subquery.

SELECT 
       MAX(salary) AS second_highest
FROM employees
WHERE salary < ( SELECT MAX(salary)  FROM employees);

---Find Employees With Salaries Above Their Department�s Average
---Retrieve the employees whose salaries are higher than the average salary in their respective departments.

SELECT emp_id, name, department_id , salary 
FROM employees e1 WHERE salary > (SELECT AVG(salary) FROM employees e2 WHERE  e1.department_id = e2.department_id);

--List Products That Haven�t Been Ordered
---You have a products table and an orders table. Find all products that have never been ordered.

select* from Products;
select* from Orders;

SELECT product_id ,name  AS product_name
FROM Products 
WHERE product_id NOT IN (
                        SELECT product_id FROM Orders);


----Customers Who Ordered More Than the Average Order Quantity
---Find customers who placed orders greater than the average order quantity.

select* from Customer;
select* from Orders;

SELECT customer_id, COUNT(order_id) AS total_orders
FROM Orders 
GROUP BY customer_id
HAVING COUNT(order_id) > (SELECT AVG(total_orders)
                            FROM ( SELECT COUNT(order_id) AS total_orders FROM Orders
                            GROUP BY  customer_id)
                         subquery); 
      
--Find Customers Who Ordered the Most Expensive Product
--Retrieve the details of customers who ordered the most expensive product.

SELECT customer_id,product_id, order_id 
FROM Orders 
WHERE product_id IN (SELECT product_id 
                    FROM Products 
                    WHERE price = (SELECT MAX(price) FROM Products));

SELECT emp_id, COUNT(*) as total_empid
FROM employees
GROUP BY emp_id
HAVING COUNT(*) > 1;


-----Find Students With Better Scores Than the Class Average
---Find students who scored above the average for their class.

USE Sample;

CREATE TABLE student (
        student_id INT PRIMARY KEY,
        name VARCHAR(100),
        score INT,
        class_id INT
);

SELECT * FROM student;

INSERT INTO student (student_id, name, score, class_id) VALUES
            (1, 'Bob', 50, 004),
            (2, 'Aron', 85, 004),
            (3, 'Maya', 90, 003),
            (4, 'Swathi', 70, 004),
            (5, 'Lavanya', 25, 004),
            (6, 'Shruthi', 50, 003);

SELECT student_id, name , score, class_id 
FROM student s1 
WHERE score > (SELECT AVG(score) FROM student s2
                                WHERE  s1.class_id = s2.class_id);



-----------------------------------------------------SQLSERVER QUERY-8
CREATE TABLE logs (
    log_id INT PRIMARY KEY,
    message VARCHAR(255),
    created_at DATETIME
);

CREATE TABLE accounts (
    account_id INT PRIMARY KEY,
    account_name VARCHAR(100),
    balance DECIMAL(10, 2)
);

INSERT INTO logs (log_id, message, created_at)
VALUES
(1, 'Transaction initiated', GETDATE()),
(2, 'Account balance checked', GETDATE()),
(3, 'Amount debited', GETDATE()),
(4, 'Amount credited', GETDATE()),
(5, 'Transaction committed', GETDATE());

INSERT INTO accounts (account_id, account_name, balance)
VALUES
(1, 'Alice', 5000.00),
(2, 'Bob', 2000.00),
(3, 'Charlie', 1500.00),
(4, 'David', 1000.00),
(5, 'Eva', 3000.00);

SELECT* FROM logs;
SELECT* FROM accounts;

BEGIN TRANSACTION;

-- Debit from account A
UPDATE accounts
SET balance = balance - 500
WHERE account_id = 1;

-- Credit to account B
UPDATE accounts
SET balance = balance + 500
WHERE account_id = 2;

-- Simulate an error (comment this out for a successful transaction)
-- ROLLBACK;

COMMIT;
-------------------------------------------------------------------------


CREATE TABLE department (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(100)
);


-- Insert into the parent table
INSERT INTO department (department_id, department_name)
VALUES (101, 'Sales');

-- Insert into the child table (valid due to foreign key constraint)
INSERT INTO employees (emp_id, name, department_id)
VALUES (1001, 'John Doe', 101);

COMMIT;

SELECT* FROM employees;


--- Attempt to violate consistency (this will fail)
INSERT INTO employees (emp_id, name, department_id)
VALUES (1002, 'Jane Doe', 999); 

SELECT* FROM employees;



----Isolation

-- Transaction A
BEGIN TRANSACTION;
UPDATE accounts SET balance = balance - 100 WHERE account_id = 1;

-- Transaction B
SELECT balance FROM accounts WHERE account_id = 1; -- Will not see the uncommitted update

-- Commit Transaction A
COMMIT;


---Durability

BEGIN TRANSACTION;

INSERT INTO logs (log_id, message, created_at)
VALUES (2, 'Transaction initiated', GETDATE());

COMMIT;

-- Simulate a crash (e.g., power failure)
-- Verify durability by checking the `logs` table after recovery.
SELECT * FROM logs WHERE log_id = 1; -- The row persists in the database.


--ACID

BEGIN TRANSACTION;

IF (SELECT balance FROM accounts WHERE account_id = 1) >= 1000
BEGIN
    -- Debit from account A
    UPDATE accounts SET balance = balance - 1000 WHERE account_id = 1;

    -- Credit to account B
    UPDATE accounts SET balance = balance + 1000 WHERE account_id = 2;

    -- Commit transaction
    COMMIT;
END
ELSE
BEGIN
    -- Rollback if insufficient balance
    ROLLBACK;
END;

SELECT* FROM logs;
SELECT* FROM accounts;