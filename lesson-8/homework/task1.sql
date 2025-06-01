/*
1. Write an SQL statement that counts the consecutive values in the Status field.

Input table (`Groupings`):

| **Step Number** | **Status** |
| --------------- | ---------- |
| 1               | Passed     |
| 2               | Passed     |
| 3               | Passed     |
| 4               | Passed     |
| 5               | Failed     |
| 6               | Failed     |
| 7               | Failed     |
| 8               | Failed     |
| 9               | Failed     |
| 10              | Passed     |
| 11              | Passed     |
| 12              | Passed     |
    
Expected Output:

| **Min Step Number** | **Max Step Number** | **Status** | **Consecutive Count** |
| ------------------- | ------------------- | ---------- | --------------------- |
| 1                   | 4                   | Passed     | 4                     |
| 5                   | 9                   | Failed     | 5                     |
| 10                  | 12                  | Passed     | 3                     |

---

*/


Drop table If EXISTS Groupings 

CREATE TABLE Groupings (
    StepNumber INT,
    Status VARCHAR(10)
);

INSERT INTO Groupings VALUES
(1, 'Passed'),
(2, 'Passed'),
(3, 'Passed'),
(4, 'Passed'),
(5, 'Failed'),
(6, 'Failed'),
(7, 'Failed'),
(8, 'Failed'),
(9, 'Failed'),
(10, 'Passed'),
(11, 'Passed'),
(12, 'Passed');


select 
Min(stepNumber) as MinStepNumber,
MAX(stepNumber) as MaxStepNumber,
Status,
COUNT(StepNumber) as ConsecutiveCount
from (
    select
    *,
    StepNumber - 
    (
        SELECT COUNT(*)
        from Groupings g2
        WHERE g2.StepNumber < g1.StepNumber and g2.[Status] = g1.Status
    ) as grp
from Groupings g1
) as MyTable
GROUP BY grp, Status