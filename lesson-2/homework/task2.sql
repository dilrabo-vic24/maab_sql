DROP TABLE IF EXISTS data_types_demo;
GO

Create table with various data types
CREATE TABLE data_types_demo (
    id INT IDENTITY(1,1) PRIMARY KEY,
    -- Exact Numerics
    product_code INT,                  -- Standard integer
    item_count SMALLINT,             -- Smaller integer range
    atomic_number TINYINT,             -- Very small integer (0-255)
    national_debt BIGINT,              -- Large integer
    price DECIMAL(10, 2),            -- Fixed precision and scale (e.g., 12345678.99)
    tax_rate NUMERIC(5, 4),            -- Similar to DECIMAL

    -- Approximate Numerics

    scientific_measurement FLOAT,       -- Floating point number (approximate)
    -- Date and Time
    order_date DATE,                   -- Date only (YYYY-MM-DD)
    event_time TIME,                   -- Time only (hh:mm:ss.nnnnnnn)
    last_updated DATETIME2,            -- Date and Time with high precision
    legacy_timestamp SMALLDATETIME,    -- Older Date and Time (less precision, smaller range)

    -- Character Strings
    item_name VARCHAR(100),          
    description_unicode NVARCHAR(255), 
    fixed_code CHAR(10),              
    fixed_unicode NCHAR(5),            
    long_text TEXT,                    
    long_unicode_text NTEXT,           
    max_varchar VARCHAR(MAX),         
    max_nvarchar NVARCHAR(MAX),        

    -- Binary Strings
    file_hash BINARY(32),              -- Fixed-length binary data
    small_image VARBINARY(1024),       -- Variable-length binary data
    large_file VARBINARY(MAX),         -- Modern LOB binary data
    legacy_image IMAGE,                -- Legacy LOB binary data (use VARBINARY(MAX) instead usually)
    -- Other Types
    is_active BIT,                     -- Boolean (0, 1, or NULL)
    row_guid UNIQUEIDENTIFIER          -- Globally Unique Identifier
);
GO

-- Insert sample values
INSERT INTO data_types_demo (
    product_code, item_count, atomic_number, national_debt, price, tax_rate,
    scientific_measurement, order_date, event_time, last_updated, legacy_timestamp,
    item_name, description_unicode, fixed_code, fixed_unicode, long_text, long_unicode_text,
    max_varchar, max_nvarchar, file_hash, small_image, large_file, legacy_image,
    is_active, row_guid
) VALUES (
    1001, 50, 6, 23456789012345, 199.99, 0.0825,
    6.02214076E23, '2023-10-27', '14:30:05.1234567', GETDATE(), '2023-10-27 10:00:00',
    'Standard Widget', N'描述 Standard Widget - üéøå', 'FIXED123', N'UNIØD', 'This is legacy text.', N'This is legacy Unicode text.',
    'Very long variable non-unicode text...', N'Very long variable unicode text... π',
    CAST(HASHBYTES('SHA2_256', 'SomeData') AS BINARY(32)), 0x1234ABCD, 0xFFFEFDFC, 0xABCDEF0123,
    1, NEWID()
);
GO

SELECT * FROM data_types_demo;
GO