drop procedure if exists task1;
drop procedure if exists task2;
drop procedure if exists task3;
drop procedure if exists task4;
drop table if exists tmp_customers;
drop table if exists tmp_customers_3;
drop table if exists tmp.categories;
drop table if exists table_4;


delimiter //
create procedure task1()
begin
  declare t_name varchar(10);
  create table tmp.categories as select * from categories;
    update tmp.categories
    set categoryname = (select categoryname from categories where category_id = tmp.categories.category_id + 1)
    where category_id % 2 = 1;
    update tmp.categories
    set categoryname = (select categoryname from categories where category_id = tmp.categories.category_id - 1)
    where category_id % 2 = 0;
    select * from tmp.categories;
end//

delimiter ;
call task1();

delimiter //

create procedure task2()
begin
  declare row_not_found tinyint default false;
    declare cust_id_c int;
    declare contactname_c varchar (30);
  declare contacttitle_c varchar (30);
    declare t_contacttitle varchar (30);
    declare count_cust int default 0;
    declare r_cursor cursor for select cust_id, contactname, contacttitle from customers order by contacttitle, cust_id;
  declare continue handler for not found set row_not_found = true;
  create table tmp_customers (cust_id int, contactname varchar(30), contacttitle varchar(30));
    open r_cursor;
    while row_not_found = false do
    fetch r_cursor into cust_id_c, contactname_c, contacttitle_c;-- зчитуэмо запис з курсора
    if count_cust < 2 
    then
            insert into tmp_customers values (cust_id_c, contactname_c, contacttitle_c);
      if t_contacttitle != contacttitle_c and count_cust = 1 
        then set count_cust = 0;
      end if;
      set count_cust = count_cust + 1;
      set t_contacttitle = contacttitle_c;
      else if t_contacttitle != contacttitle_c 
          then set count_cust = 1;
          insert into tmp_customers values (cust_id_c, contactname_c, contacttitle_c);
          set t_contacttitle = contacttitle_c;
      end if;
    end if;
    end while;
    close r_cursor;
  select * from tmp_customers;
end//
delimiter ;
call task2();


delimiter //
create procedure task3()
begin
  set @i = 0;
  alter table customers add column (num int null);
  update customers set num = @i:= @i+1 where num is null order by contactname;
  select num, contactname  from customers order by contactname;
  alter table customers drop column num;
end//

delimiter ;
call task3();


DELIMITER //

create procedure task4()
begin
  declare row_not_found tinyint default false;
    declare country_v char(30);
    declare city_v char(30);
    declare prev_country char(30) default 0;
    declare num_country int default 0;
    declare num_city int default 0;
  declare r_cursor cursor for select country, city from customers group by country, city order by country;
  declare continue handler for not found set row_not_found = true;
  create table table_4 (num char(10), country_city char(50));
    open r_cursor;
    while row_not_found = false do
    fetch r_cursor into country_v, city_v;
    if prev_country = '0'
        then -- якщо перша країна
      set num_country = num_country + 1;
      set prev_country = country_v;
            insert into table_4 values (num_country, country_v); -- додаємо країну
            -- тепер місто
            set num_city = num_city + 1;
            insert into table_4 values (concat(num_country, '.', num_city),city_v);
    elseif prev_country != country_v 
      then -- якщо нова країнa
      set num_country = num_country + 1;
            set prev_country = country_v;
            insert into table_4 values (num_country, country_v); -- додаємо країну
            -- тепер місто
            set num_city = 1;
            insert into table_4 values (concat(num_country, '.', num_city),city_v);
    elseif prev_country = country_v then -- якщо міста країни ще не закінчилися
      -- додаємо наступне місто країни
            set num_city = num_city + 1;
            insert into table_4 values (concat(num_country, '.', num_city),city_v);
        end if;
  end while;
  close r_cursor;
  select * from table_4;
end//

DELIMITER ;

call task4();