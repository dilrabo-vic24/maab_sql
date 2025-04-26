DROP TABLE IF EXISTS student;
GO

CREATE TABLE student (
    id INT IDENTITY(1,1) PRIMARY KEY,
    name VARCHAR(100),
    classes INT,
    tuition_per_class DECIMAL(10, 2),
    total_tuition AS (classes * tuition_per_class) 
);
GO

INSERT INTO student (name, classes, tuition_per_class)
VALUES 
('Anna', 5, 100.00),
('John', 3, 150.00),
('Charlie', 4, 120.00);
GO


SELECT * FROM student;