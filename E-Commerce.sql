-- 🛍️ E-COMMERCE SQL PROJECT
-- 👨‍💻 Author: Maaz Patel
-- 📘 Database: Online_Shopping 
-- 🧱 Built using MySQL Workbench 8.0 CE


-- Step 1: Creating a new Database
CREATE DATABASE Online_Shopping;
USE Online_Shopping;

-- Step 2: Creating Tables                                                 
-- Customers Table
CREATE TABLE Customers (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    full_name VARCHAR(30) NOT NULL,
    email VARCHAR(30) UNIQUE NOT NULL,
    phone VARCHAR(15),
    address VARCHAR(100)
);        

-- Categories Table
CREATE TABLE Categories (
    category_id INT AUTO_INCREMENT PRIMARY KEY,
    category_name VARCHAR(50) NOT NULL
);

-- Products Table
CREATE TABLE Products (                         
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    product_name VARCHAR(50) NOT NULL,
    category_id INT,
    price DECIMAL(10,2),
    stock INT DEFAULT 0,
    FOREIGN KEY (category_id) REFERENCES Categories(category_id)
);

-- Orders Table
CREATE TABLE Orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT,
    order_date DATETIME,
    status VARCHAR(20) DEFAULT 'Pending',
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);

-- OrderDetails Table
CREATE TABLE OrderDetails (
    order_detail_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT,
    FOREIGN KEY (order_id) REFERENCES Orders(order_id),
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
);

-- Payments Table
CREATE TABLE Payments (
    payment_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT,
    amount DECIMAL(10,2),
    payment_date DATE,
    payment_method VARCHAR(30),
    FOREIGN KEY (order_id) REFERENCES Orders(order_id)
);

Show databases;

INSERT INTO Customers(full_name, email, phone, address) VALUES
('Aarav Mehta', 'aarav.mehta@gmail.com', '9876543210', 'Mumbai, India'),
('Priya Sharma', 'priya.sharma@gmail.com', '9988776655', 'Delhi, India'),
('Rohan Patel', 'rohan.patel@gmail.com', '9876123450', 'Ahmedabad, India'),
('Sneha Kapoor', 'sneha.kapoor@gmail.com', '9765432109', 'Pune, India'),
('Rahul Nair', 'rahul.nair@gmail.com', '9822012345', 'Kochi, India'),
('Kabir Khan', 'kabirk@gmail.com', '9962745334', 'Jaipur,India'),
('Kunal Sharma', 'sharmakunnu@gmail.com', '8286924632', 'Mumbai,India'),
('Tarak Mehta', 'Tarakmehte@gmail.com', '7038419762', 'Nashik,India' ),
('Shankar Kumar', 'shanky787@gmail.com', '9898912120' , 'Punjab,India'),
('Prashant Kale', 'praashhly567@gmail.com', '8976541289', 'Kashmir,India');

Insert into Categories(category_name) Values
('Electronics'),
('Clothing'),
('Home Appliances'),
('Books'),
('Sports'),
('Beauty'),
('Furniture'),
('Clothing'),
('Accessories'),
('Styling');

INSERT INTO Products (product_name, category_id, price, stock) VALUES
('Smartphone', 1, 25000.00, 50),
('Laptop', 1, 60000.00, 30),
('T-shirt', 2, 800.00, 100),
('Microwave Oven', 3, 7500.00, 20),
('Cricket Bat', 5, 1500.00, 40),
('Fiction Book', 4, 500.00, 60),
('Sofa Set', 7, 35000.00, 15),
('Perfume', 6, 1200.00, 35),
('Headphones', 1, 2000.00, 45),
('Jeans', 2, 1500.00, 55);

INSERT INTO Orders (customer_id, order_date, status) VALUES
(1, '2025-11-01', 'Delivered'),
(2, '2025-11-02', 'Delivered'),
(3, '2025-11-03', 'Pending'),
(4, '2025-11-04', 'Delivered'),
(5, '2025-11-05', 'Shipped'),
(6, '2025-11-06', 'Pending'),
(7, '2025-11-07', 'Delivered'),
(8, '2025-11-08', 'Shipped'),
(9, '2025-11-09', 'Pending'),
(10, '2025-11-10', 'Delivered');

INSERT INTO OrderDetails (order_id, product_id, quantity) VALUES
(1, 1, 1),
(1, 3, 2),
(2, 2, 1),
(3, 5, 3),
(4, 6, 2),
(5, 4, 1),
(6, 9, 2),
(7, 10, 1),
(8, 8, 2),
(9, 7, 1),
(10, 2, 1);

INSERT INTO Payments (order_id, amount, payment_date, payment_method) VALUES
(1, 26600.00, '2025-11-01', 'Credit Card'),
(2, 60000.00, '2025-11-02', 'UPI'),
(3, 4500.00, '2025-11-03', 'Net Banking'),
(4, 1000.00, '2025-11-04', 'Debit Card'),
(5, 7500.00, '2025-11-05', 'Cash on Delivery'),
(6, 4000.00, '2025-11-06', 'UPI'),
(7, 1500.00, '2025-11-07', 'Credit Card'),
(8, 2400.00, '2025-11-08', 'Net Banking'),
(9, 35000.00, '2025-11-09', 'Credit Card'),
(10, 60000.00, '2025-11-10', 'Debit Card');  

DELETE FROM Payments
WHERE payment_id > 10;   
-- Here i by mistakely ran that payments code twice so,
-- i deleted that rows for not getiing future errors.

-- Showing all the data
select * from payments;

-- Show only customers names and amount
select payment_id,amount from payments;

-- Show only the first 5 records from the Payments table.
select * from payments
limit 5;

-- Find all payments where the amount is greater than 2000.
select * from payments
where amount > 2000;

-- Find all payments made using UPI as the payment method.
select * from payments
where payment_method = 'UPI';

-- Show all payments sorted by amount (highest to lowest).
select * from payments
order by amount ASC;

-- Find the total amount received from all payments.
select sum(amount) as total_amount from payments;

-- Count how many total payments have been made.
select * from payments;
select count(*) as total_payments from payments;

-- Show how many payments were made by each payment method.
SELECT payment_method, COUNT(*) AS total
FROM payments
GROUP BY payment_method;

-- Show all payments made on a particular date 
-- (you can choose any one payment_date from your data).
select * from payments
where payment_date = '2025-11-01';

-- Show each customer’s name along with their order_id and order_date. 
select * from customers;
select * from orders;
select full_name,order_id,order_date from customers
join orders
using (customer_id);

-- Show the customer name and amount they paid. 
select * from customers;
select * from orders;
select * from payments;
select full_name,amount from customers
join orders           
using (customer_id)
join payments
using (order_id);

-- Find all orders where the total amount is greater than 2000.
select * from orders;
select * from payments;
select * from payments
where amount > 2000;

-- Show all payments made through Credit Card, along with the customer name.
SELECT c.full_name, p.payment_method, p.amount
FROM Customers c
JOIN Orders o ON c.customer_id = o.customer_id
JOIN Payments p ON o.order_id = p.order_id
WHERE p.payment_method = 'Credit Card';

-- Show how many orders each customer has placed.
SELECT full_name, COUNT(order_id) AS total_orders
FROM Customers 
JOIN Orders using(customer_id)
GROUP BY full_name;

-- Find the highest payment amount made by any customer.
SELECT MAX(amount) AS maximum_payment
FROM Payments;

-- OR if we want to know which customer has made it so we can do like -->
SELECT c.full_name, p.amount
FROM Customers c
JOIN Orders o ON c.customer_id = o.customer_id
JOIN Payments p ON o.order_id = p.order_id
WHERE p.amount = (SELECT MAX(amount) FROM Payments);

-- Show the average order amount for all customers.
select * from payments;
select avg(amount) as average_amount
from payments;

-- Display the customer name who made the earliest order (the smallest order date).
select * from orders;
select * from customers;
select full_name,order_date
from customers 
join orders using(customer_id)
where order_date = (SELECT MIN(order_date) FROM Orders);

-- Show all customers who made more than one payment.
select * from customers;
select * from payments;
SELECT c.full_name,COUNT(p.payment_id) AS total_payments
FROM Customers c
JOIN Orders o ON c.customer_id = o.customer_id
JOIN Payments p ON o.order_id = p.order_id
GROUP BY c.full_name
HAVING COUNT(p.payment_id) > 1;

-- Show the total revenue (sum of all payments) made through each payment method.
select * from customers;
select * from orders;
select * from payments;
SELECT 
    payment_method, SUM(amount) AS total_revenue
FROM
    customers c
        JOIN
    orders o ON c.customer_id = o.customer_id
        JOIN
    payments p ON o.order_id = p.order_id
GROUP BY (payment_method);

/* Find the customers who made payments greater than the average payment 
 amount across all customers.*/
select * from payments;
select * from orders;
select * from customers;
SELECT full_name,amount
FROM customers
join orders using(customer_id)
JOIN payments using(order_id)
WHERE amount > (SELECT AVG(amount) FROM payments);

/* Find the total amount spent by each customer and show only those customers
whose total spending is greater than 3000. */
select full_name,sum(amount) as total_amount
from customers
join orders
using (customer_id)
join payments 
using (order_id)
group by full_name
having sum(amount) > 3000;

-- Find all customers who made payments using Credit Card or UPI.
SELECT full_name, payment_method, amount
FROM customers
JOIN orders USING (customer_id)
JOIN payments USING (order_id)
WHERE payment_method IN ('Credit Card', 'UPI');

-- Find the latest order (most recent date) made by each customer.
SELECT c.full_name, MAX(o.order_date) AS latest_order_date
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.full_name
ORDER BY latest_order_date DESC;

----------------------- WE ARE DONE WITH THE PROJECT.  ------------------------
/* WE HAVE CREATED THE DATABASE AND ALSO INSERTED VALUES AND WROTE THE QUERIES TO 
   UNDERSTAND WHAT DATA IS TRYING TO TELL. */
   
   -- 🎯 Project Completed Successfully!
-- 💡 Total Queries: 25 (Basic + Intermediate + Advanced)
-- 🧠 Learned: Joins | Group By | Having | Subqueries 
-- 🚀 Project By: Maaz Patel
-- 🛍️ E-Commerce Database Project
-- 📅 Completed On: November 2025
-- ✨ Thank You for Reviewing !

