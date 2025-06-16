use Theatre;

CREATE TABLE PointsTransaction (
    transaction_id INT IDENTITY PRIMARY KEY,
    user_id INT,
    amount DECIMAL(10,2),
    points_earned INT,
    transaction_datetime DATETIME,
    transaction_type VARCHAR(20),
    FOREIGN KEY (user_id) REFERENCES User_table(user_id)
);


SELECT * FROM PointsTransaction;

INSERT INTO PointsTransaction (user_id, amount, points_earned, transaction_datetime, transaction_type)
VALUES
(1, 300.00, 30, GETDATE(), 'Purchase'),
(3, 150.00, 15, GETDATE(), 'Purchase'),
(3, 500.00, 50, GETDATE(), 'Purchase'),
(4, 100.00, 10, GETDATE(), 'Reward'),
(5, 200.00, 20, GETDATE(), 'Refund');

UPDATE PointsTransaction
SET points_earned = 25
WHERE transaction_id = 2;

DELETE FROM PointsTransaction
WHERE transaction_id = 4;

SELECT * FROM PointsTransaction
ORDER BY transaction_id
OFFSET 2 ROWS
FETCH NEXT 2 ROWS ONLY;


---- DATE TIME FUNCTIONS

----GETDATE
SELECT *
FROM PointsTransaction
WHERE transaction_datetime <= GETDATE();


---DATEPART
SELECT 
    transaction_id,
    DATEPART(year, transaction_datetime) AS tr_year,
    DATEPART(month, transaction_datetime) AS tr_month,
    DATEPART(day, transaction_datetime) AS tr_date
FROM PointsTransaction;


---FORMAT
SELECT 
    transaction_id,
    FORMAT(transaction_datetime, 'dd-MM-yyyy hh:mm tt') AS formatted_date
FROM PointsTransaction;


----DATEADD
SELECT 
    transaction_id,
    DATEADD(day, 7, transaction_datetime) AS date_plus_7_days
FROM PointsTransaction;


-----CONVERT
SELECT 
    transaction_id,
    CONVERT(varchar, transaction_datetime, 103) AS converted_date -- dd/mm/yyyy
FROM PointsTransaction;


------STRING FUNCTIONS

----LEFT
SELECT transaction_id, LEFT(transaction_type, 3) AS short_type
FROM PointsTransaction;

----PATINDEX

SELECT transaction_id, PATINDEX('%fund%', transaction_type) AS pattern_position
FROM PointsTransaction;

-----CHARINDEX
SELECT transaction_id, CHARINDEX('Pur', transaction_type) AS found_at
FROM PointsTransaction;

-----LTRIM
SELECT transaction_id, transaction_type, LTRIM(transaction_type) AS trimmed_left
FROM PointsTransaction;

-----RTRIM
SELECT transaction_id, transaction_type, RTRIM(transaction_type) AS trimmed_right
FROM PointsTransaction;

-----SUBSTRING
SELECT transaction_id, SUBSTRING(transaction_type, 2, 4) AS mid_text
FROM PointsTransaction;

-----REPLICATE
SELECT transaction_id, points_earned,REPLICATE('*', points_earned) AS point_stars
FROM PointsTransaction;

------DIFFERENCE
SELECT transaction_type ,DIFFERENCE('refund', transaction_type) AS sound_diff
FROM PointsTransaction;


-----STUFF
SELECT transaction_id, STUFF(transaction_type, 2, 3, 'XXX') AS modified_type
FROM PointsTransaction;

-----REVERSE
SELECT transaction_id, REVERSE(transaction_type) AS reversed_type
FROM PointsTransaction;

-----QUOTENAME
SELECT transaction_id, QUOTENAME(transaction_type) AS quoted_type
FROM PointsTransaction;






