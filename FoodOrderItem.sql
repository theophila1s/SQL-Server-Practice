use Theatre;

CREATE TABLE FoodOrderItem (
order_item_id int identity primary key,
order_id int,
item_id int,
size_id int,
quantity int,
price_at_time decimal(10,2),
foreign key (order_id) references FoodOrder(order_id),
foreign key (item_id) references FoodItem(item_id),
foreign key (size_id) references FoodItemSize(size_id)
);

SELECT * FROM FoodOrderItem;

INSERT INTO FoodOrderItem (order_id, item_id, size_id, quantity, price_at_time)
VALUES
(4, 1, 1, 2, 160.00),  -- 2 small popcorns
(6, 2, 4, 1, 50.00),   -- 1 Pepsi 500ml
(2, 3, 2, 3, 120.00),  -- 1 medium popcorn
(3, 5, 3, 4, 150.00),  -- 1 large popcorn
(NULL, 2, 1, 1, 70.00),
(4, 1, 1, 2, 160.00),  -- 2 small popcorns
(6, 2, 4, 1, 50.00),   -- 1 Pepsi 500ml
(2, 3, 2, 3, 120.00),
(2, 3, 2, NULL, 120.00),  -- 1 medium popcorn
(3, 5, 3, 4, 150.00),  -- 1 large popcorn
(3, 2, 1, 1, NULL);   -- 1 Pepsi 750ml

UPDATE FoodOrderItem
SET quantity = 3
WHERE order_item_id = 1;

DELETE FROM FoodOrderItem
WHERE order_item_id = 5;

SELECT * FROM FoodOrderItem
ORDER BY order_item_id
OFFSET 2 ROWS
FETCH NEXT 2 ROWS ONLY;


--ORDER BY

SELECT order_item_id, price_at_time,quantity FROM FoodOrderItem 
ORDER BY price_at_time DESC;


SELECT item_id, size_id, quantity FROM FoodOrderItem 
ORDER BY Quantity;


SELECT order_item_id, item_id, size_id FROM FoodOrderItem 
ORDER BY size_id DESC;


--DISTINCT

SELECT DISTINCT(order_id) FROM
FoodOrderItem;


-- GROUP BY + AGGREGATE FUNCTION

SELECT item_id, SUM(quantity) as Total_Quantity , SUM(price_at_time) as Total_Price FROM FoodOrderItem 
GROUP BY item_id;


--- HAVING

SELECT order_id, MAX(quantity) as Max_Quantity, price_at_time FROM FoodOrderItem 
GROUP BY order_id, price_at_time HAVING MAX(quantity) > 3;

SELECT quantity, AVG(price_at_time) AS Avg_Price  FROM FoodOrderItem
GROUP BY quantity HAVING AVG(price_at_time) <>50;

SELECT item_id, MIN(size_id) AS MinSize, COUNT(quantity) AS TotQuantity FROM FoodOrderItem 
GROUP BY item_id HAVING COUNT(quantity) >=6;

SELECT order_id, SUM(quantity) AS Sum_Quantity FROM FoodOrderItem 
GROUP BY order_id;

------TRUNCATE 




---- WHERE 

SELECT order_id, quantity, price_at_time FROM FoodOrderItem 
WHERE price_at_time = 50;

SELECT order_id, quantity, price_at_time FROM FoodOrderItem 
WHERE price_at_time > 50;

SELECT order_id, quantity, price_at_time FROM FoodOrderItem 
WHERE price_at_time <> 150;

SELECT order_id, quantity, price_at_time FROM FoodOrderItem 
WHERE price_at_time != 70;

SELECT order_id, quantity, price_at_time FROM FoodOrderItem 
WHERE price_at_time < 70;

SELECT order_id, quantity, price_at_time FROM FoodOrderItem 
WHERE price_at_time >= 150;

SELECT order_id, quantity, price_at_time FROM FoodOrderItem 
WHERE price_at_time <= 120;


---JOINS 
        
        ---INNER JOIN

SELECT * FROM FoodOrderItem 
INNER JOIN FoodOrder ON FoodOrder.order_id = FoodOrder.order_id
INNER JOIN FoodItemSize ON FoodItemSize.rate = FoodItemSize.rate;

         ---- LEFT JOIN

SELECT * FROM FoodOrderItem
LEFT JOIN FoodOrder ON FoodOrderItem.order_id = FoodOrder.order_id
LEFT JOIN FoodItemSize ON FoodOrderItem.size_id = FoodItemSize.size_id; 
         ---- RIGHT JOIN
SELECT * FROM FoodOrderItem
RIGHT JOIN FoodOrder ON FoodOrderItem.order_id = FoodOrder.order_id           
RIGHT JOIN FoodItemSize ON FoodOrderItem.size_id = FoodItemSize.size_id;

        ---- FULL JOIN
SELECT * FROM FoodOrderItem
FULL JOIN FoodOrder ON FoodOrderItem.order_id = FoodOrder.order_id
FULL JOIN FoodItemSize ON FoodOrderItem.size_id = FoodItemSize.size_id;   --- allows null values

        --- CROSS JOIN
SELECT *FROM FoodOrderItem
CROSS JOIN FoodItemSize;        

        --- SELF JOIN
SELECT * FROM FoodOrderItem F1
JOIN FoodOrderItem F2 ON F1.quantity = F2.quantity AND F1.order_item_id <> F2.order_item_id; 


