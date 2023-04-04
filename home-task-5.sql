-- 5.	Выведите самые дорогие продукты в каждой категории. Детали должны присутствовать!
select productid, productname, supplierid, categoryid, unitprice, discontinued
from(
	select * 
	from (
		select categoryid as cid, max(unitprice) as max_in_cat
		from "Production"."Products"
		group by cid
		order by cid 
		) as cats
		left join "Production"."Products" as products
			on (cats.cid=products.categoryid) and (cats.max_in_cat=products.unitprice)
	) as grouped
order by productid;