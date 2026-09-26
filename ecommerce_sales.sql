-- ============================================
-- PROJECT 2: E-COMMERCE SALES DATABASE
-- MySQL
-- ============================================

-- 1. Create Database
CREATE DATABASE ecommerce_sales;

USE ecommerce_sales;


-- ============================================
-- 2. Create Customers Table
-- ============================================

CREATE TABLE customers (
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE,
    city VARCHAR(50),
    registration_date DATE
);


-- ============================================
-- 3. Create Products Table
-- ============================================

CREATE TABLE products (
    product_id INT PRIMARY KEY AUTO_INCREMENT,
    product_name VARCHAR(100) NOT NULL,
    category VARCHAR(50),
    price DECIMAL(10,2),
    stock INT
);


-- ============================================
-- 4. Create Orders Table
-- ============================================

CREATE TABLE orders (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT,
    order_date DATE,
    order_status VARCHAR(30),

    FOREIGN KEY (customer_id)
        REFERENCES customers(customer_id)
);


-- ============================================
-- 5. Create Order Items Table
-- ============================================

CREATE TABLE order_items (
    order_item_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT,
    product_id INT,
    quantity INT,
    unit_price DECIMAL(10,2),

    FOREIGN KEY (order_id)
        REFERENCES orders(order_id),

    FOREIGN KEY (product_id)
        REFERENCES products(product_id)
);


-- ============================================
-- 6. Insert Customers
-- ============================================

INSERT INTO customers
(customer_name, email, city, registration_date)
VALUES
('Arun Kumar', 'arun@gmail.com', 'Chennai', '2024-01-10'),
('Priya S', 'priya@gmail.com', 'Bangalore', '2024-02-15'),
('Rahul M', 'rahul@gmail.com', 'Coimbatore', '2024-03-20'),
('Divya R', 'divya@gmail.com', 'Chennai', '2024-04-05'),
('Karthik P', 'karthik@gmail.com', 'Madurai', '2024-05-12'),
('Sneha V', 'sneha@gmail.com', 'Bangalore', '2024-06-18'),
('Vijay S', 'vijay@gmail.com', 'Salem', '2024-07-22'),
('Meena K', 'meena@gmail.com', 'Trichy', '2024-08-10');


-- ============================================
-- 7. Insert Products
-- ============================================

INSERT INTO products
(product_name, category, price, stock)
VALUES
('Laptop', 'Electronics', 55000, 20),
('Smartphone', 'Electronics', 25000, 35),
('Headphones', 'Electronics', 2500, 50),
('Keyboard', 'Accessories', 1500, 40),
('Mouse', 'Accessories', 800, 60),
('Office Chair', 'Furniture', 7000, 15),
('Backpack', 'Accessories', 1200, 30),
('Monitor', 'Electronics', 15000, 25),
('Table', 'Furniture', 5000, 10),
('Webcam', 'Electronics', 3500, 25);


-- ============================================
-- 8. Insert Orders
-- ============================================

INSERT INTO orders
(customer_id, order_date, order_status)
VALUES
(1, '2025-01-05', 'Delivered'),
(2, '2025-01-10', 'Delivered'),
(3, '2025-01-15', 'Delivered'),
(4, '2025-02-02', 'Delivered'),
(5, '2025-02-10', 'Shipped'),
(6, '2025-02-18', 'Delivered'),
(7, '2025-03-05', 'Delivered'),
(8, '2025-03-12', 'Pending'),
(1, '2025-03-20', 'Delivered'),
(2, '2025-04-01', 'Delivered'),
(3, '2025-04-15', 'Delivered'),
(5, '2025-05-10', 'Delivered');


-- ============================================
-- 9. Insert Order Items
-- ============================================

INSERT INTO order_items
(order_id, product_id, quantity, unit_price)
VALUES
(1, 1, 1, 55000),
(1, 3, 2, 2500),

(2, 2, 1, 25000),
(2, 5, 2, 800),

(3, 4, 2, 1500),
(3, 7, 1, 1200),

(4, 6, 1, 7000),
(4, 9, 1, 5000),

(5, 8, 1, 15000),
(5, 3, 1, 2500),

(6, 2, 2, 25000),

(7, 1, 1, 55000),
(7, 5, 1, 800),

(8, 7, 2, 1200),
(8, 10, 1, 3500),

(9, 2, 1, 25000),
(9, 8, 1, 15000),

(10, 6, 1, 7000),
(10, 4, 1, 1500),

(11, 1, 1, 55000),
(11, 10, 2, 3500),

(12, 9, 1, 5000),
(12, 7, 2, 1200);


-- ============================================
-- 10. View All Customers
-- ============================================

SELECT *
FROM customers;


-- ============================================
-- 11. View All Products
-- ============================================

SELECT *
FROM products;


-- ============================================
-- 12. View All Orders
-- ============================================

SELECT *
FROM orders;


-- ============================================
-- 13. View Order Details
-- ============================================

SELECT *
FROM order_items;


-- ============================================
-- 14. Products above ₹10,000
-- ============================================

SELECT *
FROM products
WHERE price > 10000;


-- ============================================
-- 15. Products sorted by price
-- ============================================

SELECT *
FROM products
ORDER BY price DESC;


-- ============================================
-- 16. Total Number of Customers
-- ============================================

SELECT COUNT(*) AS total_customers
FROM customers;


-- ============================================
-- 17. Total Number of Orders
-- ============================================

SELECT COUNT(*) AS total_orders
FROM orders;


-- ============================================
-- 18. Total Revenue
-- ============================================

SELECT
    SUM(quantity * unit_price) AS total_revenue
FROM order_items;


-- ============================================
-- 19. Revenue by Product
-- ============================================

SELECT
    p.product_name,
    SUM(oi.quantity * oi.unit_price) AS revenue
FROM order_items oi
JOIN products p
    ON oi.product_id = p.product_id
GROUP BY p.product_name
ORDER BY revenue DESC;


-- ============================================
-- 20. Highest Revenue Product
-- ============================================

SELECT
    p.product_name,
    SUM(oi.quantity * oi.unit_price) AS revenue
FROM order_items oi
JOIN products p
    ON oi.product_id = p.product_id
GROUP BY p.product_name
ORDER BY revenue DESC
LIMIT 1;


-- ============================================
-- 21. Customer Spending
-- ============================================

SELECT
    c.customer_name,
    SUM(oi.quantity * oi.unit_price) AS total_spent
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
JOIN order_items oi
    ON o.order_id = oi.order_id
GROUP BY c.customer_name
ORDER BY total_spent DESC;


-- ============================================
-- 22. Highest Spending Customer
-- ============================================

SELECT
    c.customer_name,
    SUM(oi.quantity * oi.unit_price) AS total_spent
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
JOIN order_items oi
    ON o.order_id = oi.order_id
GROUP BY c.customer_name
ORDER BY total_spent DESC
LIMIT 1;


-- ============================================
-- 23. Sales by Category
-- ============================================

SELECT
    p.category,
    SUM(oi.quantity * oi.unit_price) AS category_sales
FROM products p
JOIN order_items oi
    ON p.product_id = oi.product_id
GROUP BY p.category
ORDER BY category_sales DESC;


-- ============================================
-- 24. Average Product Price
-- ============================================

SELECT
    AVG(price) AS average_product_price
FROM products;


-- ============================================
-- 25. Products with Stock Less Than 20
-- ============================================

SELECT *
FROM products
WHERE stock < 20;


-- ============================================
-- 26. Delivered Orders
-- ============================================

SELECT *
FROM orders
WHERE order_status = 'Delivered';


-- ============================================
-- 27. Customer Order Details
-- ============================================

SELECT
    c.customer_name,
    o.order_id,
    o.order_date,
    o.order_status
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
ORDER BY o.order_date;


-- ============================================
-- 28. Monthly Sales
-- ============================================

SELECT
    MONTH(o.order_date) AS month_number,
    SUM(oi.quantity * oi.unit_price) AS monthly_sales
FROM orders o
JOIN order_items oi
    ON o.order_id = oi.order_id
GROUP BY MONTH(o.order_date)
ORDER BY month_number;


-- ============================================
-- 29. Orders with Total Amount > ₹20,000
-- ============================================

SELECT
    o.order_id,
    SUM(oi.quantity * oi.unit_price) AS order_total
FROM orders o
JOIN order_items oi
    ON o.order_id = oi.order_id
GROUP BY o.order_id
HAVING order_total > 20000;


-- ============================================
-- 30. Products Selling More Than 2 Units
-- ============================================

SELECT
    p.product_name,
    SUM(oi.quantity) AS total_quantity_sold
FROM products p
JOIN order_items oi
    ON p.product_id = oi.product_id
GROUP BY p.product_name
HAVING total_quantity_sold > 2
ORDER BY total_quantity_sold DESC;