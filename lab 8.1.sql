-- CREATE DATABASE isolation;
use isolation;
DROP TABLE IF EXISTS tbl1;
DROP TABLE IF EXISTS tbl2;
CREATE TABLE tbl1(id integer primary key, text varchar(200));
CREATE TABLE tbl2(id integer primary key, text varchar(200));

SET session TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
set SQL_SAFE_UPDATES = 0;
-- 1.1
SELECT @@transaction_isolation;

START TRANSACTION;
SELECT * FROM tbl1;
ROLLBACK;
/*
-- 1.2
SELECT @@transaction_isolation;

START TRANSACTION;
SELECT * FROM tbl1;
COMMIT;

-- 2.1
SET TRANSACTION ISOLATION LEVEL READ COMMITTED;

SELECT @@transaction_isolation;

START TRANSACTION;
SELECT * FROM tbl1;
COMMIT;

-- 2.2
SET TRANSACTION ISOLATION LEVEL REPEATABLE READ;

SELECT @@transaction_isolation;

START TRANSACTION;
SELECT * FROM tbl1;
COMMIT;

-- 3.1
SET TRANSACTION ISOLATION LEVEL REPEATABLE READ;

SELECT @@transaction_isolation;

START TRANSACTION;
SELECT * FROM tbl1 WHERE id >= 1 AND id <=5 ;
UPDATE tbl1 SET text = CONCAT(text, '*') WHERE id = 3;
SELECT * FROM tbl1 WHERE id >= 1 AND id <=5 ;
COMMIT;

-- 3.2
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;

SELECT @@transaction_isolation;

START TRANSACTION;
SELECT * FROM tbl1 WHERE id >= 1 AND id <=5 ;
UPDATE tbl1 SET text = CONCAT(text, '*')  WHERE id = 3;
SELECT * FROM tbl1 WHERE id >= 1 AND id <=5 ;
COMMIT;

-- 4.1
SET TRANSACTION ISOLATION LEVEL REPEATABLE READ;

SELECT @@transaction_isolation;

START TRANSACTION;
SELECT * FROM tbl1;
insert into tbl2 (id, text) select id, text from tbl1;
SELECT * FROM tbl2;
COMMIT;
SELECT * FROM tbl1;


-- 4.2
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE ;

SELECT @@transaction_isolation;

START TRANSACTION;
SELECT * FROM tbl1;
insert into tbl2 (id, text) select id, text from tbl1;
SELECT * FROM tbl2;
COMMIT;
SELECT * FROM tbl1;