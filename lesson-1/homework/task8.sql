CREATE TABLE books(
    book_id INT PRIMARY KEY IDENTITY,
    title VARCHAR(50) NOT NULL,
    price DECIMAL(10, 2) CHECK(price > 0),
    genre VARCHAR(50) DEFAULT 'Unknown'
);


INSERT INTO books (title, price, genre)
VALUES ('Book 1', 100.0, 'Fiction');

INSERT INTO books (title, price)
VALUES ('Book 2', 200.0);

INSERT INTO books (title, price, genre)
VALUES ('Book 3', 0, 'Non-Fiction'); 

INSERT INTO books (title, price, genre)
VALUES ('', 300.0, 'Sci-Fi');
