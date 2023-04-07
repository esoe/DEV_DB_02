-- Д3.2)
-- Выведите следующие данные по клиентам, которые сделали заказ в самую последнюю дату
-- companyname, contactname, contacttitle, address, city, region, postalcode
select companyname, contactname, contacttitle, address, city, region, postalcode
from "Sales"."Orders" as so inner join "Sales"."Customers" as sc  
	on sc.custid = so.custid
where orderdate = (select max(orderdate) from "Sales"."Orders");

-- Замечание:
-- Если какой-то клиент сделал несколько заказов в требуемую дату, то данные о нём будут дублироваться.
select distinct companyname, contactname, contacttitle, address, city, region, postalcode
from "Sales"."Customers" as costomers inner join "Sales"."Orders" as orders 
	on costomers.custid = orders.custid
where orderdate = (select max(orderdate) from "Sales"."Orders");
-- поменял местами таблицы (нам нужнен в итоге перечень клиентов, а не заказов)
-- добавил distinct, чтобы исключить повторяющиеся записи (к сожалению по выводу не видно изменений)


-- Д3.4)
-- Выведите список заказов тех клиентов, которые проживают в Mexico
-- данные полей: custid, orderid, orderdate, shipcountry
select  custid, orderid, orderdate, shipcountry
from "Sales"."Orders"
where shipcountry~*'mex';

-- Замечание:
-- ДЗ.4) ...
-- перечитал еще раз задачу, в запросе нужно проверить город из таблицы "Sales"."Customers"
-- и если там mex, вывести заказы этого клиента
select  orders.custid, orders.orderid, orders.orderdate, orders.shipcountry
from "Sales"."Orders" as orders
left join "Sales"."Customers" as customers on orders.custid = customers.custid
-- к полному списку заказов подключаем данные о клиентах
where customers.country  ~*'mex';


