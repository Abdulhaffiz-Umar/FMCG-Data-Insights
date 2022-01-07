USE datajedidb;
SHOW TABLES; 

-- QUESTION 1
-- Commence a loyalty program for our top customers
-- Top customers with with the highest purchase and expenditure

WITH t1 as
		(SELECT  c.customerid AS id,
				c.customername AS name,
				o.orderid, 
				od.quantity as number_of_items,
                p.price as total_amount_spent
		FROM customers c
			JOIN orders  o
			ON c.customerid = o.customerid 
			JOIN orderdetails od
			ON o.orderid = od.orderid 
            JOIN products p
            ON p.productid = od.productid) 
SELECT DISTINCT name, 
				SUM(number_of_items) OVER (PARTITION BY name) as quantity_count,
                SUM(number_of_items * total_amount_spent) OVER (PARTITION BY name) as Total_amount_spent
FROM t1
ORDER BY 3 DESC; 

-- QUESTION 2
-- Make more investment into locations with highest sales
-- Region with the highest sales

WITH mergedorder AS (SELECT orderid, sum(quantity*price) totalspend
FROM orderdetails o
JOIN products p
ON p.productid=o.productid
GROUP BY orderid)

SELECT country, sum(totalspend) as total_expenditure
FROM customers c
JOIN orders o
ON c.customerid=o.customerid
JOIN mergedorder m
ON m.orderid=o.orderid
GROUP BY 1
ORDER BY 2 DESC
LIMIT 10; 

-- QUESTION 3
-- Make more investment into products with highest sales and profitability
-- Products with highest sales

SELECT p.productid as id, p.productname as product_name, SUM(quantity*price) as total_product_sales
FROM orderdetails o
JOIN products p
ON p.productid=o.productid
GROUP BY 1
ORDER BY 3 DESC
LIMIT 10;

-- QUESTION 4
-- Commence a reward program for our most hard working workers
-- Highest performing employees by sales

WITH mergedorder AS (SELECT orderid, sum(quantity*price) totalspend
FROM orderdetails o
JOIN products p
ON p.productid=o.productid
GROUP BY orderid)

SELECT CONCAT(FirstName, ' ',LastName) as Name, sum(totalspend) as Sales
FROM customers c
JOIN orders o
ON c.customerid=o.customerid
JOIN mergedorder m
ON m.orderid=o.orderid
JOIN employees e
ON o.employeeid=e.employeeid
GROUP BY 1
ORDER BY 2 DESC; 

-- QUESTION 5
-- Identify key customer segments within the beverage product line to prioritize
-- Top customers with total spend on beverages

WITH mergedorder AS (SELECT orderid, sum(quantity*price) totalspend
FROM orderdetails o
JOIN products p
ON p.productid=o.productid
WHERE categoryid=1
GROUP BY orderid)

SELECT customername AS customer_name, sum(totalspend) as total_expenditure
FROM customers c
JOIN orders o
ON c.customerid=o.customerid
JOIN mergedorder m
ON m.orderid=o.orderid
GROUP BY 1
ORDER BY 2 DESC
LIMIT 10; 

