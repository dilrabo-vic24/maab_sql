CREATE DATABASE MaabSqlLearning;

DROP TABLE IF EXISTS Customers;
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    CustomerName VARCHAR(100)
);
INSERT INTO Customers (CustomerID, CustomerName)
VALUES
(1, 'John Smith'),
(2, 'Emily Johnson'),
(3, 'Michael Brown'),
(4, 'Sophia Davis');



DROP TABLE IF EXISTS Orders;
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    OrderDate DATE
);
INSERT INTO Orders (OrderID, CustomerID, OrderDate)
VALUES
(101, 1, '2024-06-01'),
(102, 1, '2024-06-10'),
(104, 3, '2024-07-01'),
(105, 4, '2024-07-15');



DROP TABLE IF EXISTS OrderDetails;
CREATE TABLE OrderDetails (
    OrderDetailID INT PRIMARY KEY,
    OrderID INT FOREIGN KEY REFERENCES Orders(OrderID),
    ProductID INT,
    Quantity INT,
    Price DECIMAL(10,2)
);
INSERT INTO OrderDetails (OrderDetailID, OrderID, ProductID, Quantity, Price)
VALUES
(301, 101, 201, 1, 1200.00),
(302, 101, 204, 2, 25.00),
(303, 102, 203, 1, 900.00),
(305, 104, 204, 3, 25.00),
(306, 105, 201, 1, 1200.00);


DROP TABLE IF EXISTS Products;
CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100),
    Category VARCHAR(50)
);
INSERT INTO Products (ProductID, ProductName, Category)
VALUES
(201, 'Dell Laptop', 'Electronics'),
(202, 'Samsung Smartphone', 'Electronics'),
(203, 'Wooden Table', 'Stationery'),
(204, 'Book: SQL Fundamentals', 'Books');

select * from Customers;

/*
1️ Retrieve All Customers With Their Orders (Include Customers Without Orders)**
- Use an appropriate `JOIN` to list all customers, their order IDs, and order dates.
- Ensure that customers with no orders still appear.
*/

select
    *
from Customers c
left join Orders o
    on c.CustomerID = o.CustomerID;

/*
#### **2️ Find Customers Who Have Never Placed an Order**
- Return customers who have no orders.
*/
select
    *
from Customers c
left join Orders o
    on c.CustomerID = o.CustomerID
WHERE o.CustomerID is null;

/*
#### **3️ List All Orders With Their Products**
- Show each order with its product names and quantity.
*/

SELECT
    o.OrderID,
    o.CustomerID,
    o.OrderDate,
    p.ProductName,
    od.Quantity
from Orders o 
INNER JOIN OrderDetails od 
    on o.OrderID = od.OrderID
INNER JOIN Products p 
    on od.ProductID = p.ProductID;

/*
#### **4️ Find Customers With More Than One Order**
- List customers who have placed more than one order.
*/
SELECT
    c.CustomerID,
    c.CustomerName,
    COUNT(OrderID) AS TotalOrders
FROM Customers c 
JOIN Orders o 
    on c.CustomerID = o.CustomerID
GROUP BY c.CustomerID, c.CustomerName
HAVING COUNT(o.OrderID) > 1;

--#### **5️ Find the Most Expensive Product in Each Order**

SELECT 
    o.OrderID,
    p.ProductID,
    p.ProductName,
    od.Price as MaxPrice,
    od.Quantity
from Orders o 
JOIN OrderDetails od
    on o.OrderID = od.OrderID
JOIN Products p 
    on p.ProductID = od.ProductID
JOIN (
    select OrderId, MAX(Price) as MaxPrice
    from OrderDetails
    GROUP by OrderID
) t
    on o.OrderID = t.OrderID and od.Price = t.MaxPrice

--#### **6️ Find the Latest Order for Each Customer**

SELECT
    c.CustomerID,
    c.CustomerName,
    t.OrderID,
    t.LatestOrderDate
from Customers c
JOIN (
    SELECT 
    CustomerID, OrderId, MAX(OrderDate) as LatestOrderDate
    from Orders
    GROUP BY CustomerID, OrderID
)as t 
    on c.CustomerID = t.CustomerID

/*
#### **7️ Find Customers Who Ordered Only 'Electronics' Products**
- List customers who **only** purchased items from the 'Electronics' category.
*/

SELECT 
    c.CustomerID,
    c.CustomerName
from Customers c 
JOIN Orders o 
    on c.CustomerID = o.CustomerID
JOIN OrderDetails od 
    on o.OrderID = od.OrderID
JOIN Products p 
    on od.ProductID = p.ProductID 
GROUP BY c.CustomerID, c.CustomerName
HAVING COUNT(Distinct Case When p.Category <> 'Electronics' then p.ProductID end) = 0

/*
8️ Find Customers Who Ordered at Least One 'Stationery' Product**
- List customers who have purchased at least one product from the 'Stationery' category.
*/
SELECT 
    c.CustomerID,
    c.CustomerName
from Customers c 
JOIN Orders o 
    on c.CustomerID = o.CustomerID
JOIN OrderDetails od 
    on o.OrderID = od.OrderID
JOIN Products p 
    on od.ProductID = p.ProductID 
WHERE p.Category = 'Stationery'


/*
#### **9️ Find Total Amount Spent by Each Customer**
- Show `CustomerID`, `CustomerName`, and `TotalSpent`.
*/
select 
    c.CustomerID,
    c.CustomerName,
    SUM(od.Quantity * od.Price) as TotalSpent
from Customers c 
JOIN Orders o 
    on c.CustomerID = o.CustomerID
JOIN OrderDetails od 
    on o.OrderID = od.OrderID
GROUP BY c.CustomerID, c.CustomerName

