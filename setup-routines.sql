-- =======================================================
-- setup-routines.sql
--
-- This file defines the procedural SQL components for the
-- Sephora-like e-commerce shop.
--
-- It includes:
--   1. A UDF (get_discounted_price) to compute a discounted 
--      price for a given product.
--   2. A stored procedure (sp_place_order) to place an order.
--   3. Triggers to automatically update a product's average 
--      rating when a review is inserted, updated, or deleted.
--
-- Prerequisite: The DDL for tables (products, users, reviews, 
-- and orders) must be executed before running this file.
-- =======================================================

-- -------------------------------------------------------
-- 1. User-Defined Function: get_discounted_price
--    Given a product ID and a discount rate (e.g., 0.15 for 15% off),
--    returns the product's price after applying the discount.
-- -------------------------------------------------------
DELIMITER $$
CREATE FUNCTION get_discounted_price(
    p_product_id INT,
    p_discount_rate DECIMAL(4,2)
)
RETURNS DECIMAL(10,2) DETERMINISTIC
BEGIN
    DECLARE orig_price DECIMAL(10,2);
    
    -- Retrieve the original price from the products table.
    SELECT price INTO orig_price FROM products WHERE product_id = p_product_id;
    
    -- Calculate and return the discounted price.
    RETURN orig_price * (1 - p_discount_rate);
END$$
DELIMITER ;

-- -------------------------------------------------------
-- 2. Stored Procedure: sp_place_order
--    Places an order for a given user and product.
--    Inputs:
--      p_user_id    - the ID of the user placing the order.
--      p_product_id - the ID of the product to order.
--      p_address    - shipping address.
--      p_quantity   - number of items ordered.
--    Output:
--      p_order_id   - the auto-generated order ID.
-- -------------------------------------------------------
DELIMITER $$
CREATE PROCEDURE sp_place_order (
    IN p_user_id INT,
    IN p_product_id INT,
    IN p_address VARCHAR(255),
    IN p_quantity INT,
    OUT p_order_id INT
)
BEGIN
    DECLARE v_price DECIMAL(10,2);
    DECLARE v_total DECIMAL(10,2);
    
    -- Retrieve the product's price.
    SELECT price INTO v_price FROM products WHERE product_id = p_product_id;
    SET v_total = v_price * p_quantity;
    
    -- Insert a new order record.
    INSERT INTO orders (user_id, product_id, address, quantity)
    VALUES (p_user_id, p_product_id, p_address, p_quantity);
    
    -- Capture the auto-generated order ID.
    SET p_order_id = LAST_INSERT_ID();
    
    -- (Optionally, you could log the total or perform further operations.)
END$$
DELIMITER ;

-- -------------------------------------------------------
-- 3. Trigger: Update Average Rating After INSERT on Reviews
--    Whenever a new review is added, recalculate the product's 
--    average rating from all its reviews.
-- -------------------------------------------------------
DELIMITER $$
CREATE TRIGGER trg_update_avg_rating_after_insert
AFTER INSERT ON reviews
FOR EACH ROW
BEGIN
    UPDATE products
    SET average_rating = (
        SELECT IFNULL(AVG(rating), 0) FROM reviews WHERE product_id = NEW.product_id
    )
    WHERE product_id = NEW.product_id;
END$$
DELIMITER ;

-- -------------------------------------------------------
-- Optional: Additional triggers to update average rating on UPDATE and DELETE.
-- -------------------------------------------------------

-- Trigger: Update Average Rating After UPDATE on Reviews
DELIMITER $$
CREATE TRIGGER trg_update_avg_rating_after_update
AFTER UPDATE ON reviews
FOR EACH ROW
BEGIN
    UPDATE products
    SET average_rating = (
        SELECT IFNULL(AVG(rating), 0) FROM reviews WHERE product_id = NEW.product_id
    )
    WHERE product_id = NEW.product_id;
END$$
DELIMITER ;

-- Trigger: Update Average Rating After DELETE on Reviews
DELIMITER $$
CREATE TRIGGER trg_update_avg_rating_after_delete
AFTER DELETE ON reviews
FOR EACH ROW
BEGIN
    UPDATE products
    SET average_rating = (
        SELECT IFNULL(AVG(rating), 0) FROM reviews WHERE product_id = OLD.product_id
    )
    WHERE product_id = OLD.product_id;
END$$
DELIMITER ;

-- =======================================================
-- Role Checks
-- =======================================================

DROP FUNCTION IF EXISTS is_client;
DELIMITER $$

CREATE FUNCTION is_client(user_name VARCHAR(255))
RETURNS BOOLEAN
DETERMINISTIC
BEGIN
    DECLARE is_client_user BOOLEAN;

    SELECT (user_type = 'client') INTO is_client_user
    FROM users
    WHERE username = user_name;

    RETURN is_client_user;
END$$

DELIMITER ;

-- =======================================================
-- End of setup-routines.sql
-- =======================================================
