use lol;
insert main values(1,'Азір',0,0,0,0,0,0,0,0,5,0);
insert main values(2,'Акалі',0,0,0,0,0,0,0,0,0,0);
insert main values(3,'Алістар',0,0,0,0,0,0,0,0,4,0);
insert main values(4,'Амуму',0,0,0,0,0,0,0,0,0,0);
insert main values(5,'Анівія',0,0,0,0,0,0,0,0,1,0);
insert main values(6,'Арі',0,0,0,0,0,0,0,0,0,0);
insert main values(7,'Атрокс',0,0,0,0,0,0,0,0,0,0);
insert main values(8,'Ауреліон Сол',0,0,0,0,0,0,0,0,0,0);
insert main values(9,'Афелій',0,0,0,0,0,0,0,0,0,0);
insert main values(10,'Бард',0,0,0,0,0,0,0,0,0,0);
insert main values(11,'Блицкранк',0,0,0,0,0,0,0,0,0,0);
insert main values(12,'Браум',0,0,0,0,0,0,0,0,0,0);
insert main values(13,'Бренд',0,0,0,0,0,0,0,0,0,0);
insert main values(14,'Вай',0,0,0,0,0,0,0,0,0,0);
insert main values(15,'Варвік',0,0,0,0,0,0,0,0,0,0);
insert main values(16,'Варус',0,0,0,0,0,0,0,0,0,0);
insert main values(17,'Вейгар',0,0,0,0,0,0,0,0,0,0);
insert main values(18,'Вейн',0,0,0,0,0,0,0,0,0,0);
insert main values(19,'ВелКоз',0,0,0,0,0,0,0,0,0,0);
insert main values(20,'Виктор',0,0,0,0,0,0,0,0,0,0);
insert main values(21,'Владимир',0,0,0,0,0,0,0,0,0,0);
insert main values(22,'Волибир',0,0,0,0,0,0,0,0,0,0);
insert main values(23,'Вуконг',0,0,0,0,0,0,0,0,0,0);
insert main values(24,'Галио',0,0,0,0,0,0,0,0,0,0);
insert main values(25,'Гангпланг',0,0,0,0,0,0,0,0,0,0);
insert main values(26,'Гарен',0,0,0,0,0,0,0,0,0,0);
insert main values(27,'Гекарим',0,0,0,0,0,0,0,0,0,0);
insert main values(28,'Гнар',0,0,0,0,0,0,0,0,0,0);
insert main values(29,'Грагас',0,0,0,0,0,0,0,0,0,0);
insert main values(30,'Грейвс',0,0,0,0,0,0,0,0,0,0);
insert main values(31,'Дариус',0,0,0,0,0,0,0,0,0,0);
insert main values(32,'Джакс',0,0,0,0,0,0,0,0,0,0);
insert main values(33,'Джарван VI',0,0,0,0,0,0,0,0,0,0);
insert main values(34,'Джейс',0,0,0,0,0,0,0,0,0,0);
insert main values(35,'Джин',0,0,0,0,0,0,0,0,0,0);
insert main values(36,'Джинкс',0,0,0,0,0,0,0,0,0,0);
insert main values(37,'Диана',0,0,0,0,0,0,0,0,0,0);
insert main values(38,'Доктор Мундо',0,0,0,0,0,0,0,0,0,0);
insert main values(39,'Дрейвен',0,0,0,0,0,0,0,0,0,0);
insert main values(40,'Ёне',0,0,0,0,0,0,0,0,0,0);

/*
-- select * from main;
-- delete from main
-- where id>0;

 select * from main;
*/
-- DROP DATABASE lol;
update main 
set sum = 15  
where name = 'Akali' AND id>0;
/*
select name, mean from main
	join main as m
on main.mean=max(m.mean);

SELECT name, mean FROM main
  where mean=@m;
set @a:=0;
select max(mean)
into @a
from main;
select name from main
where main.mean=@a;
*/