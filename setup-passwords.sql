-- This file sets up password management for the e-commerce shop.
-- It creates a "user_credentials" table to store the login credentials,
-- including a hashed password and a salt, and a stored procedure to add 
-- new credentials.
--
-- Precondition: The user must already exist in the "users" table.
-- The password hash is computed using the SHA2() function (256-bit hash).

-- Drop the table if it already exists to avoid conflicts.
DROP TABLE IF EXISTS user_credentials;

-- Create the user_credentials table.
CREATE TABLE user_credentials (
    user_id INT PRIMARY KEY,                -- Unique identifier matching the "users" table.
    username VARCHAR(50) NOT NULL,           -- Username (should match the username in the users table).
    password_hash CHAR(64) NOT NULL,         -- SHA-256 hash of the plain-text password concatenated with the salt.
    salt CHAR(16) NOT NULL,                  -- A randomly generated 16-character salt.
    UNIQUE (username),                       -- Enforce unique usernames.
    FOREIGN KEY (user_id) REFERENCES users(user_id)
        ON DELETE CASCADE ON UPDATE CASCADE  -- Ensures referential integrity with the users table.
);

-- Stored Procedure: sp_add_user
-- This procedure adds a new user credential entry.
-- It takes a username and a plain-text password, generates a random salt,
-- computes the SHA-256 hash of the password+salt, and inserts the credentials.
--
-- Precondition: The username must already exist in the "users" table.

DELIMITER $$
CREATE PROCEDURE sp_add_user (
    IN p_username VARCHAR(50),
    IN p_plain_password VARCHAR(100)
)
BEGIN
    DECLARE v_salt CHAR(16);
    DECLARE v_hash CHAR(64);
    DECLARE v_user_id INT;

    -- Retrieve the user_id corresponding to the given username from the users table.
    SELECT user_id INTO v_user_id FROM users WHERE username = p_username;

    -- If no matching user is found, signal an error.
    IF v_user_id IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'User not found in users table.';
    END IF;

    -- Generate a random 16-character salt using MD5 of a random number.
    SET v_salt = SUBSTRING(MD5(RAND()), 1, 16);

    -- Compute the hash of the plain-text password concatenated with the salt.
    SET v_hash = SHA2(CONCAT(p_plain_password, v_salt), 256);

    -- Insert the new credential record into the user_credentials table.
    INSERT INTO user_credentials (user_id, username, password_hash, salt)
    VALUES (v_user_id, p_username, v_hash, v_salt);
END$$
DELIMITER ;