-- Задание 2. Написание запросов к нескольким таблицам
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
	
-- Замечание:
--  shipname — это имя получателя заказа. Название ...
select orderid as "Номер заказа"
	, companyname as "Название заказчика"
	, contactname as "Фамилия сотрудника (компании заказчика)"
	, orderdate as "Дата заказа"
	, (select companyname
		from "Sales"."Shippers" as shippers
		where shippers.shipperid = orders.shipperid) as "Название транспортной компании"
	--, companyname as "Название транспортной компании"
from "Sales"."Orders" as orders 
	left join "Sales"."Customers" as customers on orders.custid = customers.custid
where customers.city = (
	select city
	from "HR"."Employees" as employees
	where employees.empid = orders.empid);