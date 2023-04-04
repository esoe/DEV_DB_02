-- Выведите информацию о заказах клиента, который был зарегистрирован в БД последним.
select custid, orderid, orderdate
from "Sales"."Orders"
where custid = (select max(custid) from "Sales"."Customers");

-- Выведите следующие данные по клиентам, которые сделали заказ в самую последнюю дату
-- companyname, contactname, contacttitle, address, city, region, postalcode
select companyname, contactname, contacttitle, address, city, region, postalcode
from "Sales"."Orders" as so inner join "Sales"."Customers" as sc  
	on sc.custid = so.custid
where orderdate = (select max(orderdate) from "Sales"."Orders");

-- Выведите список клиентов, которые не делали заказов
-- данные полей: custid, companyname, contactname, address, city
select customers.custid, companyname, contactname, address, city
from "Sales"."Customers" as customers 
	left join "Sales"."Orders" as orders
		on customers.custid = orders.custid
where orderid is null;

-- Выведите список заказов тех клиентов, которые проживают в Mexico
-- данные полей: custid, orderid, orderdate, shipcountry
select  custid, orderid, orderdate, shipcountry
from "Sales"."Orders"
where shipcountry~*'mex';

-- Выведите самые дорогие продукты в каждой категории. Детали должны присутствовать!
-- productid, productname, supplierid, categoryid, unitprice, discontinued
select * from "Production"."Categories";
select
	categoryid
	, max(unitprice) as "unitprice"
--	, productid
--	, productname
--	, supplierid
--	, discontinued
from "Production"."Products"
group by
	categoryid
--	, unitprice
--	, productid
--	, productname
--	, supplierid
--	, discontinued
order by
	categoryid;





