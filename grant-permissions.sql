-- =======================================================
-- grant-permissions.sql
--
-- This file sets up MySQL users and grants appropriate
-- privileges for the Sephora-like e-commerce shop project.
--
-- Users defined:
-- 1. admin: Administrative user with full privileges.
-- 2. client: Client user with restricted privileges (SELECT, INSERT, UPDATE, DELETE).
--
-- Assumes the database is named "ecommerce_db".
-- =======================================================

DROP USER IF EXISTS 'admin'@'localhost', 'client'@'localhost';

-- Create an admin user for the shop.
CREATE USER 'admin'@'localhost' IDENTIFIED BY 'adminpw';

-- Create a client user for the shop.
CREATE USER 'client'@'localhost' IDENTIFIED BY 'clientpw';

-- Grant all privileges to the admin user on the entire database.
GRANT ALL PRIVILEGES ON ecommerce_db.* TO 'admin'@'localhost';

-- Grant limited privileges (SELECT, INSERT, UPDATE, DELETE) to the client user.
GRANT SELECT, INSERT, UPDATE, DELETE ON ecommerce_db.* TO 'client'@'localhost';
GRANT SELECT ON ecommerce_db.reviews TO 'client'@'localhost';
GRANT SELECT ON ecommerce_db.orders TO 'client'@'localhost';
GRANT SELECT ON ecommerce_db.* TO 'client'@'localhost';
GRANT EXECUTE ON ecommerce_db.* TO 'client'@'localhost';

-- GRANT EXECUTE ON ecommerce_db.reviews TO 'client'@'localhost';
-- GRANT EXECUTE ON ecommerce_db.orders TO 'client'@'localhost';

-- Ensure that the privileges take effect immediately.
FLUSH PRIVILEGES;