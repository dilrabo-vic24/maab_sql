CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerName VARCHAR(100),
    OrderDate DATE,
    TotalAmount DECIMAL(10,2),
    Status VARCHAR(20) CHECK (Status IN ('Pending', 'Shipped', 'Delivered', 'Cancelled'))
);

-- - Selects customers who placed orders **between** '2023-01-01' and '2023-12-31'.

SELECT customers 
FROM Orders
WHERE OrderDate BETWEEN '2023-01-01' AND '2023-12-31';

-- - Includes a new column `OrderStatus` that returns:
--   - 'Completed' for **Shipped** or **Delivered** orders.  
--   - 'Pending' for **Pending** orders.  
--   - 'Cancelled' for **Cancelled** orders.  

SELECT *,
    CASE
        WHEN Status IN ('Shipped', 'Delivered') THEN 'Completed'
        WHEN Status = 'Pending' THEN 'Pending'
        WHEN Status = 'Cancelled' THEN 'Cancelled'
        ELSE 'Unknown'
    END AS OrderStatus
FROM Orders

-- - Groups by `OrderStatus` and finds the **total number of orders** and **total revenue**. 
SELECT COUNT(*) AS TotalOrders, SUM(TotalAmount) AS TotalRevenue
    FROM Orders
    GROUP BY OrderStatus


-- - Filters only statuses where revenue is greater than 5000.  
SELECT Status, SUM(TotalAmount) AS TotalRevenue
FROM Orders
WHERE  SUM(TotalAmount) > 5000


-- - Orders by `TotalRevenue` **descending**.
SELECT * FROM
ORDER BY  SUM(TotalAmount) DESC