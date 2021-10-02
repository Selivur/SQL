select city, count(emp_id) as "Count of workers" from employees
group by city;

select c.category_id, c.categoryname, count(p.category_id) as "Product count" from categories c
join products p
on c.category_id=p.category_id
group by categoryname
having AVG(p.unitprice)>=25;

select c.cust_id, c.companyname, c.country, min(o.shippeddate) as "first_order", max(o.shippeddate) as "last_order" from customers c
join orders o
on c.cust_id=o.cust_id 
where country="USA"
group by cust_id
having  first_order>2006;

select c.country, c.region, c.city, 
count(o.order_id) as ord_sum, 
sum(od.unitprice * od.qty - od.unitprice *od.qty * od.discount) sum_of_price_orders
from customers c
join orders o
on c.cust_id=o.cust_id
join order_details od
on o.order_id=od.order_id
group by c.country, c.region, c.city with rollup
order by c.country, c.region, c.city;