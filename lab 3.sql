/*
select distinct s.companyname from suppliers
join products
on suppliers.supplier_id=products.supplier_id
where unitprice<11;
*/
/*
select s.companyname, c.categoryname, c.description from suppliers as s
join categories as c
where description like "%pasta%" or
categoryname like "%Beverages%";
*/
/*
select e.last_name, e.city, em.last_name, em.city
from employees as e
join employees as em
on e.mgrid=em.emp_id
where e.city=em.city;
*/
/*
INSERT categories(category_id, categoryname, description) 
VALUES ( '9' ,'car', 'BMW, Bugatti, Honda, Lada');
SELECT categoryname from  categories c
left join  products p
on p.category_id = c.category_id where p.category_id is null;
delete from categories
where category_id = 9;
*/
/*
select distinct s.city from suppliers as s
join customers as c
where s.city=c.city;
*/
/*
select distinct s.city from suppliers as s
left join customers as c 
on s.city=c.city
where c.city is NULL;
*/
/*
SET SQL_SAFE_UPDATES = 0;
ALTER TABLE employees
ADD qualification VARCHAR(50);
UPDATE employees
set qualification = 
case
when year(curdate())-year(hiredate)>='15 '
THEN 'HIGH QUALIFICATION' 
when year(curdate())-year(hiredate)>='13' or year(curdate())-year(hiredate) <'15'
THEN 'MIDLE QUALIFICATION' 
else  'LOW QUALIFICATION'
end;
select first_name, last_name, year(curdate())-year(hiredate) as Experiance, qualification
from employees;
alter table employees
drop column qualification;
*/





