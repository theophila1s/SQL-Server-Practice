-----CREATE DATABASE

CREATE DATABASE CarRentalSystem;
USE CarRentalSystem;

-------CREATE SCHEMA

CREATE SCHEMA Rental;
GO

-------DDL COMMAND CREATING TABLES

-------creating table for Vehicle
CREATE TABLE Rental.Vehicles (
    vehicleID INT PRIMARY KEY,
    make VARCHAR(50),
    model VARCHAR(50),
    year INT,
    dailyRate DECIMAL(10, 2),
    available BIT CHECK (available IN (0,1)),
    passengerCapacity INT,
    engineCapacity INT
);

--------creating table for Customer
CREATE TABLE Rental.Customer (
    customerID INT PRIMARY KEY,
    firstName VARCHAR(50),
    lastName VARCHAR(50),
    email VARCHAR(100),
    phoneNumber VARCHAR(15)
);

--------creating table for Lease
CREATE TABLE Rental.Leasetable (
    leaseID INT PRIMARY KEY,
    vehicleID INT,
    customerID INT,
    startDate DATE,
    endDate DATE,
    type VARCHAR(20) CHECK (type IN ('DailyLease', 'MonthlyLease')),
    FOREIGN KEY (vehicleID) REFERENCES Rental.Vehicles(vehicleID),
    FOREIGN KEY (customerID) REFERENCES Rental.Customer(customerID)
);

--------creating table for Payment
CREATE TABLE Rental.Payments (
    paymentID INT PRIMARY KEY,
    leaseID INT,
    paymentDate DATE,
    amount DECIMAL(10, 2),
    FOREIGN KEY (leaseID) REFERENCES Rental.Leasetable(leaseID)
);

---------------------DML COMMAND INSERTING ROWS

----Inserting rows Vehicle table
INSERT INTO Rental.Vehicles (vehicleID, make, model, year, dailyRate, available, passengerCapacity, engineCapacity)  VALUES
(1, 'Toyota', 'Camry', 2022, 50.00, 1, 4, 1450),
(2, 'Honda', 'Civic', 2023, 45.00, 1, 7, 1500),
(3, 'Ford', 'Focus', 2022, 48.00, 0, 4, 1400),
(4, 'Nissan', 'Altima', 2023, 52.00, 1, 7, 1200),
(5, 'Chevrolet', 'Malibu', 2022, 47.00, 1, 4, 1800),
(6, 'Hyundai', 'Sonata', 2023, 49.00, 0, 7, 1400),
(7, 'BMW', '3 Series', 2023, 60.00, 1, 7, 2499),
(8, 'Mercedes', 'C-Class', 2022, 58.00, 1, 8, 2599),
(9, 'Audi', 'A4', 2022, 55.00, 0, 4, 2500),
(10, 'Lexus', 'ES', 2023, 54.00, 1, 4, 2500);


----Inserting rows Customer table

INSERT INTO Rental.Customer (customerID, firstName, lastName, email, phoneNumber) VALUES
(1, 'John', 'Doe', 'johndoe@example.com', '555-555-5555'),
(2, 'Jane', 'Smith', 'janesmith@example.com', '555-123-4567'),
(3, 'Robert', 'Johnson', 'robert@example.com', '555-789-1234'),
(4, 'Sarah', 'Brown', 'sarah@example.com', '555-456-7890'),
(5, 'David', 'Lee', 'david@example.com', '555-987-6543'),
(6, 'Laura', 'Hall', 'laura@example.com', '555-234-5678'),
(7, 'Michael', 'Davis', 'michael@example.com', '555-876-5432'),
(8, 'Emma', 'Wilson', 'emma@example.com', '555-432-1098'),
(9, 'William', 'Taylor', 'william@example.com', '555-321-6547'),
(10, 'Olivia', 'Adams', 'olivia@example.com', '555-765-4321');

-----Inserting rows Lease table

INSERT INTO Rental.Leasetable (leaseID, vehicleID, customerID, startDate, endDate, type) VALUES
(1, 1, 1, '2023-01-01', '2023-01-05', 'DailyLease'),
(2, 2, 2, '2023-02-15', '2023-02-28', 'MonthlyLease'),
(3, 3, 3, '2023-03-10', '2023-03-15', 'DailyLease'),
(4, 4, 4, '2023-04-20', '2023-04-30', 'MonthlyLease'),
(5, 5, 5, '2023-05-05', '2023-05-10', 'DailyLease'),
(6, 4, 3, '2023-06-15', '2023-06-30', 'MonthlyLease'),
(7, 7, 7, '2023-07-01', '2023-07-10', 'DailyLease'),
(8, 8, 8, '2023-08-12', '2023-08-15', 'MonthlyLease'),
(9, 3, 3, '2023-09-07', '2023-09-10', 'DailyLease'),
(10, 10, 10, '2023-10-10', '2023-10-31', 'MonthlyLease');

----Inserting rows Payment table
INSERT INTO Rental.Payments (paymentID, leaseID, paymentDate, amount) VALUES
(1, 1, '2023-01-03', 200.00),
(2, 2, '2023-02-20', 1000.00),
(3, 3, '2023-03-12', 75.00),
(4, 4, '2023-04-25', 900.00),
(5, 5, '2023-05-07', 60.00),
(6, 6, '2023-06-18', 1200.00),
(7, 7, '2023-07-03', 40.00),
(8, 8, '2023-08-14', 1100.00),
(9, 9, '2023-09-09', 80.00),
(10, 10, '2023-10-25', 1500.00);

------------------------DQL COMMAND

SELECT * FROM Rental.Vehicles;
SELECT * FROM Rental.Customer;
SELECT * FROM Rental.Leasetable;
SELECT * FROM Rental.Payments;

-------------------------------------------------------------------------------------------------------------------------
--- 1. Update the daily rate for a Mercedes car to 68.
UPDATE Rental.Vehicles
SET dailyRate = 68
WHERE make = 'Mercedes';

--- 2. Delete a specific customer and all associated leases and payments.
DELETE FROM Rental.Payments
WHERE leaseID IN (
    SELECT leaseID FROM Rental.Leasetable WHERE customerID = 3
);

DELETE FROM Rental.Leasetable
WHERE customerID = 3;

DELETE FROM Rental.Customer
WHERE customerID = 3;

---3. Rename the paymentDate column to transactionDate.
EXEC sp_rename 'Rental.Payments.paymentDate', 'transactionDate', 'COLUMN';

--- 4. Find a specific customer by email.
SELECT * FROM Rental.Customer
WHERE email = 'emma@example.com';

--- 5. Get active leases for a specific customer.
INSERT INTO Rental.Leasetable (leaseID, vehicleID, customerID, startDate, endDate, type) VALUES (11, 2, 2, '2023-09-07', '2025-09-17', 'DailyLease');
SELECT * FROM Rental.Leasetable
WHERE customerID = 2 AND endDate >= GETDATE();

---6. Find all payments made by a customer with a specific phone number.
SELECT p.*
FROM Rental.Payments p
JOIN Rental.Leasetable l ON p.leaseID = l.leaseID
JOIN Rental.Customer c ON l.customerID = c.customerID
WHERE c.phoneNumber = '555-123-4567';

--- 7. Calculate the average daily rate of all available cars.
SELECT AVG(dailyRate) AS AverageRate
FROM Rental.Vehicles
WHERE available = 1;

--- 8. Find the car with the highest daily rate.
SELECT TOP 1 *
FROM Rental.Vehicles
ORDER BY dailyRate DESC;

---9. Retrieve all cars leased by a specific customer.
SELECT v.*
FROM Rental.Vehicles v
JOIN Rental.Leasetable l ON v.vehicleID = l.vehicleID
WHERE l.customerID = 4;

---10. Find the details of the most recent lease.
SELECT TOP 1 *
FROM Rental.Leasetable
ORDER BY startDate DESC;

--- 11. List all payments made in the year 2023.
SELECT *
FROM Rental.Payments
WHERE YEAR(transactionDate) = 2023;

---12. Retrieve customers who have not made any payments.
SELECT c.*
FROM Rental.Customer c
WHERE NOT EXISTS (
    SELECT 1
    FROM Rental.Leasetable l
    JOIN Rental.Payments p ON l.leaseID = p.leaseID
    WHERE l.customerID = c.customerID
);

---13. Retrieve Car Details and Their Total Payments.
SELECT v.vehicleID, v.make, v.model, SUM(p.amount) AS TotalPaid
FROM Rental.Vehicles v
JOIN Rental.Leasetable l ON v.vehicleID = l.vehicleID
JOIN Rental.Payments p ON l.leaseID = p.leaseID
GROUP BY v.vehicleID, v.make, v.model;

--- 14. Calculate Total Payments for Each Customer.
SELECT c.customerID, c.firstName, c.lastName, SUM(p.amount) AS TotalSpent
FROM Rental.Customer c
JOIN Rental.Leasetable l ON c.customerID = l.customerID
JOIN Rental.Payments p ON l.leaseID = p.leaseID
GROUP BY c.customerID, c.firstName, c.lastName;

---15. List Car Details for Each Lease.
SELECT l.leaseID, v.make, v.model, l.startDate, l.endDate, l.type
FROM Rental.Leasetable l
JOIN Rental.Vehicles v ON l.vehicleID = v.vehicleID;

---16. Retrieve Details of Active Leases with Customer and Car Information.
SELECT l.leaseID, c.firstName, c.lastName, v.make, v.model, l.startDate, l.endDate
FROM Rental.Leasetable l
JOIN Rental.Customer c ON l.customerID = c.customerID
JOIN Rental.Vehicles v ON l.vehicleID = v.vehicleID
WHERE l.endDate >= GETDATE();

--- 17. Find the Customer Who Has Spent the Most on Leases.
SELECT TOP 1 c.customerID, c.firstName, c.lastName, SUM(p.amount) AS TotalSpent
FROM Rental.Customer c
JOIN Rental.Leasetable l ON c.customerID = l.customerID
JOIN Rental.Payments p ON l.leaseID = p.leaseID
GROUP BY c.customerID, c.firstName, c.lastName
ORDER BY TotalSpent DESC;

---18. List All Cars with Their Current Lease Information.
SELECT v.vehicleID, v.make, v.model, l.leaseID, l.startDate, l.endDate, c.firstName, c.lastName
FROM Rental.Vehicles v
LEFT JOIN Rental.Leasetable l ON v.vehicleID = l.vehicleID AND l.endDate >= GETDATE()
LEFT JOIN Rental.Customer c ON l.customerID = c.customerID;




------JOINS 1 (INNER JOIN/JOIN)

---Get lease type and vehicle model for all leases
SELECT l.leaseID, v.model, l.type
FROM Rental.Leasetable l
JOIN Rental.Vehicles v ON l.vehicleID = v.vehicleID;

---Show payment amounts with lease type
SELECT p.amount, l.type
FROM Rental.Payments p
JOIN Rental.Leasetable l ON p.leaseID = l.leaseID;

---List all customers along with their leased car make
SELECT c.firstName, c.lastName, v.make
FROM Rental.Customer c
JOIN Rental.Leasetable l ON c.customerID = l.customerID
JOIN Rental.Vehicles v ON l.vehicleID = v.vehicleID;

------------------JOINS-2 (LEFT JOIN/RIGHT JOIN/FULL JOIN)

---List all vehicles and any related leases (even if not leased)
SELECT v.make, v.model, l.leaseID
FROM Rental.Vehicles v
LEFT JOIN Rental.Leasetable l ON v.vehicleID = l.vehicleID;

---List all leases and show customer info if available
SELECT l.leaseID, c.firstName, c.lastName
FROM Rental.Leasetable l
RIGHT JOIN Rental.Customer c ON l.customerID = c.customerID;

--- Find all customers and their total payments (if any)
SELECT c.firstName, c.lastName, SUM(p.amount) AS TotalPaid
FROM Rental.Customer c
LEFT JOIN Rental.Leasetable l ON c.customerID = l.customerID
FULL JOIN Rental.Payments p ON l.leaseID = p.leaseID
GROUP BY c.firstName, c.lastName;

-----------------------------SUB QUERIES
---Find vehicles that were never leased
SELECT * FROM Rental.Vehicles
WHERE vehicleID NOT IN (SELECT vehicleID FROM Rental.Leasetable);

---List customers who leased a BMW
SELECT * FROM Rental.Customer
WHERE customerID IN (
    SELECT l.customerID
    FROM Rental.Leasetable l
    JOIN Rental.Vehicles v ON l.vehicleID = v.vehicleID
    WHERE v.make = 'BMW'
);

--- Find customers who have made a payment greater than the average
SELECT * FROM Rental.Customer
WHERE customerID IN (
    SELECT l.customerID
    FROM Rental.Leasetable l
    JOIN Rental.Payments p ON l.leaseID = p.leaseID
    WHERE p.amount > (SELECT AVG(amount) FROM Rental.Payments)
);

---------------------------AGGREGATE FUNCTIONS
---Count number of leases per vehicle
SELECT vehicleID, COUNT(*) AS LeaseCount
FROM Rental.Leasetable
GROUP BY vehicleID;

---Total revenue collected per lease type
SELECT l.type, SUM(p.amount) AS TotalRevenue
FROM Rental.Payments p
JOIN Rental.Leasetable l ON p.leaseID = l.leaseID
GROUP BY l.type;

---Average payment amount per customer
SELECT c.customerID, AVG(p.amount) AS AvgPayment
FROM Rental.Customer c
JOIN Rental.Leasetable l ON c.customerID = l.customerID
JOIN Rental.Payments p ON l.leaseID = p.leaseID
GROUP BY c.customerID;

-----------------------------------OPERATORS (LIKE/BETWEEN/IN)
--- Find customers with emails ending in @example.com
SELECT * FROM Rental.Customer
WHERE email LIKE '%@example.com';

--- Get payments made between 500 and 1500
SELECT * FROM Rental.Payments
WHERE amount BETWEEN 500 AND 1500;

---Retrieve cars from specific brands
SELECT * FROM Rental.Vehicles
WHERE make IN ('BMW', 'Audi', 'Mercedes');

------------------------------------------BUILT IN FUNCTIONS
---Get lease durations in days
SELECT leaseID, DATEDIFF(DAY, startDate, endDate) AS DurationDays
FROM Rental.Leasetable;

---Convert all customer first names to uppercase
SELECT customerID, UPPER(firstName) AS UpperName
FROM Rental.Customer;

---Convert all customer last names to lowercase
SELECT customerID, LOWER(lastName) AS LowerName
FROM Rental.Customer;

---Get current date and compare with lease start
SELECT leaseID, startDate, DATEDIFF(DAY, startDate, GETDATE()) AS DaysSinceStart
FROM Rental.Leasetable;
























