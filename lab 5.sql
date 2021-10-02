select cust_id, companyname, contactname,
(select count(distinct supplier_id) from products 
where product_id IN (select product_id from order_details 
where order_id IN (select order_id from orders o 
where o.cust_id = customers.cust_id))) as "count of suppliers"
from customers;

select last_name as employee,
ifnull((select last_name from employees e
where e.emp_id=em.mgrid), "top manager") as manager
from employees em;

select distinct companyname, cust_id
from customers
where cust_id IN
(select cust_id from orders
where orderdate < (select min(orderdate) from orders
where cust_id IN
(select cust_id	from customers 
where companyname = 'Customer LCOUJ')));

select contactname from customers c
where NOT exists (select * from customers cu
where cu.city = c.city AND
cu.cust_id !=c.cust_id)
order by city;

select city, count from
(select city,count(*) as count from customers 
group by city) a 
where count>4;

SELECT DISTINCT city_list.city as CITY, 
(SELECT count(*) as c1 FROM suppliers WHERE suppliers.city = city_list.city ) as Suppliers, 
(SELECT count(*) as c2 FROM customers WHERE customers.city = city_list.city ) as Customers,
SUM((SELECT count(*) as c1 FROM suppliers WHERE suppliers.city = city_list.city) + 
(SELECT count(*) as c2 FROM customers WHERE customers.city = city_list.city)) as Sum
from (select city from customers
union
select city  from suppliers) as city_list
where (SELECT count(*) as c1 FROM suppliers WHERE suppliers.city = city_list.city) + 
(SELECT count(*) as c2 FROM customers WHERE customers.city = city_list.city) > 3 AND
 (SELECT count(*) as c1 FROM suppliers WHERE suppliers.city = city_list.city) + 
(SELECT count(*) as c2 FROM customers WHERE customers.city = city_list.city) < 6
group by city_list.city;

select distinct orderdate, 
(select count(order_id) from order_details o where o.order_id=orders.order_id) as numbers_of_orders,
(select sum(unitprice*qty - unitprice*qty*discount) from order_details ord where ord.order_id=orders.order_id) as val
from orders
group by orderdate;

select categoryname,
(select count(supplier_id) from products p 
where p.category_id=c.category_id 
group by category_id) as count
from categories c;

