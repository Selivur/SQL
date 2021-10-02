use tsql2012;
SELECT JSON_EXTRACT('[{"address": {
"street": "123 First Street",
"city": "Oxnard",
"state": "CA",
"zip": "90122"
}},
{"address": {
"street":"4 Main Street",
"city":"Melborne",
"state":"California",
"zip":"90125"
}},
{"address": {
"street":"173 Caroline Ave",
"city":"Montrose",
"state":"Georgia",
"zip":"31505"
}}]', '$[1 to 2].address.zip' ) AS "ZIP codes";

-- 2

select cast(concat('{"country": "', e.country,'", "employees" : ',
  (select json_arrayagg(em.last_name) from employees em where em.country= e.country),'}') as JSON) as "employees"
    from employees e group by e.country;
    
-- 3

use tmp;
drop table if exists emp;
SET SQL_SAFE_UPDATES = 0;
create table emp
(
  id int key auto_increment,
    country_emp json default NULL
);
insert into emp(country_emp)
  select cast(concat('{"country": "', e.country,'", "employees" : ',
  (select json_arrayagg(em.last_name) from tsql2012.employees em where em.country= e.country),'}') as JSON)
    from tsql2012.employees e group by e.country;
    
update emp
   set country_emp = json_merge_preserve(country_emp, concat('{"emp_cnt" : ', json_length(country_emp->'$.employees'),'}'));
select * from emp;

-- 4

select country_emp->>'$.country' as "country", tbl_1.employee from emp,
  json_table(emp.country_emp, '$.employees[*]' columns(employee varchar(50) path '$')) tbl_1;
  