-- 3. Выведите данные о количестве заказов, оформленных каждым сотрудником
select  empid as "Номер сотрудника" , count(orderid) as "количество заказов"
from "Sales"."Orders"
group by empid
order by empid;

-- ЗАМЕЧАНИЕ:
-- 4.3) Вместо count(orderid) лучше писать count(*) по той же причине, что и выше.
select  empid as "Номер сотрудника" , count(*) as "количество заказов"
from "Sales"."Orders"
group by empid
order by empid;