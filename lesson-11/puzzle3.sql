-- You are given a database that tracks **employee working hours**. The company needs a **monthly summary report** that calculates:  
-- - **Total hours worked per employee**  
-- - **Total hours worked per department**  
-- - **Average hours worked per department**  

-- ### **Given Table: `WorkLog`**  
-- | EmployeeID | EmployeeName | Department | WorkDate   | HoursWorked |  
-- |------------|-------------|------------|------------|-------------|  
-- | 1          | Alice       | HR         | 2024-03-01 | 8           |  
-- | 2          | Bob         | IT         | 2024-03-01 | 9           |  
-- | 3          | Charlie     | Sales      | 2024-03-02 | 7           |  
-- | 1          | Alice       | HR         | 2024-03-03 | 6           |  
-- | 2          | Bob         | IT         | 2024-03-03 | 8           |  
-- | 3          | Charlie     | Sales      | 2024-03-04 | 9           |  

drop TABLE if EXISTS Worklog

CREATE TABLE WorkLog (
    EmployeeID INT,
    EmployeeName VARCHAR(50),
    Department VARCHAR(50),
    WorkDate DATE,
    HoursWorked INT
);

INSERT INTO WorkLog VALUES
(1, 'Alice', 'HR', '2024-03-01', 8),
(2, 'Bob', 'IT', '2024-03-01', 9),
(3, 'Charlie', 'Sales', '2024-03-02', 7),
(1, 'Alice', 'HR', '2024-03-03', 6),
(2, 'Bob', 'IT', '2024-03-03', 8),
(3, 'Charlie', 'Sales', '2024-03-04', 9);


-- 1. Create a **view** `vw_MonthlyWorkSummary` that calculates:  
--    - `EmployeeID`, `EmployeeName`, `Department`, **TotalHoursWorked** (SUM of hours per employee).  
--    - `Department`, **TotalHoursDepartment** (SUM of all hours per department).  
--    - `Department`, **AvgHoursDepartment** (AVG hours worked per department).
GO

CREATE VIEW vw_MonthlyWorkSummary AS
WITH EmployeeHours AS (
    SELECT
        EmployeeID,
        EmployeeName,
        Department,
        SUM(HoursWorked) AS TotalHoursWorked
    FROM WorkLog
    GROUP BY EmployeeID, EmployeeName, Department
),
DepartmentStats AS (
    SELECT
        Department AS DeptName,
        SUM(HoursWorked) AS TotalHoursDepartment,
        AVG(HoursWorked) AS AvgHoursDepartment
    FROM WorkLog
    GROUP BY Department
)
SELECT
    e.EmployeeID,
    e.EmployeeName,
    e.Department,
    e.TotalHoursWorked,
    d.TotalHoursDepartment,
    d.AvgHoursDepartment
FROM EmployeeHours e
JOIN DepartmentStats d ON e.Department = d.DeptName;

GO

SELECT * FROM vw_MonthlyWorkSummary;