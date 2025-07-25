drop TABLE if EXISTS Employee;

Create table Employee (id int, salary int)

insert into Employee (id, salary) values ('1', '100')
insert into Employee (id, salary) values ('2', '200')
insert into Employee (id, salary) values ('3', '300')

select * from Employee

---------------------------------------------------
SELECT  
t.salary as SecondHighestSalary 
from
(
    SELECT
        *,
        ROW_NUMBER() OVER(order by Salary) as rn
    from Employee
) t
where t.rn = 2

SELECT
(
    select distinct Salary from Employee
    ORDER By salary Desc 
    OFFSET 1 Row FETCH NEXT 1 ROW ONLY
) as SecondHighestSalary

--------------------------------------------------------------
GO
CREATE FUNCTION getNthHighestSalary2(@N INT)
RETURNS INT
AS
BEGIN
    IF @N < 1
        RETURN NULL;

    RETURN (
        SELECT Salary
        FROM (
            SELECT DISTINCT Salary
            FROM Employee
        ) AS DistinctSalaries
        ORDER BY Salary DESC
        OFFSET @N - 1 ROWS FETCH NEXT 1 ROWS ONLY
    );
END;
GO

select dbo.getNthHighestSalary(2) as SecondHighestSalary


--------------------------------------------------------------------
drop table if EXISTS Scores
Create table Scores (id int, score DECIMAL(3,2))
Truncate table Scores
insert into Scores (id, score) values ('1', '3.5')
insert into Scores (id, score) values ('2', '3.65')
insert into Scores (id, score) values ('3', '4.0')
insert into Scores (id, score) values ('4', '3.85')
insert into Scores (id, score) values ('5', '4.0')
insert into Scores (id, score) values ('6', '3.65')

select * from Scores



SELECT 
    score,
    DENSE_RANK() OVER (ORDER BY score DESC) AS rank
FROM Scores
ORDER BY score DESC;

SELECT
    s1.score,
    (
        select count(distinct s2.score) 
        from scores s2
        where s2.score > s1.score
    ) + 1 as rank
from scores s1


----------------------------------------------------------------------
drop table if EXISTS Logs
Create table  Logs (id int, num int)
Truncate table Logs
insert into Logs (id, num) values ('1', '1')
insert into Logs (id, num) values ('2', '1')
insert into Logs (id, num) values ('3', '1')
insert into Logs (id, num) values ('4', '2')
insert into Logs (id, num) values ('5', '1')
insert into Logs (id, num) values ('6', '2')
insert into Logs (id, num) values ('7', '2')

select * from Logs



SELECT DISTINCT
    t.num AS ConsecutiveNums
FROM
(
    SELECT
        num, 
        LAG(num, 1) OVER (ORDER BY id) AS prev,
        LEAD(num, 1) OVER (ORDER BY id) AS next
    FROM Logs
) t
WHERE t.num = t.prev AND t.num = t.next;

---------------------------------------------------------
drop table if EXISTS Employee;
Create table  Employee (id int, name varchar(255), salary int, managerId int)

insert into Employee (id, name, salary, managerId) values ('1', 'Joe', '70000', '3')
insert into Employee (id, name, salary, managerId) values ('2', 'Henry', '80000', '4')
insert into Employee (id, name, salary, managerId) values ('3', 'Sam', '60000', NULL)
insert into Employee (id, name, salary, managerId) values ('4', 'Max', '90000', NULL)

select * from Employee;

select
    e.name as Employee
from Employee e 
 join Employee m 
    on e.managerId = m.id and e.salary > m.salary

---------------------------------------------------------
drop table if EXISTS Person
Create table  Person (id int, email varchar(255))
insert into Person (id, email) values ('1', 'a@b.com')
insert into Person (id, email) values ('2', 'c@d.com')
insert into Person (id, email) values ('3', 'a@b.com')

select * from Person

SELECT email
    FROM Person
    GROUP BY email
    HAVING COUNT(*) > 1

with temp as (
select email,
row_number() over(partition by email ORDER BY (SELECT NULL)) as rnk
from person
)

select distinct email from temp where rnk > 1

----------------------------------------------------------------
drop TABLE if EXISTS Customers
drop TABLE if EXISTS Orders
Create table  Customers (id int, name varchar(255))
Create table  Orders (id int, customerId int)
Truncate table Customers
insert into Customers (id, name) values ('1', 'Joe')
insert into Customers (id, name) values ('2', 'Henry')
insert into Customers (id, name) values ('3', 'Sam')
insert into Customers (id, name) values ('4', 'Max')
Truncate table Orders
insert into Orders (id, customerId) values ('1', '3')
insert into Orders (id, customerId) values ('2', '1')

select * from Customers 
select * from Orders

select 
    c.name as Customers
from Customers c 
left join Orders o 
    on c.id = o.customerId
where o.customerId is null

-------------------------------------------------------------------
drop table if EXISTS Employee
drop table if EXISTS Department

Create Table Employee (id int, name varchar(255), salary int, departmentId int)
Create Table Department (id int, name varchar(255))
Truncate table Employee
insert into Employee (id, name, salary, departmentId) values ('1', 'Joe', '70000', '1')
insert into Employee (id, name, salary, departmentId) values ('2', 'Jim', '90000', '1')
insert into Employee (id, name, salary, departmentId) values ('3', 'Henry', '80000', '2')
insert into Employee (id, name, salary, departmentId) values ('4', 'Sam', '60000', '2')
insert into Employee (id, name, salary, departmentId) values ('5', 'Max', '90000', '1')
Truncate table Department
insert into Department (id, name) values ('1', 'IT')
insert into Department (id, name) values ('2', 'Sales')

select * from Employee
select * from Department

select
    distinct departmentId
from Employee


select
    d.name as Department, 
    e.name as Employee, 
    e.salary as Salary
from Employee e 
join Department d 
    on e.departmentId = d.id
join (
    SELECT departmentId, MAX(salary) AS maxSalary
    FROM Employee
    GROUP BY departmentId
)t 
on t.maxSalary = e.salary and t.departmentId = d.id

--------------------------------------------------------------------
drop table if EXISTS Employee
drop table if EXISTS Department

Create Table Employee (id int, name varchar(255), salary int, departmentId int)
Create Table Department (id int, name varchar(255))
Truncate table Employee
insert into Employee (id, name, salary, departmentId) values ('1', 'Joe', '85000', '1')
insert into Employee (id, name, salary, departmentId) values ('2', 'Henry', '80000', '2')
insert into Employee (id, name, salary, departmentId) values ('3', 'Sam', '60000', '2')
insert into Employee (id, name, salary, departmentId) values ('4', 'Max', '90000', '1')
insert into Employee (id, name, salary, departmentId) values ('5', 'Janet', '69000', '1')
insert into Employee (id, name, salary, departmentId) values ('6', 'Randy', '85000', '1')
insert into Employee (id, name, salary, departmentId) values ('7', 'Will', '70000', '1')
Truncate table Department
insert into Department (id, name) values ('1', 'IT')
insert into Department (id, name) values ('2', 'Sales')

select * from Employee
select * from Department


select 
    d.name as Department,
    t.name as Employee,
    t.salary as Salary
from(
    select 
        *,
        Dense_Rank() OVER(partition by departmentId order by salary desc) as rnk
    from Employee
)t
join Department d
on t.departmentId = d.id
where rnk <= 3

-----------------------------------------------------------------------
drop table if exists Person

Create table  Person (Id int, Email varchar(255))
Truncate table Person
insert into Person (id, email) values ('1', 'john@example.com')
insert into Person (id, email) values ('2', 'bob@example.com')
insert into Person (id, email) values ('3', 'john@example.com')

select * from Person

delete from Person
where id not in(
select min(id)
from Person GROUP by Email
)

select * from PErson


-----------------------------------------------------------------------

drop table if EXISTS Weather 
Create table  Weather (id int, recordDate date, temperature int)
Truncate table Weather
insert into Weather (id, recordDate, temperature) values ('1', '2015-01-01', '10')
insert into Weather (id, recordDate, temperature) values ('2', '2015-01-02', '25')
insert into Weather (id, recordDate, temperature) values ('3', '2015-01-03', '20')
insert into Weather (id, recordDate, temperature) values ('4', '2015-01-04', '30')

select * from Weather

select
    w1.id
from Weather w1 
right join Weather w2
    on w1.recordDate = DATEADD(day, 1, w2.recordDate) 
where w1.temperature > w2.temperature

----------------------------------------------------------------------------
DROP TABLE IF EXISTS Trips;
DROP TABLE IF EXISTS Users;

CREATE TABLE Trips (
    id INT,
    client_id INT,
    driver_id INT,
    city_id INT,
    status VARCHAR(50), -- ENUM emas, VARCHAR
    request_at VARCHAR(50)
);

CREATE TABLE Users (
    users_id INT,
    banned VARCHAR(50),
    role VARCHAR(50) -- ENUM emas, VARCHAR
);

TRUNCATE TABLE Trips;

INSERT INTO Trips (id, client_id, driver_id, city_id, status, request_at) VALUES
(1, 1, 10, 1, 'completed', '2013-10-01'),
(2, 2, 11, 1, 'cancelled_by_driver', '2013-10-01'),
(3, 3, 12, 6, 'completed', '2013-10-01'),
(4, 4, 13, 6, 'cancelled_by_client', '2013-10-01'),
(5, 1, 10, 1, 'completed', '2013-10-02'),
(6, 2, 11, 6, 'completed', '2013-10-02'),
(7, 3, 12, 6, 'completed', '2013-10-02'),
(8, 2, 12, 12, 'completed', '2013-10-03'),
(9, 3, 10, 12, 'completed', '2013-10-03'),
(10, 4, 13, 12, 'cancelled_by_driver', '2013-10-03');

TRUNCATE TABLE Users;

INSERT INTO Users (users_id, banned, role) VALUES
(1, 'No', 'client'),
(2, 'Yes', 'client'),
(3, 'No', 'client'),
(4, 'No', 'client'),
(10, 'No', 'driver'),
(11, 'No', 'driver'),
(12, 'No', 'driver'),
(13, 'No', 'driver');


SELECT * from Trips
SELECT * from Users


;with allTripCount as (
    select 
        request_at as Day,
        cast(COUNT(id) as float) as Count
    from Trips t
    join Users c on t.client_id = c.users_id and c.banned = 'No'
    join Users d on t.driver_id = d.users_id and d.banned = 'No'
    WHERE t.request_at BETWEEN '2013-10-01' AND '2013-10-03' 
    GROUP By request_at
),
sucTripCount as(
    select 
        request_at as Day,
        cast(COUNT(id) as float) as Count
    from Trips t
    join Users c on t.client_id = c.users_id and c.banned = 'No'
    join Users d on t.driver_id = d.users_id and d.banned = 'No'
    where t.status in ('cancelled_by_driver', 'cancelled_by_client') and  t.request_at BETWEEN '2013-10-01' AND '2013-10-03' 
    GROUP By request_at
)
SELECT 
    atc.[Day],
    Round(isnull(stc.[Count], 0)/atc.Count, 2) as [Cancellation Rate]
from allTripCount atc
left join sucTripCount stc
    on atc.[Day] = stc.[Day]

--------------------------------------------------------------------------------------------------------
drop table if EXISTS Activity
Create table  Activity (player_id int, device_id int, event_date date, games_played int)
Truncate table Activity
insert into Activity (player_id, device_id, event_date, games_played) values ('1', '2', '2016-03-01', '5')
insert into Activity (player_id, device_id, event_date, games_played) values ('1', '2', '2016-05-02', '6')
insert into Activity (player_id, device_id, event_date, games_played) values ('2', '3', '2017-06-25', '1')
insert into Activity (player_id, device_id, event_date, games_played) values ('3', '1', '2016-03-02', '0')
insert into Activity (player_id, device_id, event_date, games_played) values ('3', '4', '2018-07-03', '5')

select * from Activity


SELECT *
from(

SELECT
    player_id,
    ROW_NUMBER() OVER(partition by player_id order by event_date) as rn
from Activity
)t