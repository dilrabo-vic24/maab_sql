DROP TABLE IF EXISTS test_identity;
GO

CREATE TABLE test_identity (
    id INT IDENTITY(1,1) PRIMARY KEY,
    data VARCHAR(50)
);
GO

INSERT INTO test_identity (data) VALUES
('Row 1'),
('Row 2'),
('Row 3'),
('Row 4'),
('Row 5');

SELECT * FROM test_identity;

DELETE FROM test_identity;

SELECT * FROM test_identity;

INSERT INTO test_identity (data) VALUES ('After Delete');

SELECT * FROM test_identity;

DROP TABLE IF EXISTS test_identity;
CREATE TABLE test_identity (id INT IDENTITY(1,1) PRIMARY KEY, data VARCHAR(50));
INSERT INTO test_identity (data) VALUES ('Row 1'), ('Row 2'), ('Row 3'), ('Row 4'), ('Row 5');
SELECT * FROM test_identity;

TRUNCATE TABLE test_identity;

SELECT * FROM test_identity;

INSERT INTO test_identity (data) VALUES ('After Truncate');

SELECT * FROM test_identity;

DROP TABLE IF EXISTS test_identity;
CREATE TABLE test_identity (id INT IDENTITY(1,1) PRIMARY KEY, data VARCHAR(50));
INSERT INTO test_identity (data) VALUES ('Row 1'), ('Row 2'), ('Row 3'), ('Row 4'), ('Row 5');
SELECT * FROM test_identity;

DROP TABLE test_identity;

Msg 208, Level 16, State 1, Line X
Invalid object name 'test_identity'.
*/
