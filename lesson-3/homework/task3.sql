CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100),
    Category VARCHAR(50),
    Price DECIMAL(10,2),
    Stock INT
);

-- - Selects **distinct** product categories.

SELECT DISTINCT Category FROM Products;

-- - Finds the **most expensive** product in each category.

SELECT Category, MAX(PRICE) AS MaxPrice
FROM Products
GROUP BY Category;

-- - Assigns an inventory status using `IIF`:
--   - 'Out of Stock' if `Stock = 0`.  
--   - 'Low Stock' if `Stock` is **between** 1 and 10.  
--   - 'In Stock' otherwise.  

SELECT *,
    IIF(Stock = 0, 'Out of Stock',
        IIF(Stock BETWEEN 1 AND 10, 'Low Stock', 'In Stock')
    ) AS Status
FROM Products;

-- - Orders the result by `Price` **descending** and skips the first 5 rows.

SELECT * FROM Products
ORDER BY Price DESC
OFFSET 5 ROWS;