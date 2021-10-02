employeesemployeesUSE isolation;
DROP TABLE IF EXISTS tbl1;
DROP TABLE IF EXISTS tbl2;
CREATE TABLE tbl1(id integer primary key, text varchar(200));
CREATE TABLE tbl2(id integer primary key, text varchar(200));
SET session TRANSACTION ISOLATION LEVEL READ COMMITTED;
set SQL_SAFE_UPDATES = 0;
-- 1.1
SELECT @@transaction_isolation;

START TRANSACTION;
INSERT INTO tbl1 VALUES(1, 'first row'), (2,'second row');
-- DELETE FROM tbl1 WHERE text =  'second row' OR text =  'first row';
SELECT * FROM tbl1;
ROLLBACK;

-- 1.2

START TRANSACTION;
INSERT INTO tbl1 VALUES(1, 'first row'), (2,'second row');
-- DELETE FROM tbl1 WHERE text =  'second row' OR text =  'first row';
SELECT * FROM tbl1;
COMMIT;

-- SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
-- 2.1
SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
SELECT @@transaction_isolation;

START TRANSACTION;
INSERT INTO tbl1 VALUES(3, 'therd row');
SELECT * FROM tbl1;
COMMIT;
-- DELETE FROM tbl1 WHERE text =  'therd row';

-- 2.2
SET TRANSACTION ISOLATION LEVEL REPEATABLE READ;
SELECT @@transaction_isolation;

START TRANSACTION;
INSERT INTO tbl1 VALUES(3, 'therd row');
SELECT * FROM tbl1;
COMMIT;
-- DELETE FROM tbl1 WHERE text =  'therd row';


-- 3.1
SET TRANSACTION ISOLATION LEVEL REPEATABLE READ;
SELECT @@transaction_isolation;

START TRANSACTION;
INSERT INTO tbl1 VALUES(3, 'therd row');
SELECT * FROM tbl1;
COMMIT;
-- DELETE FROM tbl1 WHERE text =  'therd row';

-- 3.2
SET session TRANSACTION ISOLATION LEVEL SERIALIZABLE;
SELECT @@transaction_isolation;

START TRANSACTION;
INSERT INTO tbl1 VALUES(3, 'therd row');
SELECT * FROM tbl1;
COMMIT;
-- DELETE FROM tbl1 WHERE text =  'therd row';

-- 4.1
SET TRANSACTION ISOLATION LEVEL REPEATABLE READ;
SELECT @@transaction_isolation;

START TRANSACTION;
UPDATE tbl1 SET text = 'MODIFIED';
SELECT * FROM tbl1;
COMMIT;

-- 4.2
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;
SELECT @@transaction_isolation;

START TRANSACTION;
UPDATE tbl1 SET text = 'MODIFIED';
SELECT * FROM tbl1;
COMMIT;