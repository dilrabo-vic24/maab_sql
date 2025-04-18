CREATE TABLE Book(
    book_id INT PRIMARY KEY,
    title VARCHAR(50) NOT NULL,
    author VARCHAR(50),
    published_year INT
);

CREATE TABLE Member(
    member_id INT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    email VARCHAR(50),
    phone_number VARCHAR(50)
);

CREATE TABLE Loan(
    load_id INT PRIMARY KEY,
    book_id INT FOREIGN KEY REFERENCES Book(book_id),
    member_id INT FOREIGN KEY REFERENCES Member(member_id), 
    loan_date DATE NOT NULL
    return_date DATE NULL
);

INSERT INTO Book (book_id, title, author, published_year)
VALUES
    (1, 'The Great Gatsby', 'F. Scott Fitzgerald', 1925),
    (2, '1984', 'George Orwell', 1949),
    (3, 'To Kill a Mockingbird', 'Harper Lee', 1960);


INSERT INTO Member (member_id, name, email, join_date)
VALUES
    (1, 'Alice Johnson', 'alice@example.com', '2023-01-15'),
    (2, 'Bob Smith', 'bob@example.com', '2023-03-22');

INSERT INTO Loan (loan_id, book_id, member_id, loan_date, return_date) 
VALUES
    (1, 1, 1, '2025-04-10', '2025-04-17'),
    (2, 2, 2, '2025-04-12', NULL),
    (3, 3, 1, '2025-04-15', NULL);
