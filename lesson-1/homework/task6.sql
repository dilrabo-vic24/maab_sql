CREATE TABLE customer(
    customer_id INT PRIMARY KEY,
    name VARCHAR(50),
    city VARCHAR(50) DEFAULT 'Unknown'
);

ALTER TABLE customer
DROP CONSTRAINT DF_customer_city

ALTER TABLE customer
ADD CONSTRAINT DF_customer_city DEFAULT 'Unknown' FOR city;