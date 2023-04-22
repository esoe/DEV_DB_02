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
order by pure.entity asc;
-- ЗАМЕЧАНИЕ
-- 4.6) Запрос можно сделать с меньшей вложенностью. Исправьте.
select orders.orderid, sum(unitprice*qty*(1 - discount)) as orderprice
from "Sales"."Orders" as orders
	left join "Sales"."OrderDetails" as details 
	on orders.orderid = details.orderid
group by orders.orderid
having sum(unitprice*qty*(1 - discount)) > 1000::money
order by orderprice asc;


