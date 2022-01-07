select distinct o.orderid,
				o.customerid as id, 
                c.customername as name,
				count(orderid)
		from orders
        join customers c
        on c.cutomerid = o.customerid
        group by 2
        order by 3 desc;
        
-- first successful surgery of quantity and customer id
-- i will continue to build the query from this joint
select quantity, 
(select customerid from orders where orders.orderid = orderdetails.orderid)
from orderdetails;

-- attempt to build query by adding other relevant tables and aggregations 
-- this successfully added the name
-- added everything else but i'm not quite sure about the summing of the quantities 

SELECT 
			orderid as id, 
            sum(quantity) over (partition by orderid) as sum,	 
			(select customerid 
            from orders 
            where orders.orderid = orderdetails.orderid) as customer_id,
            (select customername 
            from customers
            join orders 
            on orderdetails.orderid = orders.orderid
            where orders.customerid = customers.customerid) as name
            
from orderdetails
group by 3
order by 2 desc;



;



select quantity, 
(select customerid from orders where orders.orderid = orderdetails.orderid)
from orderdetails;



select FirstName, LastName, CONCAT(FirstName, ' ',LastName) as Name
from Employees 