CREATE TABLE account(
    account_id INT PRIMARY KEY,
    balance DECIMAL(10, 2) CHECK(balance >= 0)
    account_type CHECK(account_type IN ('Saving', 'Checking'))
);

ALTER TABLE account
DROP CONSTRAINT account_type;

ALTER TABLE account
DROP CONSTRAINT balance;

ALTER TABLE account
ADD CONSTRAINT CHECK(balance >= 0)

ALTER TABLE account
ADD CONSTRAINT CHECK(account_type IN ('Saving', 'Checking'))