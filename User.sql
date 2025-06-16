use Theatre;

create table User_table (
user_id int identity primary key,
name varchar(100),
email varchar(150),
phone varchar(15)
);

select * from User_table;

INSERT INTO User_table (name, email, phone) VALUES
('Alice Johnson', 'alice@example.com', '9876543210'),
('Bob Smith', 'bob@example.com', '9123456780'),
('Carol White', 'carol@example.com', '9000011122'),
('David Lee', 'david@example.com', '8899887766'),
('Eva Green', 'eva@example.com', '9988776655');

UPDATE User_table
SET phone = '9999999999'
WHERE name = 'Alice Johnson';

DELETE FROM User_table
WHERE name = 'Bob Smith';

SELECT * FROM User_table
ORDER BY user_id
OFFSET 2 ROWS
FETCH NEXT 2 ROWS ONLY;


-------- JOINS 


SELECT * FROM User_table;
SELECT * FROM FoodOrder;
SELECT * FROM Food;

---- LIKE OPERATOR

SELECT name,email FROM User_table 
WHERE name LIKE '_a%';


SELECT name,phone FROM User_table 
WHERE name LIKE '%a%';

SELECT name,phone FROM User_table 
WHERE name LIKE 'a_%';


