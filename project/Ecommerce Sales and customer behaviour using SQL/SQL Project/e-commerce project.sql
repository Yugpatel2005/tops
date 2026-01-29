create database ecommerce_db;
use ecommerce_db;

create table customer(
	customer_id varchar(10) primary key,
    customer_name VARCHAR(50),
    gender VARCHAR(10),
    age INT,
    city VARCHAR(50),
    signup_date DATE
    );
alter table customer rename customers;    

create table product(
    product_id VARCHAR(10) PRIMARY KEY,
    product_name VARCHAR(50),
    category VARCHAR(30),
    price INT
);
alter table product rename products;

CREATE TABLE orders (
    order_id VARCHAR(10) PRIMARY KEY,
    customer_id VARCHAR(10),
    order_date DATE,
    order_status VARCHAR(20)
);

CREATE TABLE order_items (
    item_id INT PRIMARY KEY,
    order_id VARCHAR(10),
    product_id VARCHAR(10),
    quantity INT,
    item_price INT
);

CREATE TABLE deliveries (
    delivery_id INT PRIMARY KEY,
    order_id VARCHAR(10),
    shipped_date DATE,
    delivered_date DATE,
    delivery_status VARCHAR(20)
);

SHOW VARIABLES LIKE 'local_infile';
SET GLOBAL local_infile = 1;

SELECT COUNT(*) FROM customers;
SELECT COUNT(*) FROM products;
SELECT COUNT(*) FROM orders;
SELECT COUNT(*) FROM order_items;
SELECT COUNT(*) FROM deliveries;

SHOW TABLES;
describe customers;
describe products;
describe orders;
describe order_items;
describe deliveries;
SELECT * FROM customers LIMIT 5;
SELECT * FROM orders LIMIT 5;


select count(*) - count(customer_name) as missing_name from customers;
select count(*) - count(order_date) as missing_date from orders;

select customer_id, count(*) from customers
group by customer_id
having count(*) > 1;

SELECT * FROM products WHERE price <= 0;

SELECT * FROM order_items WHERE quantity <= 0;


ALTER TABLE orders
ADD CONSTRAINT fk_orders_customer
FOREIGN KEY (customer_id) REFERENCES customers(customer_id);

ALTER TABLE order_items
ADD CONSTRAINT fk_items_order
FOREIGN KEY (order_id) REFERENCES orders(order_id);

ALTER TABLE order_items
ADD CONSTRAINT fk_items_product
FOREIGN KEY (product_id) REFERENCES products(product_id);

ALTER TABLE deliveries
ADD CONSTRAINT fk_delivery_order
FOREIGN KEY (order_id) REFERENCES orders(order_id);

-- 1. Total Revenue
SELECT SUM(quantity * item_price) AS total_revenue
FROM order_items;

-- 2. Monthly Sales
SELECT DATE_FORMAT(order_date, '%Y-%m') AS month,
       COUNT(*) AS total_orders
FROM orders
GROUP BY month
ORDER BY month;

-- 3. Top 10 Best Selling Products
SELECT p.product_name,
       SUM(oi.quantity) AS total_qty
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
GROUP BY p.product_name
ORDER BY total_qty DESC
LIMIT 10;

-- 4.Customer Lifetime Value (CLV)
SELECT c.customer_id,
       c.customer_name,
       SUM(oi.quantity * oi.item_price) AS total_spent
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN order_items oi ON o.order_id = oi.order_id
GROUP BY c.customer_id, c.customer_name
ORDER BY total_spent DESC;

-- 5. Delivery performance
SELECT delivery_status, COUNT(*) 
FROM deliveries
GROUP BY delivery_status;


-- RFM Analysis

-- 1. Recency Calculate

SELECT 
    customer_id,
    DATEDIFF(
        (SELECT MAX(order_date) FROM orders),
        MAX(order_date)
    ) AS recency
FROM orders
GROUP BY customer_id;

-- 2. Frequency Calculate

SELECT 
    customer_id,
    COUNT(order_id) AS frequency
FROM orders
GROUP BY customer_id;

--  3. Monetary Calculate
SELECT 
    o.customer_id,
    SUM(oi.quantity * oi.item_price) AS monetary
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
GROUP BY o.customer_id;

-- 4. Combine RFM

SELECT
    o.customer_id,

    -- RECENCY
    DATEDIFF(
        (SELECT MAX(order_date) FROM orders),
        MAX(o.order_date)
    ) AS recency,

    -- FREQUENCY
    COUNT(o.order_id) AS frequency,

    -- MONETARY
    SUM(oi.quantity * oi.item_price) AS monetary

FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
GROUP BY o.customer_id;

-- Conducted SQL-based E-commerce sales and customer behavior analysis, including revenue trends, top customers, 
-- product performance, delivery metrics, and RFM-based customer segmentation, providing actionable insights 
-- for retention and revenue growth.