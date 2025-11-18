CREATE DATABASE IF NOT EXISTS sample_store;
USE sample_store;

CREATE TABLE CUSTOMER (
    CustomerId INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    FirstName VARCHAR(20) NOT NULL,
    LastName VARCHAR(20) NOT NULL,
    Email VARCHAR(255) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL
);

CREATE TABLE Category (
    categoryId INT AUTO_INCREMENT PRIMARY KEY,
    category_name VARCHAR(255) NOT NULL
);

CREATE TABLE Product (
    productId INT AUTO_INCREMENT PRIMARY KEY,
    categoryId INT NOT NULL,
    ProductName VARCHAR(255) NOT NULL,
    description TEXT,
    price DECIMAL(10,2) NOT NULL,
    stock_quantity INT DEFAULT 0,
    FOREIGN KEY (categoryId) REFERENCES Category(categoryId)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

CREATE TABLE Orders (
    orderId INT AUTO_INCREMENT PRIMARY KEY,
    customerId INT NOT NULL,
    orderDate DATETIME DEFAULT CURRENT_TIMESTAMP,
    total_amount DECIMAL(10,2) NOT NULL CHECK (total_amount > 0),
    FOREIGN KEY (customerId) REFERENCES Customer(customerId)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

CREATE TABLE Order_Details (
    orderDetailId INT AUTO_INCREMENT PRIMARY KEY,
    orderId INT NOT NULL,
    productId INT NOT NULL,
    quantity INT NOT NULL,
    unit_price DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (orderId) REFERENCES Orders(orderId)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY (productId) REFERENCES Product(productId)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);
