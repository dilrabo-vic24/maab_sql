CREATE TABLE product(
    product_id INT CONSTRAINT uq_product_id UNIQUE,
    product_name VARCHAR(50),
    price DECIMAL(8, 2)
);

ALTER TABLE product
DROP UNIQUE uq_product_id;

ALTER TABLE product
ADD UNIQUE(product_id);

ALTER TABLE product
ADD UNIQUE(product_id, product_name);