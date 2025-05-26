create DATABASE EmployeeDataBase;

DROP TABLE IF EXISTS Employees;

CREATE TABLE Employees (
    EmployeeID INT IDENTITY(1,1) PRIMARY KEY,
    Name VARCHAR(50) NOT NULL,
    Department VARCHAR(50) NOT NULL,
    Salary DECIMAL(10,2) NOT NULL,
    HireDate DATE NOT NULL
);

INSERT INTO Employees (Name, Department, Salary, HireDate) VALUES
    ('Alice', 'HR', 50000, '2020-06-15'),
    ('Bob', 'HR', 60000, '2018-09-10'),
    ('Charlie', 'IT', 70000, '2019-03-05'),
    ('David', 'IT', 80000, '2021-07-22'),
    ('Eve', 'Finance', 90000, '2017-11-30'),
    ('Frank', 'Finance', 75000, '2019-12-25'),
    ('Grace', 'Marketing', 65000, '2016-05-14'),
    ('Hank', 'Marketing', 72000, '2019-10-08'),
    ('Ivy', 'IT', 67000, '2022-01-12'),
    ('Jack', 'HR', 52000, '2021-03-29');

select * from Employees;

--1. Assign a Unique Rank to Each Employee Based on Salary
select *,
    ROW_NUMBER() OVER(order by Salary)
from Employees
ORDER by Salary;

--2. Find Employees Who Have the Same Salary Rank

--3. Identify the Top 2 Highest Salaries in Each Department
SELECT *
    from
    (
        select *,
        ROW_NUMBER() OVER(partition by Department ORDER by Salary desc) as SalaryRank
        from Employees
    )as RankedEmployees
where SalaryRank <= 2;

--4. Find the Lowest-Paid Employee in Each Department
SELECT *
    from
    (
        select *,
        ROW_NUMBER() OVER(partition by Department ORDER by Salary) as SalaryRank
        from Employees
    )as RankedEmployees
where SalaryRank = 1;

--5. Calculate the Running Total of Salaries in Each Department
SELECT 
    *,
    SUM(Salary) OVER (
        PARTITION BY Department 
        ORDER BY HireDate, EmployeeID 
    ) AS RunningTotalSalary
FROM Employees
ORDER BY Department, HireDate, EmployeeID;

--6. Find the Total Salary of Each Department Without GROUP BY
SELECT 
    *,
    SUM(Salary) OVER (
        PARTITION BY Department 
    ) AS TotalSalary
FROM Employees
ORDER BY Department;

--7. Calculate the Average Salary in Each Department Without GROUP BY

SELECT 
    *,
    CAST(
            AVG(Salary) OVER (
            PARTITION BY Department 
        ) as decimal(10, 2)
    ) as AvgSalary
FROM Employees
ORDER BY Department;

--8. Find the Difference Between an Employee’s Salary and Their Department’s Average
SELECT 
    *,
    ABS(salary - (CAST(
            AVG(Salary) OVER (
            PARTITION BY Department 
        ) as decimal(10, 2)
    ))) as AvgSalary
FROM Employees
ORDER BY Department;

--9. Calculate the Moving Average Salary Over 3 Employees (Including Current, Previous, and Next)
SELECT
    *,
    cast(AVG(Salary) OVER(order by EmployeeID rows Between 1 preceding and 1 following) as decimal(10, 2))as MovingAvgSalary
from Employees;

--10. Find the Sum of Salaries for the Last 3 Hired Employees
SELECT
    SUM(Salary) as SumSalary
    from(
        select top 3 Salary 
        from Employees
        ORDER BY HireDate desc
    )as Last3;

--11. Calculate the Running Average of Salaries Over All Previous Employees
select *,
    cast(AVG(salary) OVER(order by EmployeeID) as decimal(10, 2)) as RunningAvg
from Employees
ORDER by EmployeeID;

--12. Find the Maximum Salary Over a Sliding Window of 2 Employees Before and After
SELECT *,
    MAX(Salary) OVER(ORDER by EmployeeID rows Between 2 preceding and 2 following) as MaxSalary
from Employees;

--13. Determine the Percentage Contribution of Each Employee’s Salary to Their Department’s Total Salary
SELECT 
    *,
    CAST(Salary * 100.0 / SUM(Salary) OVER(PARTITION BY Department) AS DECIMAL(10,2)) AS SalaryPercentage
FROM Employees;

