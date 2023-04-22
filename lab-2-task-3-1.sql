-- 3.1. Напишите запрос, возвращающий набор уникальных записей из таблиц Employees и Customers.
-- Результирующая таблица должна содержать 3 столбца: country, region, city. 
select distinct country, region, city
from (
	select country, region, city
	from "HR"."Employees"
	union
	select country, region, city
	from "Sales"."Customers"
) as block;

-- 3.1) Вложенный запрос не нужен, сделайте без него.
select distinct country, region, city
from "HR"."Employees"
	union
		select country, region, city
		from "Sales"."Customers";