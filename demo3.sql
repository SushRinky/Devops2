#As a Data Analyst, SQL is one of the most important tools you'll use for data extraction,
manipulation, and analysis. Here are several SQL queries and tasks tailored for a Data Analyst,
covering common operations such as data retrie
val, aggregation, joins, and data cleaning.

# 1. Basic SELECT Query
This query selects specific columns from a table.

SELECT customer_id, first_name, last_name, email
FROM customers;

#2. Filtering Data Using WHERE Clause
Filters the data based on certain conditions.

SELECT *
FROM sales
WHERE sale_date >= '2024-01-01' AND sale_amount > 1000;

#3. Sorting Data with ORDER BY
Sorts the data in ascending or descending order.

SELECT product_name, sale_amount
FROM sales
ORDER BY sale_amount DESC;

#4. Aggregate Functions
Uses functions like SUM, AVG, COUNT, MIN, and MAX to perform aggregations

SELECT COUNT(*) AS total_sales, SUM(sale_amount) AS total_revenue
FROM sales;

#5. GROUP BY Clause
Groups the data and performs aggregation for each group.

SELECT product_id, COUNT(*) AS total_sales, AVG(sale_amount) AS average_sale
FROM sales
GROUP BY product_id;

#6. Using HAVING Clause
Filters aggregated results (similar to WHERE but for grouped data).

SELECT product_id, COUNT(*) AS total_sales, AVG(sale_amount) AS average_sale
FROM sales
GROUP BY product_id
HAVING AVG(sale_amount) > 500;

#7. JOIN Operations
Performs inner, left, right, and full joins between tables.

INNER JOIN Example:
Finds customers who made purchases.

SELECT c.customer_id, c.first_name, s.sale_amount
FROM customers c
INNER JOIN sales s ON c.customer_id = s.customer_id;

#LEFT JOIN Example:
Includes all customers, even those without sales.

SELECT c.customer_id, c.first_name, s.sale_amount
FROM customers c
LEFT JOIN sales s ON c.customer_id = s.customer_id;

#8. Subqueries
Uses a query within another query.

SELECT customer_id, sale_amount
FROM sales
WHERE sale_amount > (SELECT AVG(sale_amount) FROM sales);

#9. Using CASE Statements
Creates conditional logic in queries.

SELECT customer_id, sale_amount,
    CASE
        WHEN sale_amount > 1000 THEN 'High'
        WHEN sale_amount BETWEEN 500 AND 1000 THEN 'Medium'
        ELSE 'Low'
    END AS sale_category
FROM sales;

#10. Data Cleaning with SQL
Handles missing values and removes duplicates.

Handling Missing Values:
Replace null values with a default value.

UPDATE customers
SET email = 'unknown@example.com'
WHERE email IS NULL;

#Removing Duplicates:
Delete duplicate rows based on specific columns.

DELETE FROM customers
WHERE rowid NOT IN (
    SELECT MIN(rowid)
    FROM customers
    GROUP BY first_name, last_name, email
);

#11. Window Functions
Uses window functions for advanced analysis.

ROW_NUMBER Example:
Ranks sales by amount per customer.

SELECT customer_id, sale_date, sale_amount,
       ROW_NUMBER() OVER (PARTITION BY customer_id ORDER BY sale_amount DESC) AS rank
FROM sales;

#Running Total Example:
Calculates the cumulative total sales amount.

SELECT sale_date, sale_amount,
       SUM(sale_amount) OVER (ORDER BY sale_date) AS running_total
FROM sales;

#12. Common Table Expressions (CTE)
Creates temporary result sets for more readable queries.

WITH total_sales AS (
    SELECT customer_id, SUM(sale_amount) AS total_spent
    FROM sales
    GROUP BY customer_id
)
SELECT c.customer_id, c.first_name, total_sales.total_spent
FROM customers c
JOIN total_sales ON c.customer_id = total_sales.customer_id;

#13. Creating and Using Views
Creates a view for reusable queries.


CREATE VIEW high_value_sales AS
SELECT customer_id, sale_date, sale_amount
FROM sales
WHERE sale_amount > 1000;

-- Using the view
SELECT * FROM high_value_sales;

#14. Data Extraction with JOIN and Aggregation
Provides a summary report of sales per customer with their details.

SELECT c.customer_id, c.first_name, c.last_name, COUNT(s.sale_id) AS number_of_purchases, SUM(s.sale_amount) AS total_spent
FROM customers c
LEFT JOIN sales s ON c.customer_id = s.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name
ORDER BY total_spent DESC;

#15. Pivot Table with SQL
Creates a pivot-like report showing monthly sales per product.

SELECT product_id,
       SUM(CASE WHEN MONTH(sale_date) = 1 THEN sale_amount ELSE 0 END) AS January,
       SUM(CASE WHEN MONTH(sale_date) = 2 THEN sale_amount ELSE 0 END) AS February,
       SUM(CASE WHEN MONTH(sale_date) = 3 THEN sale_amount ELSE 0 END) AS March
FROM sales
GROUP BY product_id;

#Tips for Data Analysts Using SQL:
Understand the Data Model: Know the tables and their relationships before writing queries.
Use Aliases: Use table aliases (e.g., c for customers) to make your queries more readable.
Indexing: Ensure proper indexing for faster query performance, especially when dealing with large datasets.
Test with LIMIT: When running complex queries, use LIMIT to test the output on a smaller dataset.
Document Your Queries: Comment on your code (-- comment here) to make it easier for others (or yourself) to understand later.
These examples cover fundamental SQL tasks that a Data Analyst might perform.
Let me know if you need more specific examples or advanced topics!




