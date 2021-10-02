set SQL_SAFE_UPDATES = 0;
drop database if exists tmp;
CREATE DATABASE IF NOT EXISTS tmp;
USE tmp;
-- 1
create table Employees as
select emp_id, last_name AS employee_name, address, city, ifnull(region, ""), postalcode, country, phone 
from tsql_2012.employees;
-- 2
insert into Employees 
select
supplier_id, substr(contactname, 1, 20), address, city, ifnull(region, "") as region, postalcode, country, phone
from tsql_2012.suppliers;
select * from Employees;
-- 3
update Employees as E
set E.city= "Andorra"
where E.city like "L%" AND
E.country in (select country from tsql_2012.customers);
-- 4
create table orders 
select order_id as orderid, cust_id as custid, emp_id as empid, orderdate, 0 as item_cnt	
from tsql_2012.orders;
select * from orders;
-- 4.2
create table order_details 
select order_id as orderid, product_id as productid, unitprice, qty, discount, 0 as item_cnt	
from tsql_2012.order_details;
select * from order_details;
-- 5
update orders
set item_cnt = (select count(*) from tmp.order_details where order_details.orderid=orders.orderid);
select * from orders;
-- 6 
delete from order_details od 
where exists (select * from orders o where od.orderid=o.orderid AND
orderdate between '2007-01-01' AND '2008-01-01');
SELECT * FROM tmp.order_details o join tmp.orders d on o.orderid=d.orderid ;

