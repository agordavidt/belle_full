CREATE DATABASE IF NOT EXISTS `fooddb`;

USE `fooddb`;


CREATE TABLE IF NOT EXISTS `admin` (
    id INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    full_name VARCHAR(200),
    username VARCHAR(200) UNIQUE,
    password VARCHAR(200) -- Consider using a hash for security
);

CREATE TABLE IF NOT EXISTS `category` (
    id INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(200),
    image_name VARCHAR(255),
    featured BOOLEAN DEFAULT FALSE,
    active BOOLEAN DEFAULT TRUE
);

CREATE TABLE IF NOT EXISTS `food` (
    id INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(200),
    description TEXT,
    price DECIMAL(10, 2),
    image_name VARCHAR(200),
    category_id INT UNSIGNED,
    featured BOOLEAN DEFAULT FALSE,
    active BOOLEAN DEFAULT TRUE,
    FOREIGN KEY (category_id) REFERENCES category(id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS `customer` (
    id INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(200),
    contact VARCHAR(200),
    email VARCHAR(200) UNIQUE,
    address VARCHAR(255)
);

CREATE TABLE IF NOT EXISTS `order` (
    id INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    customer_id INT UNSIGNED,
    order_time DATETIME DEFAULT CURRENT_TIMESTAMP,
    status VARCHAR(50),
    total DECIMAL(10, 2),
    FOREIGN KEY (customer_id) REFERENCES customer(id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS `order_item` (
    id INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    order_id INT UNSIGNED,
    food_id INT UNSIGNED,
    quantity INT,
    price DECIMAL(10, 2),
    FOREIGN KEY (order_id) REFERENCES `order`(id) ON DELETE CASCADE,
    FOREIGN KEY (food_id) REFERENCES food(id) ON DELETE CASCADE
);


/*  
Explanation of the Schema
Admin Table:

Stores information about the administrators managing the system. The username is unique to prevent duplicates.
Category Table:

Contains categories for food items, allowing for a structured organization. The featured and active columns are Boolean for clarity.
Food Table:

Stores details about each food item. The category_id links to the category table, creating a foreign key relationship that helps categorize the food items.
Customer Table:

A new table to store customer details. This separation allows for better management of customer information and prevents redundancy in the order table.
Order Table:

Represents customer orders. Each order is linked to a customer via customer_id. The total field holds the overall order cost.
Order_Item Table:

This junction table links orders and food items, allowing multiple food items to be associated with a single order. It contains the quantity of each item ordered and the price at the time of the order.
Relationships
Admin to All Tables: Admins manage the other tables but do not have a direct relationship represented in the schema.
Category to Food (One-to-Many): Each category can have multiple food items, but each food item belongs to only one category.
Customer to Order (One-to-Many): A single customer can place multiple orders, but each order is linked to one customer.
Order to Order_Item (One-to-Many): Each order can have multiple items, and this relationship is managed through the order_item table.
Food to Order_Item (One-to-Many): Each food item can be included in multiple orders, represented in the order_item table.
Advantages of Normalization
Reduces Redundancy: By separating customer information, food details, and orders, we minimize duplicated data.
Improves Data Integrity: Foreign keys ensure that relationships between tables are maintained and that invalid data cannot be entered.
Facilitates Management: Separating data into distinct tables allows for easier updates and management of each aspect of the system.


*/