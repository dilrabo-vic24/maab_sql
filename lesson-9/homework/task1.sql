DROP TABLE IF EXISTS Employees;

CREATE TABLE Employees
(
	EmployeeID  INTEGER PRIMARY KEY,
	ManagerID   INTEGER NULL,
	JobTitle    VARCHAR(100) NOT NULL
);
INSERT INTO Employees (EmployeeID, ManagerID, JobTitle) 
VALUES
	(1001, NULL, 'President'),
	(2002, 1001, 'Director'),
	(3003, 1001, 'Office Manager'),
	(4004, 2002, 'Engineer'),
	(5005, 2002, 'Engineer'),
	(6006, 2002, 'Engineer');

SELECT * from Employees

;WITH cte as (
    SELECT
    EmployeeId,
    ManagerID,
    JobTitle,
    0 as Depth
    from Employees
    where ManagerID is null
UNION ALL
SELECT
    e.EmployeeId,
    e.ManagerID,
    e.JobTitle,
    c.Depth + 1
FROM Employees e 
INNER JOIN cte as c 
    on c.EmployeeId = e.ManagerID
)
SELECT *
FROM cte
ORDER BY Depth, EmployeeID;