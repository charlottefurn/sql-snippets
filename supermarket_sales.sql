-- Here I'm analysing the value of non-member and member customers, best selling products in a specific time period and customer satisfaction.

-- How many customers are members per city and what's the difference in spend between each customer type?
SELECT customer_type, COUNT(customer_type), city, SUM(total)
FROM supermarket_sales
GROUP BY customer_type, city
ORDER BY city, customer_type;

-- Average purchase value by customer type:
SELECT customer_type, ROUND(AVG(total))
FROM supermarket_sales
GROUP BY customer_type;

-- What product line has the most sales in January 2019?
SELECT product_line, ROUND(SUM(total)) AS total, COUNT(total) AS sales
FROM supermarket_sales
WHERE date BETWEEN '1/1/2019' AND '1/31/2019'
GROUP BY product_line;

-- Satisfaction rating by branch:
SELECT city, branch, AVG(rating) AS average_rating
FROM supermarket_sales
GROUP BY city, branch;
