-- Customers
INSERT INTO CUSTOMER (FirstName, LastName, Email, password) VALUES
('Richard', 'Johnston', 'richard.johnston@example.com', 'password123'),
('Wayne', 'Jones', 'wayne.jones@example.com', 'password123'),
('Amelia', 'Waverley', 'amelia.waverley@example.com', 'password123'),
('Li', 'Qing', 'li.qing@example.com', 'password123'),
('Sara', 'Thompson', 'sara.thompson@example.com', 'password123'),
('Antonio', 'Gonzales', 'antonio.gonzales@example.com', 'password123'),
('Diane', 'Adams', 'diane.adams@example.com', 'password123'),
('Dave', 'Williams', 'dave.williams@example.com', 'password123');

-- Category
INSERT INTO Category (category_name) VALUES ('Default');

-- Products
INSERT INTO Product (categoryId, ProductName, description, price, stock_quantity) VALUES
(1, 'AQX88916', 'Product AQX88916', 23.95, 100),
(1, 'AHL46785', 'Product AHL46785', 5001.75, 100),
(1, 'DHU69863', 'Product DHU69863', 23.70, 100);

-- Orders
INSERT INTO Orders (customerId, orderDate, total_amount) VALUES
(1, '2002-08-12', 23.95),
(2, '2002-08-12', 167.65),
(4, '2002-08-13', 5001.75),
(5, '2002-08-13', 118.50),
(5, '2002-08-14', 2227.80),
(5, '2002-08-14', 99.54),
(8, '2002-08-14', 1317.25);

-- Order Details
INSERT INTO Order_Details (orderId, productId, quantity, unit_price) VALUES
(1, 1, 1, 23.95),
(2, 1, 7, 23.95),
(3, 2, 3705, 1.35),
(4, 3, 50, 2.37),
(5, 3, 940, 2.37),
(6, 3, 42, 2.37),
(7, 1, 55, 23.95);
