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
INSERT INTO reviews (user_id, product_id, rating, review_text)
VALUES (1, 1, 5, 'Amazing hydrating serum! My skin feels refreshed.');
INSERT INTO reviews (user_id, product_id, rating, review_text)
VALUES (2, 1, 4, 'Good serum, but a bit pricey.');
INSERT INTO reviews (user_id, product_id, rating, review_text)
VALUES (3, 2, 5, 'The lipstick color is stunning and lasts all day.');
INSERT INTO reviews (user_id, product_id, rating, review_text)
VALUES (4, 2, 4, 'Nice matte finish, though it can be drying.');
INSERT INTO reviews (user_id, product_id, rating, review_text)
VALUES (5, 3, 5, 'This primer really makes my makeup pop!');
INSERT INTO reviews (user_id, product_id, rating, review_text)
VALUES (6, 3, 3, 'Decent product but not a game-changer.');
INSERT INTO reviews (user_id, product_id, rating, review_text)
VALUES (7, 4, 4, 'Face cream is nourishing and smooth.');
INSERT INTO reviews (user_id, product_id, rating, review_text)
VALUES (8, 4, 5, 'My favorite face cream so far!');
INSERT INTO reviews (user_id, product_id, rating, review_text)
VALUES (9, 5, 4, 'Lotion smells great and hydrates well.');
INSERT INTO reviews (user_id, product_id, rating, review_text)
VALUES (10, 5, 4, 'Good body lotion, will buy again.');
INSERT INTO reviews (user_id, product_id, rating, review_text)
VALUES (1, 6, 3, 'Mascara works fine but clumps sometimes.');
INSERT INTO reviews (user_id, product_id, rating, review_text)
VALUES (2, 6, 4, 'Gives a nice volume boost.');
INSERT INTO reviews (user_id, product_id, rating, review_text)
VALUES (3, 7, 5, 'Cleanser is gentle and effective.');
INSERT INTO reviews (user_id, product_id, rating, review_text)
VALUES (4, 7, 4, 'Works well for sensitive skin.');
INSERT INTO reviews (user_id, product_id, rating, review_text)
VALUES (5, 8, 4, 'Toner refreshes the skin, love it.');
INSERT INTO reviews (user_id, product_id, rating, review_text)
VALUES (6, 8, 3, 'Not my favorite, but it does the job.');
INSERT INTO reviews (user_id, product_id, rating, review_text)
VALUES (7, 9, 5, 'Sunscreen is light and non-greasy.');
INSERT INTO reviews (user_id, product_id, rating, review_text)
VALUES (8, 9, 4, 'Provides good protection without feeling heavy.');
INSERT INTO reviews (user_id, product_id, rating, review_text)
VALUES (9, 10, 5, 'Highlighter gives a beautiful glow.');
INSERT INTO reviews (user_id, product_id, rating, review_text)
VALUES (10, 10, 4, 'Very nice, though a bit expensive.');
INSERT INTO reviews (user_id, product_id, rating, review_text)
VALUES (1, 11, 3, 'Shampoo cleans well but leaves hair a bit dry.');
INSERT INTO reviews (user_id, product_id, rating, review_text)
VALUES (2, 11, 4, 'Nice formula and scent.');
INSERT INTO reviews (user_id, product_id, rating, review_text)
VALUES (3, 12, 5, 'Deep conditioner works wonders for my hair.');
INSERT INTO reviews (user_id, product_id, rating, review_text)
VALUES (4, 12, 4, 'Leaves hair soft and manageable.');
INSERT INTO reviews (user_id, product_id, rating, review_text)
VALUES (5, 13, 4, 'Foundation provides good coverage.');
INSERT INTO reviews (user_id, product_id, rating, review_text)
VALUES (6, 13, 3, 'Average product, could be better.');
INSERT INTO reviews (user_id, product_id, rating, review_text)
VALUES (7, 14, 5, 'Eye cream makes a noticeable difference.');
INSERT INTO reviews (user_id, product_id, rating, review_text)
VALUES (8, 14, 4, 'I love the texture and scent.');
INSERT INTO reviews (user_id, product_id, rating, review_text)
VALUES (9, 15, 4, 'Primer works great under makeup.');
INSERT INTO reviews (user_id, product_id, rating, review_text)
VALUES (10, 15, 5, 'Highly recommend this primer for a smooth base.');
INSERT INTO reviews (user_id, product_id, rating, review_text)
VALUES (1, 2, 4, 'Lipstick performs well with vibrant pigment.');
INSERT INTO reviews (user_id, product_id, rating, review_text)
VALUES (2, 3, 5, 'Primer is very effective and long-lasting.');
INSERT INTO reviews (user_id, product_id, rating, review_text)
VALUES (3, 4, 4, 'Face cream feels luxurious and hydrating.');
INSERT INTO reviews (user_id, product_id, rating, review_text)
VALUES (4, 5, 3, 'Body lotion is okay, nothing special.');
INSERT INTO reviews (user_id, product_id, rating, review_text)
VALUES (5, 6, 4, 'Mascara is decent and adds nice volume.');
INSERT INTO reviews (user_id, product_id, rating, review_text)
VALUES (6, 7, 5, 'Cleanser leaves my skin clean and soft.');
INSERT INTO reviews (user_id, product_id, rating, review_text)
VALUES (7, 8, 4, 'Toner is refreshing and gentle on my skin.');
INSERT INTO reviews (user_id, product_id, rating, review_text)
VALUES (8, 9, 5, 'Sunscreen works perfectly for daily use.');
INSERT INTO reviews (user_id, product_id, rating, review_text)
VALUES (9, 10, 4, 'Highlighter gives a subtle, elegant glow.');
INSERT INTO reviews (user_id, product_id, rating, review_text)
VALUES (10, 11, 3, 'Shampoo is average, but it does the job.');
INSERT INTO reviews (user_id, product_id, rating, review_text)
VALUES (1, 12, 4, 'Deep conditioner is very effective on dry hair.');
INSERT INTO reviews (user_id, product_id, rating, review_text)
VALUES (2, 13, 5, 'Foundation blends seamlessly and covers well.');
INSERT INTO reviews (user_id, product_id, rating, review_text)
VALUES (3, 14, 4, 'Eye cream improves the appearance of fine lines.');
INSERT INTO reviews (user_id, product_id, rating, review_text)
VALUES (4, 15, 5, 'Primer creates a flawless base for makeup.');
INSERT INTO reviews (user_id, product_id, rating, review_text)
VALUES (5, 1, 4, 'Hydrating serum significantly improved my skin texture.');
INSERT INTO reviews (user_id, product_id, rating, review_text)
VALUES (6, 2, 5, 'Lipstick color is vibrant and lasts long.');
INSERT INTO reviews (user_id, product_id, rating, review_text)
VALUES (7, 3, 4, 'Primer really enhances makeup durability.');
INSERT INTO reviews (user_id, product_id, rating, review_text)
VALUES (8, 4, 5, 'Face cream feels rich and soothing on my skin.');
INSERT INTO reviews (user_id, product_id, rating, review_text)
VALUES (9, 5, 3, 'Body lotion could be more moisturizing.');
INSERT INTO reviews (user_id, product_id, rating, review_text)
VALUES (10, 6, 4, 'Mascara adds nice volume to lashes.');
INSERT INTO reviews (user_id, product_id, rating, review_text)
VALUES (1, 7, 5, 'Cleanser is gentle and effective.');
INSERT INTO reviews (user_id, product_id, rating, review_text)
VALUES (2, 8, 4, 'Toner balances my skin very well.');
INSERT INTO reviews (user_id, product_id, rating, review_text)
VALUES (3, 9, 5, 'Sunscreen offers excellent protection.');
INSERT INTO reviews (user_id, product_id, rating, review_text)
VALUES (4, 10, 4, 'Highlighter is impressive in performance.');
INSERT INTO reviews (user_id, product_id, rating, review_text)
VALUES (5, 11, 3, 'Shampoo works fine, though sometimes leaves residue.');
INSERT INTO reviews (user_id, product_id, rating, review_text)
VALUES (6, 12, 4, 'Deep conditioner is very nourishing and effective.');
INSERT INTO reviews (user_id, product_id, rating, review_text)
VALUES (7, 13, 5, 'Foundation covers imperfections really well.');
INSERT INTO reviews (user_id, product_id, rating, review_text)
VALUES (8, 14, 4, 'Eye cream has a luxurious texture and scent.');
INSERT INTO reviews (user_id, product_id, rating, review_text)
VALUES (9, 15, 5, 'Primer creates a smooth, even base for makeup.');
INSERT INTO reviews (user_id, product_id, rating, review_text)
VALUES (10, 1, 4, 'Hydrating serum exceeded my expectations.');

-- -------------------------------------------------------
-- Insert records into the orders table.
-- Columns: user_id, product_id, address, quantity
-- -------------------------------------------------------
INSERT INTO orders (user_id, product_id, address, quantity)
VALUES (1, 1, '123 Main St, City, Country', 2);
INSERT INTO orders (user_id, product_id, address, quantity)
VALUES (2, 2, '456 Oak St, City, Country', 1);
INSERT INTO orders (user_id, product_id, address, quantity)
VALUES (3, 3, '789 Pine Rd, City, Country', 1);
INSERT INTO orders (user_id, product_id, address, quantity)
VALUES (4, 4, '321 Maple Ave, City, Country', 3);
INSERT INTO orders (user_id, product_id, address, quantity)
VALUES (5, 5, '654 Elm St, City, Country', 2);
INSERT INTO orders (user_id, product_id, address, quantity)
VALUES (6, 6, '987 Cedar Blvd, City, Country', 1);
INSERT INTO orders (user_id, product_id, address, quantity)
VALUES (7, 7, '135 Spruce Dr, City, Country', 2);
INSERT INTO orders (user_id, product_id, address, quantity)
VALUES (8, 8, '246 Birch Ln, City, Country', 1);
INSERT INTO orders (user_id, product_id, address, quantity)
VALUES (9, 9, '357 Walnut St, City, Country', 2);
INSERT INTO orders (user_id, product_id, address, quantity)
VALUES (10, 10, '468 Chestnut Ave, City, Country', 1);