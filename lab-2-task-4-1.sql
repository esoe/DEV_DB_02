-- 1. Выведите таблицу из трех столбцов: максимальная, минимальная и средняя стоимость продуктов.
select max(unitprice::money) as "максимальная", min(unitprice::money) as "минимальная", sum(unitprice::money)/count(unitprice)  as "средняя"
from "Production"."Products";
--select max(unitprice::money) as "максимальная", min(unitprice::money) as "минимальная", avg(unitprice::numeric)  as "средняя"
--from "Production"."Products";
--select max(unitprice::money) as "максимальная", min(unitprice::money) as "минимальная", avg(regexp_replace(unitprice::text, '[$,]', '', 'g')::numeric)  as "средняя"
--from "Production"."Products";

-- ЗАМЕЧАНИЕ:
-- 4.1) Для вычисления среднего используется специальная агрегатная функция, используйте её.
select max(unitprice::money) as "максимальная"
	, min(unitprice::money) as "минимальная"
	, avg(unitprice::numeric)::money  as "средняя"
from "Production"."Products";