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

--ЗАМЕЧАНИЕ:
-- 4.4) Запрос можно сделать с меньшей вложенностью. Исправьте.
select custid as "Номер заказчика"
	, sum(unitprice*qty*(1 - discount)) as "Суммарная стоимость заказов"
from "Sales"."Orders" as orders
	left join "Sales"."OrderDetails" as details
	on orders.orderid = details.orderid
group by custid
order by "Суммарная стоимость заказов" desc
limit 5;

