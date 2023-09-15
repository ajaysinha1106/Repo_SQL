select * from Orders
================================================================================================================================
select order_id, sum(sales) as order_sales 
from Orders
group by order_id
having sum(sales) > (select avg(order_sales) from (select order_id,sum(sales) as order_sales from Orders group by order_id)A) 

--------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------
select e.*,d.dep_avg_sal
from employee e
join 
(select dept_id,avg(salary) as dep_avg_sal from employee
group by dept_id) d
on e.dept_id = d.dept_id
where e.salary > d.dep_avg_sal

--------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------

--Common Table Expression--



