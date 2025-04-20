CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Department VARCHAR(50),
    Salary DECIMAL(10,2),
    HireDate DATE
);

-- Selects the **top 10% highest-paid** employees.
SELECT TOP 10 PERCENTAGE
FROM Employees

-- Groups them by **department** and calculates the **average salary per department**.
SELECT Department, AVG(Salary) AS AverageSalary
FROM Employees
    GROUP BY Department;


-- - Displays a new column `SalaryCategory`:
--   - 'High' if Salary > 80,000  
--   - 'Medium' if Salary is **between** 50,000 and 80,000  
--   - 'Low' otherwise.  

SELECT *,
    CASE 
        WHEN Salary > 80000 THEN 'High'
        WHEN Salary BETWEEN 50000 AND 80000 THEN 'Medium'
        ELSE 'Low'
    END AS SalaryCategory
FROM Employees;

-- - Orders the result by `AverageSalary` **descending**.

SELECT * FROM Employees
ORDER BY AverageSalary DESC;


-- - Skips the first 2 records and fetches the next 5.

SELECT *FROM Employees
OFFSET 2 ROWS FETCH NEXT 5 ROWS ONLY;