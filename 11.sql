-- 1
DROP TABLE IF EXISTS CreditDetails;
DROP TABLE IF EXISTS Credit;
CREATE TABLE Credit (
  Id int NOT NULL,
  LastName nvarchar(20) NOT NULL,
  FirstName nvarchar(10) NOT NULL,
  CreditTitle nvarchar(30) NOT NULL
);
CREATE TABLE CreditDetails(
  Id int NOT NULL,
  CreditId int NOT NULL,
  PaymentDate date NOT NULL,
  Amount int
);
INSERT INTO Credit (Id, LastName, FirstName, CreditTitle) VALUES
  (1, 'Afniy', 'Andriy', 'Credit Title 1'),
    (2, 'Gorin', 'Sam', 'Credit Title 2'),
    (3, 'Werih', 'Dan', 'Credit Title 3');
INSERT INTO CreditDetails (Id, CreditId, PaymentDate, Amount) VALUES
  (1, 1, DATE('2020-07-11'), 1000),
    (2, 1, DATE('2019-02-21'), 2500),
    (3, 1, DATE('2018-01-04'), 2000),
  (4, 2, DATE('2020-02-05'), 300),
    (5, 2, DATE('2015-03-04'), 60050);

select CreditId, FirstName, LastName, PaymentDate, Amount, SUM(Amount) over(order by cd.Id) as TotalAmount from Credit c
join CreditDetails cd on c.Id=cd.CreditId;
-- 2
DROP TABLE IF EXISTS Student;
CREATE TABLE Student(
Id int NOT NULL,
LastName nvarchar(20) NOT NULL,
FirstName nvarchar(10) NOT NULL,
GroupName nvarchar(10) NOT NULL 
);
INSERT INTO Student VALUES
  (1, 'Ann', 'Al','IPZ-21'),
    (2, 'Bervil', 'Alex','IPZ-22'),
    (3, 'Dan', 'Li','IPZ-22'),
  (4, 'Den', 'Luck','IPZ-22'),
    (5, 'Sel', 'Dan','IPZ-22'),
    (6, 'So', 'John','IPZ-22'); -- група, в якій навчається студент ІПЗ11, ІПЗ12...
    
SELECT ROW_NUMBER() OVER() AS Num, LastName, FirstName, concat(GroupName,'.',Id) AS ID
    FROM Student;


-- 3
DROP TABLE IF EXISTS ExchangeRate;
CREATE TABLE ExchangeRate(

Id int NOT NULL,
CurrencyName nchar(3), -- USD, EUR, RUB
`Date` date NOT NULL,
Rate float NOT NULL
);

Insert into ExchangeRate values
(1,'USD','2020-06-02',22.5),
(2,'USD','2020-06-13',25.3),
(3,'USD','2020-07-08',22.5),
(4,'UAH','2020-04-14',1),
(5,'UAH','2020-07-02',24.21),
(6,'EUR','2020-06-02',24.21),
(7,'EUR','2020-06-20',25.25);

Select CurrencyName,`Date`,Rate,
  sum(Rate) over(Partition by CurrencyName order by `Date` 
    rows between 1 preceding and 1 preceding) as `PrevRate`, 
    sum(Rate) over(Partition by CurrencyName order by `Date` 
    rows between 1 following and 1 following) as `NextRate`
    From ExchangeRate;
    
-- 4
DROP TABLE IF EXISTS ExchangeRate;
set SQL_SAFE_UPDATES = 0;
CREATE TABLE ExchangeRate(
Id int NOT NULL,
CurrencyName nchar(3), -- USD, EUR, RUB
`Date` date NOT NULL,
Rate float NOT NULL
);

Insert into ExchangeRate values
(1,'USD','2020-06-02',22.5),
(2,'USD','2020-06-13',25.3),
(3,'USD','2020-07-08',22.5),
(4,'UAH','2020-04-14',1),
(5,'UAH','2020-07-02',24.21),
(6,'EUR','2020-06-02',24.21),
(7,'EUR','2020-06-20',25.25);

    

SELECT CurrencyName, Date, Rate, 
  (SELECT Rate FROM ExchangeRate
  WHERE CurrencyName = e.CurrencyName AND Date < e.Date limit 1) AS PrevRate,
    (SELECT Rate FROM ExchangeRate
  WHERE CurrencyName = e.CurrencyName AND Date > e.Date limit 1) AS NextRate
FROM ExchangeRate e  ;