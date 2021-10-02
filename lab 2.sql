#SELECT * FROM tsql_2012.employees where birthdate < "1950-01-01 00:00:00";

#SELECT *, year(curdate())-year(hiredate) as  Experiance  FROM tsql_2012.employees;

#SELECT concat(last_name, " ", first_name) as name_and_surname  FROM tsql_2012.employees;

/*
SELECT * FROM customers WHERE contacttitle 
LIKE "%Manager%" AND (region IN("BC", "OR", "SP") OR region IS NULL);
*/

select *, count(*) from orders 
where orderdate between "2006-08-01" AND "2007-01-14" AND 
(freight <15 OR freight>55) AND (shipcountry!="USA" OR 
(shipcountry="USA" AND shippostalcode <10250));
