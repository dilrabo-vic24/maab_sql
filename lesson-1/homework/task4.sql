CREATE TABLE category(
    category_id INT PRIMARY KEY,
    category_name VARCHAR(50)
);

CREATE TABLE item(
    item_id INT PRIMARY KEY,
    item_name VARCHAR(50),
    category_id INT CONSTRAINT pf_category_id FOREIGN KEY REFERENCES category(category_id)
);

ALTER TABLE item
DROP CONSTRAINT pf_category_id;

ALTER TABLE item
ADD CONSTRAINT pf_category_id FOREIGN KEY(category_id) REFERENCES category(category_id);