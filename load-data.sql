-- This file includes:
--  1. ~15 product records (from product_info.csv sample structure)
--  2. 10 user records (both clients and admins as per your proposal)
--  3. ~50 review records (to simulate customer feedback)
--  4. 10 sample order records
--
-- Total records: ~15 + 10 + 50 + 10 ≈ 85 

-- Insert records into the products table.
-- Columns: name, brand, category, price, ingredients
-- Note: average_rating will default to 0.0.

INSERT INTO products (name, brand, category, price, ingredients)
VALUES 
('Hydrating Serum', 'Fenty Beauty', 'Skincare', 29.99, 'Water, Glycerin, Hyaluronic Acid');

INSERT INTO products (name, brand, category, price, ingredients)
VALUES 
('Matte Lipstick', 'Sephora Collection', 'Makeup', 19.99, 'Waxes, Oils, Pigments');

INSERT INTO products (name, brand, category, price, ingredients)
VALUES 
('Illuminating Primer', 'Urban Decay', 'Makeup', 25.99, 'Silicone, Light Reflectors, Emollients');

INSERT INTO products (name, brand, category, price, ingredients)
VALUES 
('Nourishing Face Cream', 'Clinique', 'Skincare', 34.99, 'Water, Shea Butter, Vitamins');

INSERT INTO products (name, brand, category, price, ingredients)
VALUES 
('Scented Body Lotion', 'Bath & Body Works', 'Body Care', 15.99, 'Aloe, Fragrance, Moisturizers');

INSERT INTO products (name, brand, category, price, ingredients)
VALUES 
('Volumizing Mascara', 'Maybelline', 'Makeup', 14.99, 'Pigments, Polymers, Water');

INSERT INTO products (name, brand, category, price, ingredients)
VALUES 
('Gentle Cleanser', 'Cetaphil', 'Skincare', 12.99, 'Glycerin, Cetyl Alcohol, Water');

INSERT INTO products (name, brand, category, price, ingredients)
VALUES 
('Refreshing Toner', 'Neutrogena', 'Skincare', 16.99, 'Witch Hazel, Aloe, Fragrance');

INSERT INTO products (name, brand, category, price, ingredients)
VALUES 
('Daily Sunscreen', 'Supergoop', 'Skincare', 24.99, 'Zinc Oxide, Aloe, Vitamin E');

INSERT INTO products (name, brand, category, price, ingredients)
VALUES 
('Shimmer Highlighter', 'Becca', 'Makeup', 22.99, 'Mica, Silica, Oils');

INSERT INTO products (name, brand, category, price, ingredients)
VALUES 
('Repair Shampoo', 'Pantene', 'Hair Care', 9.99, 'Sulfates, Conditioning Agents, Fragrance');

INSERT INTO products (name, brand, category, price, ingredients)
VALUES 
('Deep Conditioner', 'Aussie', 'Hair Care', 11.99, 'Natural Oils, Proteins, Vitamins');

INSERT INTO products (name, brand, category, price, ingredients)
VALUES 
('Matte Foundation', 'L''Oreal', 'Makeup', 27.99, 'Powders, Oils, Emollients');

INSERT INTO products (name, brand, category, price, ingredients)
VALUES 
('Luxe Eye Cream', 'Estée Lauder', 'Skincare', 39.99, 'Peptides, Hyaluronic Acid, Antioxidants');

INSERT INTO products (name, brand, category, price, ingredients)
VALUES 
('Silk Veil Primer', 'Smashbox', 'Makeup', 21.99, 'Silicone, Water, Dimethicone');


-- -------------------------------------------------------
-- Insert records into the users table.
-- Columns: username, email, password_hash, user_type
-- -------------------------------------------------------
INSERT INTO users (username, email, password_hash, user_type)
VALUES 
('jdoe', 'jdoe@example.com', 'hash1', 'client');

INSERT INTO users (username, email, password_hash, user_type)
VALUES 
('asmith', 'asmith@example.com', 'hash2', 'client');

INSERT INTO users (username, email, password_hash, user_type)
VALUES 
('bwayne', 'bwayne@example.com', 'hash3', 'client');

INSERT INTO users (username, email, password_hash, user_type)
VALUES 
('ckent', 'ckent@example.com', 'hash4', 'client');

INSERT INTO users (username, email, password_hash, user_type)
VALUES 
('dprince', 'dprince@example.com', 'hash5', 'client');

INSERT INTO users (username, email, password_hash, user_type)
VALUES 
('admin1', 'admin1@example.com', 'hashadmin1', 'admin');

INSERT INTO users (username, email, password_hash, user_type)
VALUES 
('admin2', 'admin2@example.com', 'hashadmin2', 'admin');

INSERT INTO users (username, email, password_hash, user_type)
VALUES 
('elaine', 'elaine@example.com', 'hash6', 'client');

INSERT INTO users (username, email, password_hash, user_type)
VALUES 
('frank', 'frank@example.com', 'hash7', 'client');

INSERT INTO users (username, email, password_hash, user_type)
VALUES 
('gina', 'gina@example.com', 'hash8', 'client');


-- -------------------------------------------------------
-- Insert records into the reviews table.
-- Columns: user_id, product_id, rating, review_text
-- -------------------------------------------------------
-- Here we insert 50 sample reviews with a variety of ratings and text.
INSERT INTO reviews (user_id, product_id, rating, review_text, created_at)
VALUES (1, 1, 5, 'Amazing hydrating serum! My skin feels refreshed.', '2025-03-01 10:00:00');

INSERT INTO reviews (user_id, product_id, rating, review_text, created_at)
VALUES (2, 1, 4, 'Good serum, but a bit pricey.', '2025-03-02 11:30:00');

INSERT INTO reviews (user_id, product_id, rating, review_text, created_at)
VALUES (3, 2, 5, 'The lipstick color is stunning and lasts all day.', '2025-03-03 14:15:00');

INSERT INTO reviews (user_id, product_id, rating, review_text, created_at)
VALUES (4, 2, 4, 'Nice matte finish, though it can be drying.', '2025-03-04 09:45:00');

INSERT INTO reviews (user_id, product_id, rating, review_text, created_at)
VALUES (5, 3, 5, 'This primer really makes my makeup pop!', '2025-03-05 13:00:00');

INSERT INTO reviews (user_id, product_id, rating, review_text, created_at)
VALUES (6, 3, 3, 'Decent product but not a game-changer.', '2025-03-06 16:20:00');

INSERT INTO reviews (user_id, product_id, rating, review_text, created_at)
VALUES (7, 4, 4, 'Face cream is nourishing and smooth.', '2025-03-07 12:10:00');

INSERT INTO reviews (user_id, product_id, rating, review_text, created_at)
VALUES (8, 4, 5, 'My favorite face cream so far!', '2025-03-08 17:45:00');

INSERT INTO reviews (user_id, product_id, rating, review_text, created_at)
VALUES (9, 5, 4, 'Lotion smells great and hydrates well.', '2025-03-09 11:00:00');

INSERT INTO reviews (user_id, product_id, rating, review_text, created_at)
VALUES (10, 5, 4, 'Good body lotion, will buy again.', '2025-03-10 15:30:00');

INSERT INTO reviews (user_id, product_id, rating, review_text, created_at)
VALUES (1, 6, 3, 'Mascara works fine but clumps sometimes.', '2025-03-11 10:50:00');

INSERT INTO reviews (user_id, product_id, rating, review_text, created_at)
VALUES (2, 6, 4, 'Gives a nice volume boost.', '2025-03-12 13:20:00');

INSERT INTO reviews (user_id, product_id, rating, review_text, created_at)
VALUES (3, 7, 5, 'Cleanser is gentle and effective.', '2025-03-13 14:40:00');

INSERT INTO reviews (user_id, product_id, rating, review_text, created_at)
VALUES (4, 7, 4, 'Works well for sensitive skin.', '2025-03-14 09:30:00');

INSERT INTO reviews (user_id, product_id, rating, review_text, created_at)
VALUES (5, 8, 4, 'Toner refreshes the skin, love it.', '2025-03-15 11:45:00');

INSERT INTO reviews (user_id, product_id, rating, review_text, created_at)
VALUES (6, 8, 3, 'Not my favorite, but it does the job.', '2025-03-16 13:50:00');

INSERT INTO reviews (user_id, product_id, rating, review_text, created_at)
VALUES (7, 9, 5, 'Sunscreen is light and non-greasy.', '2025-03-17 16:10:00');

INSERT INTO reviews (user_id, product_id, rating, review_text, created_at)
VALUES (8, 9, 4, 'Provides good protection without feeling heavy.', '2025-03-18 10:30:00');

INSERT INTO reviews (user_id, product_id, rating, review_text, created_at)
VALUES (9, 10, 5, 'Highlighter gives a beautiful glow.', '2025-03-19 12:00:00');

INSERT INTO reviews (user_id, product_id, rating, review_text, created_at)
VALUES (10, 10, 4, 'Very nice, though a bit expensive.', '2025-03-20 14:25:00');
INSERT INTO reviews (user_id, product_id, rating, review_text, created_at)
VALUES (1, 11, 3, 'Shampoo cleans well but leaves hair a bit dry.', '2025-03-21 11:15:00');

INSERT INTO reviews (user_id, product_id, rating, review_text, created_at)
VALUES (2, 11, 4, 'Nice formula and scent.', '2025-03-22 13:30:00');

INSERT INTO reviews (user_id, product_id, rating, review_text, created_at)
VALUES (3, 12, 5, 'Deep conditioner works wonders for my hair.', '2025-03-23 15:10:00');

INSERT INTO reviews (user_id, product_id, rating, review_text, created_at)
VALUES (4, 12, 4, 'Leaves hair soft and manageable.', '2025-03-24 12:40:00');

INSERT INTO reviews (user_id, product_id, rating, review_text, created_at)
VALUES (5, 13, 4, 'Foundation provides good coverage.', '2025-03-25 14:00:00');

INSERT INTO reviews (user_id, product_id, rating, review_text, created_at)
VALUES (6, 13, 3, 'Average product, could be better.', '2025-03-26 16:20:00');

INSERT INTO reviews (user_id, product_id, rating, review_text, created_at)
VALUES (7, 14, 5, 'Eye cream makes a noticeable difference.', '2025-03-27 11:00:00');

INSERT INTO reviews (user_id, product_id, rating, review_text, created_at)
VALUES (8, 14, 4, 'I love the texture and scent.', '2025-03-28 13:15:00');

INSERT INTO reviews (user_id, product_id, rating, review_text, created_at)
VALUES (9, 15, 4, 'Primer works great under makeup.', '2025-03-29 15:30:00');

INSERT INTO reviews (user_id, product_id, rating, review_text, created_at)
VALUES (10, 15, 5, 'Highly recommend this primer for a smooth base.', '2025-03-30 12:00:00');

INSERT INTO reviews (user_id, product_id, rating, review_text, created_at)
VALUES (1, 2, 4, 'Lipstick performs well with vibrant pigment.', '2025-03-31 10:30:00');

INSERT INTO reviews (user_id, product_id, rating, review_text, created_at)
VALUES (2, 3, 5, 'Primer is very effective and long-lasting.', '2025-04-01 13:00:00');

INSERT INTO reviews (user_id, product_id, rating, review_text, created_at)
VALUES (3, 4, 4, 'Face cream feels luxurious and hydrating.', '2025-04-02 14:20:00');

INSERT INTO reviews (user_id, product_id, rating, review_text, created_at)
VALUES (4, 5, 3, 'Body lotion is okay, nothing special.', '2025-04-03 15:45:00');

INSERT INTO reviews (user_id, product_id, rating, review_text, created_at)
VALUES (5, 6, 4, 'Mascara is decent and adds nice volume.', '2025-04-04 11:25:00');

INSERT INTO reviews (user_id, product_id, rating, review_text, created_at)
VALUES (6, 7, 5, 'Cleanser leaves my skin clean and soft.', '2025-04-05 13:35:00');

INSERT INTO reviews (user_id, product_id, rating, review_text, created_at)
VALUES (7, 8, 4, 'Toner is refreshing and gentle on my skin.', '2025-04-06 16:10:00');

INSERT INTO reviews (user_id, product_id, rating, review_text, created_at)
VALUES (8, 9, 5, 'Sunscreen works perfectly for daily use.', '2025-04-07 10:40:00');

INSERT INTO reviews (user_id, product_id, rating, review_text, created_at)
VALUES (9, 10, 4, 'Highlighter gives a subtle, elegant glow.', '2025-04-08 14:10:00');

INSERT INTO reviews (user_id, product_id, rating, review_text, created_at)
VALUES (10, 11, 3, 'Shampoo is average, but it does the job.', '2025-04-09 12:30:00');

INSERT INTO reviews (user_id, product_id, rating, review_text, created_at)
VALUES (1, 12, 4, 'Deep conditioner is very effective on dry hair.', '2025-04-10 13:55:00');

INSERT INTO reviews (user_id, product_id, rating, review_text, created_at)
VALUES (2, 13, 5, 'Foundation blends seamlessly and covers well.', '2025-04-11 11:10:00');

INSERT INTO reviews (user_id, product_id, rating, review_text, created_at)
VALUES (3, 14, 4, 'Eye cream improves the appearance of fine lines.', '2025-04-12 15:25:00');

INSERT INTO reviews (user_id, product_id, rating, review_text, created_at)
VALUES (4, 15, 5, 'Primer creates a flawless base for makeup.', '2025-04-13 10:45:00');

INSERT INTO reviews (user_id, product_id, rating, review_text, created_at)
VALUES (5, 1, 4, 'Hydrating serum significantly improved my skin texture.', '2025-04-14 12:20:00');

INSERT INTO reviews (user_id, product_id, rating, review_text, created_at)
VALUES (6, 2, 5, 'Lipstick color is vibrant and lasts long.', '2025-04-15 11:50:00');

INSERT INTO reviews (user_id, product_id, rating, review_text, created_at)
VALUES (7, 3, 4, 'Primer really enhances makeup durability.', '2025-04-16 13:30:00');

INSERT INTO reviews (user_id, product_id, rating, review_text, created_at)
VALUES (8, 4, 5, 'Face cream feels rich and soothing on my skin.', '2025-04-17 16:00:00');

INSERT INTO reviews (user_id, product_id, rating, review_text, created_at)
VALUES (9, 5, 3, 'Body lotion could be more moisturizing.', '2025-04-18 10:10:00');

INSERT INTO reviews (user_id, product_id, rating, review_text, created_at)
VALUES (10, 6, 4, 'Mascara adds nice volume to lashes.', '2025-04-19 14:30:00');

INSERT INTO reviews (user_id, product_id, rating, review_text, created_at)
VALUES (1, 7, 5, 'Cleanser is gentle and effective.', '2025-04-20 11:15:00');

INSERT INTO reviews (user_id, product_id, rating, review_text, created_at)
VALUES (2, 8, 4, 'Toner balances my skin very well.', '2025-04-21 12:40:00');

INSERT INTO reviews (user_id, product_id, rating, review_text, created_at)
VALUES (3, 9, 5, 'Sunscreen offers excellent protection.', '2025-04-22 13:55:00');

INSERT INTO reviews (user_id, product_id, rating, review_text, created_at)
VALUES (4, 10, 4, 'Highlighter is impressive in performance.', '2025-04-23 14:30:00');

INSERT INTO reviews (user_id, product_id, rating, review_text, created_at)
VALUES (5, 11, 3, 'Shampoo works fine, though sometimes leaves residue.', '2025-04-24 12:50:00');

INSERT INTO reviews (user_id, product_id, rating, review_text, created_at)
VALUES (6, 12, 4, 'Deep conditioner is very nourishing and effective.', '2025-04-25 15:10:00');

INSERT INTO reviews (user_id, product_id, rating, review_text, created_at)
VALUES (7, 13, 5, 'Foundation covers imperfections really well.', '2025-04-26 10:25:00');

INSERT INTO reviews (user_id, product_id, rating, review_text, created_at)
VALUES (8, 14, 4, 'Eye cream has a luxurious texture and scent.', '2025-04-27 11:40:00');

INSERT INTO reviews (user_id, product_id, rating, review_text, created_at)
VALUES (9, 15, 5, 'Primer creates a smooth, even base for makeup.', '2025-04-28 13:00:00');

INSERT INTO reviews (user_id, product_id, rating, review_text, created_at)
VALUES (10, 1, 4, 'Hydrating serum exceeded my expectations.', '2025-04-29 14:15:00');

-- -------------------------------------------------------
-- Insert records into the orders table.
-- Columns: user_id, product_id, address, quantity
-- -------------------------------------------------------
INSERT INTO orders (user_id, product_id, address, quantity, order_date)
VALUES (1, 11, '123 Main St, Brookhaven, USA', 2, '2025-03-25 16:36:46');
INSERT INTO orders (user_id, product_id, address, quantity, order_date)
VALUES (2, 2, '456 Oak St, Willowdale, Canada', 1), '2021-03-11 01:23:06';
INSERT INTO orders (user_id, product_id, address, quantity, order_date)
VALUES (3, 3, '789 Pine Rd, Fairview, UK', 1, '2023-43-12 23:46:36');
INSERT INTO orders (user_id, product_id, address, quantity, order_date)
VALUES (4, 4, '321 Maple Ave, Rosewood, Australia', 3, '2024-07-18 10:26:26');
INSERT INTO orders (user_id, product_id, address, quantity, order_date)
VALUES (5, 5, '654 Elm St, Cedarburg, New Zealand', 2, '2025-11-18 04:24:23');
INSERT INTO orders (user_id, product_id, address, quantity, order_date)
VALUES (6, 6, '987 Cedar Blvd, Hillcrest, Ireland', 1, '2025-03-22 09:48:02');
INSERT INTO orders (user_id, product_id, address, quantity, order_date)
VALUES (7, 7, '135 Spruce Dr, Lakeside, Germany', 2, '2025-03-09 05:40:05');
INSERT INTO orders (user_id, product_id, address, quantity, order_date)
VALUES (8, 8, '246 Birch Ln, Elmwood, France', 1, '2023-05-12 11:03:16');
INSERT INTO orders (user_id, product_id, address, quantity)
VALUES (9, 9, '357 Walnut St, Glenhaven, Japan', 2);
INSERT INTO orders (user_id, product_id, address, quantity)
VALUES (10, 10, '468 Chestnut Ave, Oakridge, Brazil', 1);