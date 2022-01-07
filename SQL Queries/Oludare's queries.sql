USE Datajedidb;
show tables;

-- QUESTION 1
-- Top customers by total quantity of products orders

WITH mergedorder AS (SELECT orderid, SUM(quantity) totalorderquantity
FROM orderdetails
GROUP BY orderid)

SELECT customername, sum(totalorderquantity)
FROM customers c
JOIN orders o
ON c.customerid=o.customerid
JOIN mergedorder m
ON m.orderid=o.orderid
GROUP BY 1
ORDER BY 2 DESC;


-- Top customers by total spend on products

WITH mergedorder AS (SELECT orderid, sum(quantity*price) totalspend
FROM orderdetails o
JOIN products p
ON p.productid=o.productid
GROUP BY orderid)

SELECT customername, sum(totalspend)
FROM customers c
JOIN orders o
ON c.customerid=o.customerid
JOIN mergedorder m
ON m.orderid=o.orderid
GROUP BY 1
ORDER BY 2 DESC;


-- Top customers by total orders made

SELECT customername, COUNT(orderid)
FROM customers c
JOIN orders o
ON c.customerid=o.customerid
GROUP BY 1
ORDER BY 2 DESC;

-- QUESTION 2
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
-- Products with highest sales

SELECT p.productid as id, p.productname as product_name, SUM(quantity*price) as total_product_sales
FROM orderdetails o
JOIN products p
ON p.productid=o.productid
GROUP BY 1
ORDER BY 3 DESC
LIMIT 10;

-- QUESTION 4
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

