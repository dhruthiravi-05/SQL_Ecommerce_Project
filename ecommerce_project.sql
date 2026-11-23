CREATE DATABASE ecommerce_db;
USE ecommerce_db;
CREATE TABLE orders (
    Order_ID INT PRIMARY KEY,
    Customer_Name VARCHAR(50),
    Product VARCHAR(50),
    Category VARCHAR(50),
    Quantity INT,
    Price DECIMAL(10,2),
    Order_Date DATE,
    City VARCHAR(50),
    Status VARCHAR(20)
);
INSERT INTO orders VALUES
(1, 'Rahul', 'Laptop', 'Electronics', 1, 60000, '2026-01-05', 'Bangalore', 'Completed'),
(2, 'Priya', 'Mobile', 'Electronics', 2, 25000, '2026-01-08', 'Mumbai', 'Completed'),
(3, 'Arun', 'Headphones', 'Accessories', 3, 2000, '2026-01-10', 'Chennai', 'Completed'),
(4, 'Sneha', 'Laptop', 'Electronics', 1, 60000, '2026-01-12', 'Bangalore', 'Cancelled'),
(5, 'Kiran', 'Keyboard', 'Accessories', 2, 1500, '2026-01-15', 'Hyderabad', 'Completed'),
(6, 'Meena', 'Mobile', 'Electronics', 1, 25000, '2026-01-18', 'Bangalore', 'Completed'),
(7, 'Rahul', 'Mouse', 'Accessories', 2, 1000, '2026-01-20', 'Mumbai', 'Completed'),
(8, 'Priya', 'Laptop', 'Electronics', 1, 60000, '2026-01-22', 'Chennai', 'Completed'),
(9, 'Arun', 'Mobile', 'Electronics', 1, 25000, '2026-01-25', 'Hyderabad', 'Cancelled'),
(10, 'Sneha', 'Headphones', 'Accessories', 2, 2000, '2026-01-28', 'Bangalore', 'Completed');

SELECT * FROM orders;

SELECT Customer_Name, Product, Price
FROM orders;

SELECT *
FROM orders
WHERE Status = 'Completed';

SELECT *
FROM orders
WHERE Price > 20000;

SELECT *
FROM orders
WHERE City = 'Bangalore'
ORDER BY Price DESC;

SELECT COUNT(*) AS Total_Orders
FROM orders;

SELECT SUM(Quantity * Price) AS Total_Revenue
FROM orders
WHERE Status = 'Completed';

SELECT AVG(Price) AS Average_Price
FROM orders;

SELECT
    Category,
    SUM(Quantity * Price) AS Total_Revenue
FROM orders
WHERE Status = 'Completed'
GROUP BY Category;

SELECT
    Customer_Name,
    COUNT(*) AS Total_Orders
FROM orders
GROUP BY Customer_Name;

SELECT
    Customer_Name,
    COUNT(*) AS Total_Orders
FROM orders
GROUP BY Customer_Name
HAVING COUNT(*) > 1;

SELECT
    Category,
    SUM(Quantity * Price) AS Total_Revenue
FROM orders
WHERE Status = 'Completed'
GROUP BY Category
HAVING SUM(Quantity * Price) > 50000;


SELECT *
FROM orders
WHERE Price > (
    SELECT AVG(Price)
    FROM orders
);


SELECT Customer_Name
FROM orders
WHERE Product IN (
    SELECT Product
    FROM orders
    WHERE Category = 'Electronics'
);

SELECT *
FROM orders
WHERE price > (
    SELECT max(price)
    FROM orders
    WHERE Category = 'accessories'
);


WITH ProductRevenue AS (
    SELECT
        Product,
        SUM(Quantity * Price) AS Total_Revenue
    FROM orders
    WHERE Status = 'Completed'
    GROUP BY Product
)
SELECT *
FROM ProductRevenue;

WITH ProductRevenue AS (
    SELECT
        Product,
        SUM(Quantity * Price) AS Total_Revenue
    FROM orders
    WHERE Status = 'Completed'
    GROUP BY Product
)
SELECT *
FROM ProductRevenue
WHERE Total_Revenue > 10000;


WITH ProductRevenue AS (
    SELECT
        Product,
        SUM(Quantity * Price) AS Total_Revenue
    FROM orders
    WHERE Status = 'Completed'
    GROUP BY Product
)
SELECT
    Product,
    Total_Revenue,
    DENSE_RANK() OVER (
        ORDER BY Total_Revenue DESC
    ) AS Revenue_Rank
FROM ProductRevenue;


WITH ProductRevenue AS (
    SELECT
        Product,
        SUM(Quantity * Price) AS Total_Revenue
    FROM orders
    WHERE Status = 'Completed'
    GROUP BY Product
)
SELECT
    Product,
    Total_Revenue,
    ROW_NUMBER() OVER (
        ORDER BY Total_Revenue DESC
    ) AS Row_Num
FROM ProductRevenue;


SELECT
    Customer_Name,
    SUM(Quantity * Price) AS Total_Revenue
FROM orders
WHERE Status = 'Completed'
GROUP BY Customer_Name
HAVING SUM(Quantity * Price) > 50000
ORDER BY Total_Revenue DESC;


WITH ProductSales AS (
    SELECT
        Category,
        Product,
        SUM(Quantity) AS Total_Quantity
    FROM orders
    WHERE Status = 'Completed'
    GROUP BY Category, Product
),
RankedProducts AS (
    SELECT
        Category,
        Product,
        Total_Quantity,
        ROW_NUMBER() OVER (
            PARTITION BY Category
            ORDER BY Total_Quantity DESC
        ) AS rn
    FROM ProductSales
)
SELECT
    Category,
    Product,
    Total_Quantity
FROM RankedProducts
WHERE rn = 1;

SELECT
    COUNT(*) AS Total_Orders,
    SUM(Quantity) AS Total_Quantity_Sold,
    SUM(Quantity * Price) AS Total_Revenue
FROM orders
WHERE Status = 'Completed';















