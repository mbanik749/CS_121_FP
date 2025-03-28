/*
-- Drop existing tables to avoid conflicts.
-- The order here respects foreign key dependencies.
*/
DROP TABLE IF EXISTS reviews;
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS products;
DROP TABLE IF EXISTS users;
DROP TABLE IF EXISTS user_info;

/*
-- Create the products table.
-- This table stores information on each beauty product.
-- Columns include product details from product_info.csv.
*/
CREATE TABLE products (
    product_id INT PRIMARY KEY AUTO_INCREMENT,   -- Unique product identifier.
    name VARCHAR(255) NOT NULL,                   -- Name of the product.
    brand VARCHAR(255) NOT NULL,                  -- Brand name.
    category VARCHAR(255) NOT NULL,               -- Product category.
    price DECIMAL(10,2) NOT NULL CHECK (price >= 0),  -- Price must be zero or positive.
    ingredients TEXT,                             -- List of ingredients.
    average_rating DECIMAL(3,2) DEFAULT 0.0 CHECK (average_rating BETWEEN 0 AND 5)  -- Average rating must be between 0 and 5.
);

-- Create indexes on brand and category to improve search performance.
CREATE INDEX idx_brand ON products(brand);
CREATE INDEX idx_category ON products(category);

/*
-- Create the users table.
-- This table stores user information for both clients and admins.
-- Data such as username, email, and password hash are required.
*/
CREATE TABLE users (
    user_id INT PRIMARY KEY,       -- Unique user identifier.
    username VARCHAR(50) UNIQUE NOT NULL,           -- Username (must be unique).
    email VARCHAR(100) UNIQUE NOT NULL,             -- Email address (must be unique).
    password_hash VARCHAR(255) NOT NULL,            -- Hashed password for security.
    user_type ENUM('client', 'admin') NOT NULL      -- User role: 'client' for customers, 'admin' for site administrators.
);

-- usernames are up to 20 characters
CREATE TABLE user_info (
    user_id         CHAR(10),
    salt            CHAR(8)         NOT NULL,
    password_hash   BINARY(64)      NOT NULL,
    FOREIGN KEY (user_id) REFERENCES user(user_id)
);

/*
-- Create the reviews table.
-- This table stores reviews for products.
-- It links a review to both a user (the reviewer) and a product.
*/
CREATE TABLE reviews (
    review_id INT PRIMARY KEY AUTO_INCREMENT,      -- Unique review identifier.
    user_id INT NOT NULL,                           -- Reviewer.
    product_id INT NOT NULL,                        -- Product being reviewed.
    rating INT CHECK (rating BETWEEN 1 AND 5) NOT NULL,  -- Rating between 1 and 5.
    review_text TEXT,                               -- Review text.
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP, -- Timestamp.
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE,
    FOREIGN KEY (product_id) REFERENCES products(product_id) ON DELETE CASCADE
);

/*
-- Create the orders table.
-- This table records customer orders.
-- Each order is associated with a user and a product.
*/
CREATE TABLE orders (
    order_id INT PRIMARY KEY AUTO_INCREMENT,      -- Unique order identifier.
    user_id INT NOT NULL,                           -- References the user placing the order.
    product_id INT NOT NULL,                        -- References the product being ordered.
    address VARCHAR(255) NOT NULL,                  -- Shipping address.
    quantity INT NOT NULL CHECK (quantity > 0),       -- Quantity must be greater than zero (no negatives allowed).
    order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP, -- Order date.
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE,
    FOREIGN KEY (product_id) REFERENCES products(product_id) ON DELETE CASCADE
);