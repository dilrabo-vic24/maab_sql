/*
A company has a **rotational transfer policy** where employees **switch departments** every 6 months. You have an `Employees` table:  

| EmployeeID | Name  | Department | Salary  |  
|------------|-------|------------|---------|  
| 1          | Alice | HR         | 5000    |  
| 2          | Bob   | IT         | 7000    |  
| 3          | Charlie | Sales     | 6000    |  
| 4          | David | HR         | 5500    |  
| 5          | Emma  | IT         | 7200    |  

*/

drop table if EXISTS Employees

CREATE TABLE Employees(
    EmployeeId INT,
    Name VARCHAR(50),
    Department VARCHAR(20),
    Salary Int
)

INSERT INTO Employees (EmployeeID, Name, Department, Salary)
VALUES
    (1, 'Alice', 'HR', 5000),
    (2, 'Bob', 'IT', 7000),
    (3, 'Charlie', 'Sales', 6000),
    (4, 'David', 'HR', 5500),
    (5, 'Emma', 'IT', 7200);
-- 1. Create a **temporary table** `#EmployeeTransfers` 
-- with the same structure as `Employees`.  

drop TABLE if EXISTS  #EmployeeTransfers

SELECT * 
into #EmployeeTransfers
from Employees
WHERE 1 = 0

-- 2. **Swap departments** for each employee in a circular manner:  
--    - **HR → IT → Sales → HR**  
--    - Example: Alice (HR) moves to IT, Bob (IT) moves to Sales, Charlie (Sales) moves to HR. 
-- 3. Insert the updated records into `#EmployeeTransfers`. 

SELECT * from #EmployeeTransfers

INSERT INTO #EmployeeTransfers
select
    EmployeeId,
    Name,
    CASE
        when Department = 'IT' Then 'Sales'
        when Department = 'Sales' Then 'HR'
        when Department = 'HR' Then 'IT'
        Else Department
    End as Department,
    Salary
from Employees;

-- Step 4: Retrieve all records from #EmployeeTransfers
SELECT * FROM #EmployeeTransfers
ORDER BY EmployeeID;