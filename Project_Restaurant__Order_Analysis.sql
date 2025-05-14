-- Analyse the restaurant-db Based on the following Questions: {USE restaurant_db}

-- OBJECTIVE-1

/*
View the menu_items table and  write a query to find the number of items on the menu
*/

-- Query to view the menu_items table
SELECT 
	*
FROM menu_items;

-- Query to find the number of items on the menu
SELECT 
	COUNT(DISTINCT item_name) AS number_of_items
FROM menu_items;
 

    
    
/*
What are the least and most expensive items on the menu?
*/

-- Least Expensive Dish
SELECT
	*
FROM menu_items
ORDER BY price;

-- Most Expensive Dish
SELECT
	*
FROM menu_items
ORDER BY price DESC;




/*
How many Italian dishes are on the menu? What are the least and most expensive Italian dishes on the menu?
*/

-- Count of Italian Dishes
SELECT 
	*
FROM menu_items
WHERE category= 'Italian';

-- Least expensive Italian Dish
SELECT 
	*
FROM menu_items
WHERE category= 'Italian'
ORDER BY
	price;
    
-- Most expensive Italian Dish
SELECT 
	*
FROM menu_items
WHERE category= 'Italian'
ORDER BY
	price DESC;


/*
How many dishes are in each category? What is the average dish price within each category?
*/

-- Count of number of dishes in each category
SELECT DISTINCT
	 category,
     COUNT(item_name) AS number_of_dishes
FROM menu_items
GROUP BY
	category;

-- Average price of each dish within each category
SELECT DISTINCT
	 category,
     AVG(price) AS AVG_price_of_dishes
FROM menu_items
GROUP BY
	category;
    
    
-- OBJECTIVE-2

/*
View the order_details table. What is the date range of the table?
*/

-- Query to view the table
SELECT 
	*
 FROM order_details;
 
 -- Query to find the date range
SELECT 
	MIN(order_date),
    MAX(order_date)
 FROM order_details;
 
 

/*
How many orders were made within this date range? How many items were ordered within this date range?
*/

-- Count of orders made within this date range
SELECT 
	MIN(order_date),
    MAX(order_date),
	COUNT(DISTINCT order_id) AS number_of_orders
 FROM order_details;
 
 -- Count of numbers of items ordered within the date range
SELECT 
	MIN(order_date),
    MAX(order_date),
	COUNT(*) AS number_of_orders
 FROM order_details;
 
 

/*
Which orders had the most number of items?
*/

-- Orders with most number of times
SELECT
	order_id,
    COUNT(item_id) AS number_of_items
 FROM order_details
 GROUP BY 
	order_id
ORDER BY 
	number_of_items DESC;



/*
How many orders had more than 12 items?
*/

-- Count of number of orders with more than 12 items
SELECT
	COUNT(*) 
FROM 
(SELECT
	order_id,
    COUNT(item_id) AS number_of_items
 FROM order_details
 GROUP BY 
	order_id
HAVING
	number_of_items > 12) AS number_of_orders;
    


-- OBJECTIVE-3

/*
Combine the menu_items and order_details tables into a single table
*/

-- Query to view menu_items table
SELECT 
	*
FROM menu_items;

-- Query to view order_details table
SELECT
	*
FROM order_details;

-- Query to join menu_items and order_details table
SELECT
	*
FROM order_details
LEFT JOIN menu_items 
	ON order_details.item_id=menu_items.menu_item_id;
    
    


/*
What were the least and most ordered items? What categories were they in?
*/

-- Query to view the least and most ordered items
SELECT
	item_name,
    category,
    COUNT(order_details_id) AS number_of_times_ordered
FROM order_details
LEFT JOIN menu_items 
	ON order_details.item_id=menu_items.menu_item_id
GROUP BY 
	item_name,
    category
ORDER BY 
	number_of_times_ordered DESC;
    



/*
What were the top 5 orders that spent the most money?
*/

-- Query to view the top 5 orders that are spent the most money on
SELECT
	order_id,
    SUM(price) AS total_spent
FROM order_details
LEFT JOIN menu_items 
	ON order_details.item_id=menu_items.menu_item_id
GROUP BY 
	order_id
ORDER BY 
	total_spent DESC
LIMIT 5;




/*
View the details of the highest spend order. Which specific items were purchased (category of dishes)?
*/

-- Query to view the details of the highest spend order
SELECT
	category,
    COUNT(item_id) AS number_of_orders
FROM order_details
LEFT JOIN menu_items 
	ON order_details.item_id=menu_items.menu_item_id
WHERE order_id= 440
GROUP BY 
	category;



/*
BONUS: View the details of the top 5 highest spend orders
*/

-- Query to view the details of top 5 highest spend order
SELECT
	order_id,
	category,
    COUNT(item_id) AS number_of_orders
FROM order_details
LEFT JOIN menu_items 
	ON order_details.item_id=menu_items.menu_item_id
WHERE order_id IN (440,2075,1957,330,2675)
GROUP BY 
	order_id,
    category;



-- FINAL PROJECT QUESTION- 
-- How much was the most expensive order in the dataset?