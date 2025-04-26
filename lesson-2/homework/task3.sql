DROP TABLE IF EXISTS photos;
GO

CREATE TABLE photos (
    id INT IDENTITY(1,1) PRIMARY KEY,
    file_name VARCHAR(255),
    photo_data VARBINARY(MAX) NOT NULL
);
GO

SELECT id, file_name, DATALENGTH(photo_data) AS image_size_bytes
FROM photos;

DECLARE @ImagePath NVARCHAR(MAX) = '/home/dilrabo/Documents/image.jpg';

INSERT INTO photos (file_name, photo_data)
SELECT
    RIGHT(@ImagePath, CHARINDEX('/', REVERSE(@ImagePath)) - 1),
    BulkColumn
FROM OPENROWSET(BULK @ImagePath, SINGLE_BLOB) AS img;

SELECT id, file_name, DATALENGTH(photo_data) AS image_size_bytes
FROM photos;
