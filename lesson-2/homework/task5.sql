DROP TABLE IF EXISTS worker;
GO

CREATE TABLE worker (
    id INT PRIMARY KEY,
    name VARCHAR(100)
);
GO

BULK INSERT worker
FROM '/home/dilrabo/maab_sql/lesson-2/homework/task.csv'
WITH (
    FORMAT = 'csv',
    FIRSTROW = 2,
    FIELDTERMINATOR = ',', 
    ROWTERMINATOR = '\n'
);

SELECT * FROM worker;