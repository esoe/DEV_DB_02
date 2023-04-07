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

-- Замечание:
-- Вложенный запрос здесь лишний, сделайте без него.
select concat(lastname, ', ', firstname) as "ФИО сотрудника"
	, orderid as "Номер заказа"
	, orderdate as "Дата заказа"
from ("Sales"."Orders" as orders 
	inner join "HR"."Employees" as employees 
	on orders.empid = employees.empid) as pure
order by orderdate;