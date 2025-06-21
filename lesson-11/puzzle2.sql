-- ## **Puzzle 2: The Missing Orders**  
-- An e-commerce company tracks orders in two separate systems, but some orders are **missing** in one of them. You need to find the missing records.  

-- ### **Given Tables:**  

-- #### **Table 1: `Orders_DB1` (Main System)**  
-- | OrderID | CustomerName | Product | Quantity |  
-- |---------|-------------|---------|----------|  
-- | 101     | Alice       | Laptop  | 1        |  
-- | 102     | Bob         | Phone   | 2        |  
-- | 103     | Charlie     | Tablet  | 1        |  
-- | 104     | David       | Monitor | 1        |  

-- #### **Table 2: `Orders_DB2` (Backup System, with some missing records)**  
-- | OrderID | CustomerName | Product | Quantity |  
-- |---------|-------------|---------|----------|  
-- | 101     | Alice       | Laptop  | 1        |  
-- | 103     | Charlie     | Tablet  | 1        | 

drop TABLE if EXISTS Orders_DB1
CREATE TABLE Orders_DB1 (
    OrderID INT PRIMARY KEY,
    CustomerName VARCHAR(50),
    Product VARCHAR(50),
    Quantity INT
);

INSERT INTO Orders_DB1 VALUES
(101, 'Alice', 'Laptop', 1),
(102, 'Bob', 'Phone', 2),
(103, 'Charlie', 'Tablet', 1),
(104, 'David', 'Monitor', 1);

drop TABLE if EXISTS Orders_DB2
CREATE TABLE Orders_DB2 (
    OrderID INT PRIMARY KEY,
    CustomerName VARCHAR(50),
    Product VARCHAR(50),
    Quantity INT
);

INSERT INTO Orders_DB2 VALUES
(101, 'Alice', 'Laptop', 1),
(103, 'Charlie', 'Tablet', 1);


-- 1. Declare a **table variable** `@MissingOrders` with the same structure as `Orders_DB1`. 

DECLARE @MissingOrders TABLE (
    OrderID INT,
    CustomerName VARCHAR(50),
    Product VARCHAR(50),
    Quantity INT
);

-- 2. Insert **all orders that exist in `Orders_DB1` but not in `Orders_DB2`** into `@MissingOrders`.  
Insert Into @MissingOrders 
SELECT 
    db1.OrderID, 
    db1.CustomerName, 
    db1.Product, 
    db1.Quantity
from Orders_DB1 db1
Left Join Orders_DB2 db2
    on db1.OrderID = db2.OrderID
WHERE db2.OrderID is NULL

-- 3. Retrieve the missing orders.  

select * from @MissingOrders
ORDER BY OrderID