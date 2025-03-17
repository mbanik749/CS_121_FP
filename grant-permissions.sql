-- =======================================================
-- grant-permissions.sql
--
-- This file sets up MySQL users and grants appropriate
-- privileges for the Sephora-like e-commerce shop project.
--
-- Users defined:
-- 1. shop_admin: Administrative user with full privileges.
-- 2. shop_client: Client user with restricted privileges (SELECT, INSERT, UPDATE, DELETE).
--
-- Assumes the database is named "ecommerce_db".
-- =======================================================

-- Create an admin user for the shop.
CREATE USER 'shop_admin'@'localhost' IDENTIFIED BY 'adminpw';

-- Create a client user for the shop.
CREATE USER 'shop_client'@'localhost' IDENTIFIED BY 'clientpw';

-- Grant all privileges to the admin user on the entire database.
GRANT ALL PRIVILEGES ON ecommerce_db.* TO 'shop_admin'@'localhost';

-- Grant limited privileges (SELECT, INSERT, UPDATE, DELETE) to the client user.
GRANT SELECT, INSERT, UPDATE, DELETE ON ecommerce_db.* TO 'shop_client'@'localhost';

-- Ensure that the privileges take effect immediately.
FLUSH PRIVILEGES;