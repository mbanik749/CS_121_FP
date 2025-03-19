-- This file contains sample SQL queries for the Sephora-like
-- e-commerce shop project.
--
-- The queries are designed to support common application features:
--   1. Product searches with filtering by category, brand, and price range.
--   2. Retrieving all reviews for a specific product.
--   3. Viewing a customer's order history with product details.
--   4. Retrieving product details along with review counts.
--   5. Updating an existing review.
--   6. Inserting a new review.
--   7. Retrieving the top 5 products by average rating (with at least 5 reviews).
--   8. Retrieving all reviews written by a specific user.
--   9. Aggregating total sales and revenue by product.
--  10. Retrieving orders placed within a specific date range.
--  11. Retrieving products with an average rating above a specified threshold.

-- Query 1: Retrieve products filtered by category, brand, and price range.
-- Example: Get products in the 'Skincare' category by brand 'Fenty Beauty',
-- with a price between $10.00 and $100.00.
SELECT product_id, name, brand, category, price, average_rating
FROM products
WHERE category = 'Skincare'
  AND brand = 'Fenty Beauty'
  AND price BETWEEN 10.00 AND 100.00;

-- Query 2: Retrieve all reviews for a specific product.
-- Example: Get all reviews for the product with product_id = 1,
-- ordered by the most recent review first.
SELECT review_id, user_id, rating, review_text, created_at
FROM reviews
WHERE product_id = 1
ORDER BY created_at DESC;

-- Query 3: Retrieve order history for a specific user.
-- Example: Get orders placed by the user with user_id = 1.
SELECT o.order_id, p.name AS product_name, p.brand, o.address, o.quantity, o.order_date
FROM orders o
JOIN products p ON o.product_id = p.product_id
WHERE o.user_id = 1
ORDER BY o.order_date DESC;

-- Query 4: Retrieve product details along with review count.
-- This query aggregates review data for each product.
SELECT p.product_id, p.name, p.brand, p.category, p.price, p.average_rating,
       COUNT(r.review_id) AS review_count
FROM products p
LEFT JOIN reviews r ON p.product_id = r.product_id
GROUP BY p.product_id, p.name, p.brand, p.category, p.price, p.average_rating;

-- Query 5: Update an existing review.
-- Example: Update review with review_id = 1 to set its rating to 5 and modify the review text.
UPDATE reviews
SET rating = 5,
    review_text = 'Updated review text: This product is fantastic!'
WHERE review_id = 1;

-- Query 6: Insert a new review for a product.
-- Example: Insert a new review for product_id = 1 by the user with user_id = 1.
INSERT INTO reviews (user_id, product_id, rating, review_text)
VALUES (1, 1, 5, 'This product is excellent!');

-- Query 7: Retrieve the top 5 products by average rating that have at least 5 reviews.
SELECT p.product_id, p.name, p.brand, p.average_rating, COUNT(r.review_id) AS review_count
FROM products p
JOIN reviews r ON p.product_id = r.product_id
GROUP BY p.product_id, p.name, p.brand, p.average_rating
HAVING COUNT(r.review_id) >= 5
ORDER BY p.average_rating DESC
LIMIT 5;

-- Query 8: Retrieve all reviews written by a specific user.
-- Example: Get reviews written by the user with user_id = 1.
SELECT review_id, product_id, rating, review_text, created_at
FROM reviews
WHERE user_id = 1
ORDER BY created_at DESC;

-- Query 9: Retrieve total units sold and total revenue per product.
-- Example: Aggregates sales data by joining orders with products.
SELECT p.product_id, p.name, SUM(o.quantity) AS total_units_sold, 
       SUM(o.quantity * p.price) AS total_revenue
FROM orders o
JOIN products p ON o.product_id = p.product_id
GROUP BY p.product_id, p.name
ORDER BY total_revenue DESC;

-- Query 10: Retrieve orders placed within a specific date range.
-- Example: Get orders placed between '2025-01-01' and '2025-12-31'.
SELECT order_id, user_id, product_id, address, quantity, order_date
FROM orders
WHERE order_date BETWEEN '2025-01-01' AND '2025-12-31'
ORDER BY order_date;

-- Query 11: Retrieve products with an average rating greater than 4.0.
-- Example: Get products that are highly rated.
SELECT product_id, name, brand, category, price, average_rating
FROM products
WHERE average_rating > 4.0
ORDER BY average_rating DESC;