-- 2. Выведите таблицу из 2-х столбцов: номер категории и количество продуктов в каждой категории.
select categoryid as "Номер категории", count(productid) as "количество продуктов" -- в даной категории
from "Production"."Products"
group by categoryid
order by categoryid;

-- ЗАМЕЧАНИЕ:
-- Вместо count(productid) лучше писать count(*), так запрос проще читается другими разработчиками.
select categoryid as "Номер категории", count(*) as "количество продуктов" -- в даной категории
from "Production"."Products"
group by categoryid
order by categoryid;