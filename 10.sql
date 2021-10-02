WITH sup (`name`, address, `avg`) AS (
  SELECT 
    contactname, address, (SELECT AVG(unitprice) from products where 
    suppliers.supplier_id = products.supplier_id) 
  from suppliers )     
SELECT `name`, address, `avg` from sup
where 
`avg` > (SELECT `avg` from sup where `name` = 'Hance, Jim')
order by `name`;


-- 2
WITH total (contactname, address, total_2006, total_2007, total_2008) AS (
SELECT 
contactname, address, 
(SELECT SUM(qty) FROM orders join order_details on orders.order_id = order_details.order_id join products on 
order_details.product_id = products.product_id join suppliers a on products.supplier_id = suppliers.supplier_id 
where a.supplier_id = suppliers.supplier_id and orderdate LIKE ("%2006%")),
(SELECT SUM(qty) FROM orders join order_details on orders.order_id = order_details.order_id join products on 
order_details.product_id = products.product_id join suppliers a on products.supplier_id = suppliers.supplier_id 
where a.supplier_id = suppliers.supplier_id and orderdate LIKE ("%2007%")),
(SELECT SUM(qty) FROM orders join order_details on orders.order_id = order_details.order_id join products on 
order_details.product_id = products.product_id join suppliers a on products.supplier_id = suppliers.supplier_id 
where a.supplier_id = suppliers.supplier_id and orderdate LIKE ("%2008%"))
from suppliers) 
SELECT contactname, address, total_2006, total_2007, total_2008 from total;

-- 3
WITH RECURSIVE cte AS
(
SELECT emp_id, last_name, mgrid from employees where last_name = "Peled"
UNION ALL
SELECT e.emp_id, e.last_name, e.mgrid from employees e join cte on e.emp_id = cte.mgrid
)
SELECT emp_id, last_name from cte;

-- 4
DROP TABLE IF EXISTS `routes`;
CREATE TABLE routes (
  id bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  departing varchar(100) NOT NULL,
  arriving varchar(100) NOT NULL,
  PRIMARY KEY (id),
  UNIQUE KEY id (id)
);

INSERT INTO routes VALUES 
  (1,'Raleigh','Washington')
    ,(2,'Raleigh','Atlanta')
    ,(3,'Raleigh','Miami')
    ,(4,'Atlanta','Chicago')
    ,(5,'Chicago','New York')
    ,(6,'New York','Washington')
    ,(7,'Washington','Raleigh')
    ,(8,'New York','Toronto')
    ,(9,'Washington','New York')
    ,(10,'Atlanta','Miami')
    ,(11,'Atlanta','Raleigh')
    ,(12,'Miami','Raleigh')
    ,(13,'Houston','Chicago')
    ,(14,'Toronto','New York');
with recursive All_routes as
(
select departing as way, departing as arriving, 0 as distance
from routes where departing ='Raleigh'
  union all
select Concat(way,',',routes.arriving), routes.arriving, distance+1
from All_routes,routes
where All_routes.arriving=routes.departing 
and
POSITION(routes.arriving IN All_routes.way)=0
)
select * from All_routes
where All_routes.arriving='Toronto' 
order by  All_routes.distance
limit 1;