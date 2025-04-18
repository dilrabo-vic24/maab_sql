CREATE TABLE invoice_id(
    invoice_id IDENTITY(1, 1),
    amount DECIMAL(10, 2)
);

INSERT INTO invoice_id(amount)
    VALUES(100),
    VALUES(200),
    VALUES(300),
    VALUES(400),
    VALUES(500);


SET IDENTITY_INSERT invoice_id ON;
SET IDENTITY_INSERT invoice_id OFF;


INSERT INTO invoice_id(invoice_id, amount)
    VALUES(100, 600)