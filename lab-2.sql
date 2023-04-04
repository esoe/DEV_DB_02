-- Задание 1. Написание запросов с фильтрацией
-- 1. Выведите заказчиков с кодом (id) 30
select *
from "Sales"."Customers"
where custid=30;

-- 2. Выведите все заказы, сделанные (оформленные) после 10 апреля 2008 года
select *
from "Sales"."Orders"
where orderdate > '2008-04-10'::date;

-- 3. Выведите название и стоимость продуктов, при условии, что стоимость находится в диапазоне от 100 до 250.
select  productname, unitprice
from "Production"."Products"
where unitprice between 100::money and 250::money;
--where (unitprice>100::money) and (unitprice<250::money);

-- 4. Выведите всех заказчиков, проживающих в Париже, Берлине или Мадриде.
select *
from "Sales"."Customers"
where city in ('Paris', 'Berlin', 'Madrid');
-- where (city ~*'^paris') or (city ~*'^berlin') or (city ~*'^madrid');

-- 5. Выведите всех сотрудников, для которых не определен регион проживания
select *
from "HR"."Employees"
where region is null;

-- 6. Выведите заказчиков с именами кроме “Linda”, “Robert”, “Ann”
select *
from "Sales"."Customers"
where (contactname !~'Linda$') or (contactname !~'Robert$') or (contactname !~'Ann$');

-- 7. Выведите заказчиков, чья фамилия начинается либо на букву “B” либо “R” либо “N”.
-- Фильтрация должна производится на исходных данных столбца (не на вычисляемом выражении)
select *
from "Sales"."Customers"
where contactname ~'^[BRN]';
--where (contactname ~'^B') or (contactname ~'^R') or (contactname ~'^N');

-- 8. Выведите информацию о заказчиках, сформировав два вычисляемых столбца:
-- Фамилия заказчика и Имя заказчика. В результирующую выборку должны попасть только те заказчики,
-- чье имя начинается либо на букву "P" либо на букву "M", а фамилия при этом начинается либо на  “S”  либо на  “K”.
-- Фильтрация должна производится на исходных данных столбца (не на вычисляемом выражении)
-- select SPLIT_PART(string, delimiter, position)
select cln as "Фамилия заказчика", cfn as "имя заказчика"
from (
	select SPLIT_PART(contactname, ', ', 1) as cln,
			SPLIT_PART(contactname, ', ', 2) as cfn
	from "Sales"."Customers"
	) as names
where names.cln ~'^[SK]' and names.cfn ~'^[PM]';

-- Задание 2. Написание запросов к нескольким таблицам
-- 1. Сформируйте выборку следующего вида:    ФИО сотрудника, Номер Заказа, Дата Заказа.
-- Отсортируйте выборку по дате (от самых ранних к самым поздним заказам)
select fio as "ФИО сотрудника", orderid as "Номер заказа", orderdate as "Дата заказа"
from (
	select concat(lastname, ', ', firstname) as fio, orderid, orderdate
	from "Sales"."Orders" as orders inner join "HR"."Employees" as employees on orders.empid = employees.empid
	order by orderdate
	) as pure;
-- order by pure.orderdate;

-- 2. Напишите запрос, который выбирает информацию о заказах и их деталях:
-- [orderid], [custid],[empid],[orderdate] ,[productid],[unitprice],[qty],[discount].
-- Сформируйте в этом запросе вычисляемый столбец (LineTotal), который рассчитывает стоимость каждой позиции в заказе с учетом скидки
select orders.orderid, custid, empid, orderdate, productid, unitprice, qty, discount, unitprice*qty*(1-discount) as LineTotal
from "Sales"."Orders" as orders left join "Sales"."OrderDetails" as details on orders.orderid = details.orderid;

-- 3. Напишите запрос, возвращающий выборку следующего вида:
-- Номер заказа, Название заказчика, Фамилия сотрудника (компании заказчика), Дата заказа, Название транспортной компании.
-- В запрос должны войти только те записи, которые соответствуют условию:
-- Заказчики и Сотрудники (Emploees) проживают в одном городе
select orderid as "Номер заказа"
	, companyname as "Название заказчика"
	, contactname as "Фамилия сотрудника (компании заказчика)"
	, orderdate as "Дата заказа"
	, shipname as "Название транспортной компании"
from "Sales"."Orders" as orders 
	left join "Sales"."Customers" as customers on orders.custid = customers.custid
where customers.city = (
	select city
	from "HR"."Employees" as employees
	where employees.empid = orders.empid);

-- Задание 3. Использование операторов наборов записей (UNION, EXCEPT, INTERSECT)
-- 1. Напишите запрос, возвращающий набор уникальных записей из таблиц Employees и Customers.
-- Результирующая таблица должна содержать 3 столбца: country, region, city. 
select distinct country, region, city
from (
	select country, region, city
	from "HR"."Employees"
	union
	select country, region, city
	from "Sales"."Customers"
) as block;
-- order by city;

-- 2. Напишите запрос, возвращающий набор уникальных записей из таблиц Employees (адреса сотрудников - country, region, city),
-- исключив из этого списка записи из таблицы Customers (адреса Клиентов - country, region, city).
-- Результирующая таблица должна содержать 3 столбца: country, region, city. 
select distinct country, region, city
from "HR"."Employees"
except
select country, region, city
from "Sales"."Customers";


-- Задание 4. Запросы с группировкой
-- 1. Выведите таблицу из трех столбцов: максимальная, минимальная и средняя стоимость продуктов.
select max(unitprice::money) as "максимальная", min(unitprice::money) as "минимальная", sum(unitprice::money)/count(unitprice)  as "средняя"
from "Production"."Products";
--select max(unitprice::money) as "максимальная", min(unitprice::money) as "минимальная", avg(unitprice::numeric)  as "средняя"
--from "Production"."Products";
--select max(unitprice::money) as "максимальная", min(unitprice::money) as "минимальная", avg(regexp_replace(unitprice::text, '[$,]', '', 'g')::numeric)  as "средняя"
--from "Production"."Products";

-- 2. Выведите таблицу из 2-х столбцов: номер категории и количество продуктов в каждой категории.
select categoryid as "Номер категории", count(productid) as "количество продуктов" -- в даной категории
from "Production"."Products"
group by categoryid
order by categoryid;

-- 3. Выведите данные о количестве заказов, оформленных каждым сотрудником
select  empid as "Номер сотрудника" , count(orderid) as "количество заказов"
from "Sales"."Orders"
group by empid
order by empid;

-- 4. Выберите 5 самых выгодных заказчиков, с точки зрения суммарной стоимости их заказов
select resurs.custid as "Номер заказчика", sum(resurs.entity) as "Суммарная стоимость заказов"
from (
	(select custid, orderid
		from "Sales"."Orders" as orders
		order by custid
	) as part01
	left join (
		select orderid, sum(unitprice*qty*(1 - discount)) as entity
			from "Sales"."OrderDetails" as details
			group by orderid
			order by orderid
	) as part02 on part01.orderid = part02.orderid
) as resurs
group by resurs.custid
order by "Суммарная стоимость заказов" desc
limit 5;

-- 5. Выведите год, количество сделанных заказов в этом году и количество уникальных заказчиков, которые делали эти заказы.
select extract(year from orderdate) as "год", count(orderid) as "количество заказов", count(distinct custid) as "количество заказчиков"
from "Sales"."Orders"
group by extract(year from orderdate);

-- 6. Выведите список только тех заказов, общая стоимость которых превышает 1000.
select *
from ("Sales"."Orders"
		as orders
	left join (
		select orderid, sum(unitprice*qty*(1 - discount)) as entity
			from "Sales"."OrderDetails"
			group by "Sales"."OrderDetails".orderid
			order by "Sales"."OrderDetails".orderid)
		as details
		on orders.orderid = details.orderid
	) as pure
where pure.entity > 1000::money
order by pure.entity asc ;
