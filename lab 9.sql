USE tsql2012;
set SQL_SAFE_UPDATES = 0;
-- №1
 
delimiter //
DROP PROCEDURE IF EXISTS ex_1; 
drop table if exists tmp_orders_d;
CREATE PROCEDURE ex_1(custid INT, empid INT, t_productname VARCHAR(40), t_unitprice FLOAT, t_qty SMALLINT, t_discount DECIMAL(4, 3))
BEGIN
  SET @i = (SELECT COUNT(*) FROM orders WHERE cust_id = custid AND emp_id = empid);
    IF @i = 1 THEN
    CREATE TABLE tmp_orders_d AS SELECT * FROM order_details;
    INSERT tmp_orders_d(order_id, product_id, unitprice, qty, discount) VALUES ((SELECT order_id FROM orders WHERE cust_id = custid AND emp_id = empid), 
        (SELECT product_id FROM products WHERE productname = t_productname), t_unitprice, t_qty, t_discount);
    SELECT * FROM tmp_orders_d WHERE unitprice = t_unitprice AND qty = t_qty AND discount = t_discount;
    ELSE
    SELECT 'ERROR';
  END IF;
END//

delimiter ;
CALL ex_1(1, 3, 'Product HHYDP', 18, 6, 2);

-- №2
  
START TRANSACTION;
SAVEPOINT bef_ch;
DROP TABLE IF EXISTS tree;

create table tree
(
  id int not null auto_increment primary key,
    par_id int null,
    val int not null,
    constraint foreign key (par_id) references tree (id)
);
insert into tree(par_id, val) values 
  (null, 5),
  (1, 2),
    (2, 1),
    (2, 3),
    (4, 4),
    (1, 6),
    (6, 8),
    (7, 7),
    (7, 9);
    
select * from tree;

DROP PROCEDURE IF EXISTS del_node_with_ch;
delimiter //
CREATE PROCEDURE del_node_with_ch
(
  node_id int
)
BEGIN
  declare notfound tinyint default false;
    declare current_vertex int;
    DECLARE cur CURSOR FOR SELECT id from tree where par_id = node_id;
    declare continue handler for not found
    set notfound = true;
  SET max_sp_recursion_depth=100;
    
    if not exists (select * from tree where id = node_id)
    then signal sqlstate '11111'
    set message_text = 'There is no vertex with such id';
    else
    OPEN cur;
    read_loop: LOOP
      FETCH cur INTO current_vertex;
            if notfound then
        close cur;
        leave read_loop;
            end if;
      call del_node_with_ch(current_vertex);
        end loop read_loop;
  end if;
  
    delete from tree
    where id = node_id;
END;//
delimiter ;

CALL del_node_with_ch(5);
select * from tree;
ROLLBACK TO SAVEPOINT bef_ch;
-- №3
 
START TRANSACTION;
SAVEPOINT bef_ch;
DROP FUNCTION  IF EXISTS max_len;
delimiter //
CREATE FUNCTION  max_len
(
  str varchar(200)
)
returns varchar(200)
NO SQL
BEGIN
  declare cur_string varchar(200);
  declare max_word varchar(200);
    declare max_word_len int;
    declare str_len int;
    set cur_string = str;
    set max_word_len = 0;
    set str_len = length(cur_string);
    while(str_len>max_word_len) do
    if(length(substring_index(cur_string, ' ', 1)) >  max_word_len) then
      set max_word = (select substring_index(cur_string, ' ', 1));
      set max_word_len = length(max_word);
        end if;
        set cur_string = (select substring_index(cur_string, concat((select substring_index(cur_string, ' ', 1)),' '), -1));
        set str_len = length(cur_string);
  end while;
 return max_word;   
END;//
delimiter ;

select max_len('Find the biggest word');
ROLLBACK TO SAVEPOINT bef_ch;

-- №4
  
DROP FUNCTION IF EXISTS max_substr;
delimiter //
CREATE FUNCTION  max_substr
(
  short_str varchar(200),
    long_str varchar(200)
)
returns varchar(200)
DETERMINISTIC
BEGIN
  DECLARE short_len INT DEFAULT CHAR_LENGTH(short_str);
  DECLARE long_len INT DEFAULT CHAR_LENGTH(long_str);
  DECLARE swap_str TEXT;

  DECLARE max_matched_len INT DEFAULT 0;
  DECLARE max_at_left_marker INT DEFAULT NULL;
  DECLARE max_at_match_len INT DEFAULT NULL;
  DECLARE left_marker INT DEFAULT 0;
  DECLARE match_len INT DEFAULT NULL;

  IF (short_str IS NULL OR long_str IS NULL) THEN
    RETURN NULL;
  ELSEIF (short_str = long_str) THEN
    RETURN short_str;
  END IF;

  IF (short_len > long_len) THEN
    SET swap_str = long_str;
    SET long_str = short_str;
    SET short_str = swap_str;
    SET short_len = long_len;
    SET long_len = CHAR_LENGTH(long_str);
  END IF;
  
  left_loop: LOOP
     SET left_marker = left_marker + 1;
     IF (left_marker + max_matched_len > short_len) THEN
      LEAVE left_loop;
     END IF;
     SET match_len = max_matched_len;
  right_loop: LOOP
    SET match_len = match_len + 1;
    IF (1 - left_marker + match_len) > short_len THEN
      LEAVE right_loop;
    END IF;
    IF (long_str LIKE CONCAT ('%',SUBSTRING(short_str FROM left_marker FOR match_len),'%')) THEN
      SET max_matched_len = match_len, max_at_left_marker = left_marker;
    ELSE
      LEAVE right_loop;
    END IF;
    END LOOP;
  END LOOP;

  IF (max_matched_len) THEN
    RETURN SUBSTRING(short_str FROM max_at_left_marker FOR max_matched_len);
  ELSE
    RETURN NULL;
  END IF;
END;//
delimiter ;

select max_substr('abc', 'abc');
ROLLBACK TO SAVEPOINT bef_ch;
-- №5
  
DROP PROCEDURE IF EXISTS orders_y;
delimiter //
CREATE PROCEDURE orders_y
(
  year1 int(4),
  year2 int(4)
)
BEGIN
  drop table if exists customers2;
  create table customers2 as select cust_id from customers;
alter table customers2 add column (year4 int null);
alter table customers2 add column (year5 int null);

  update customers2 set year4 = 
  (select count(*) from orders where customers2.cust_id = orders.cust_id and year(orderdate) = year1 ) where year4 is null ;
  update customers2 set year5 = 
  (select count(*) from orders where customers2.cust_id = orders.cust_id and year(orderdate) = year2 ) where year5 is null ;
  select cust_id, year4 as a, year5 as b from customers2;
END;//
delimiter ;

CALL orders_y(2007, 2008); 