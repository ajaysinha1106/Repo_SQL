--1- write a query to get region wise count of return orders

select * from Orders
select * from returns

select o.region, count(return_reason) as No_of_count_regionWise
from Orders o
join returns r
on o.order_id = r.order_id
group by o.region

--2- write a query to get category wise sales of orders that were not returned

 select o.category, sum(sales) as Sales_Orders
 from Orders o
 left join returns r on o.order_id = r.order_id
 where return_reason is null
 group by category

 --3- write a query to print dep name and average salary of employees in that dep .

 select * from employee;
 select * from dept;

 select d.dep_name, avg(e.salary) as Average_Salary
 from employee e join
 dept d on e.dept_id = d.dep_id
 group by d.dep_name

 --4- write a query to print dep names where none of the emplyoees have same salary.

 select d.dep_name, count(distinct salary) as d_sal, 
 count(salary) as sal
 from employee e full outer join dept d
 on e.dept_id = d.dep_id
 group by d.dep_name
 having count(distinct salary) = count(salary)
 
 --5- write a query to print sub categories where we have all 3 kinds of returns (others,bad quality,wrong items)

 select o.sub_category, r.return_reason  from Orders o join returns r
 on o.order_id = r.order_id 
 where return_reason in ('Wrong Items', 'Bad Quality','Others')
 group by sub_category, return_reason;

 --6- write a query to find cities where not even a single order was returned.

select o.city, count(r.return_reason)
from Orders o
left join returns r 
on o.order_id = r.order_id
group by o.city
having count(r.return_reason)=0

--7- write a query to find top 3 subcategories by sales of returned orders in east region

select top 3 o.sub_category, max(sales) as Maximum_Sales from Orders o 
join returns r 
on o.order_id = r.order_id
where region = 'East'
group by o.sub_category
order by Maximum_Sales desc

--8- write a query to print dep name for which there is no employee

select * from employee;
select * from dept;

select d.dep_name, e.emp_name from employee e
right join dept d
on e.dept_id = d.dep_id
where e.emp_name is null

--9- write a query to print employees name where dep id is not avaiable in dept table

select e.emp_name, d.dep_id from employee e
left join dept d 
on e.dept_id = d.dep_id
where d.dep_id is null

--10-write a query to print emp name , their manager name and diffrence in their age for employees whose age is 
--   less then their manager's age 

select e.emp_name as Employee_Name, m.emp_name as Manager_Name, 
e.emp_age as Employee_Age, m.emp_age as Manager_Age
from
employee e join employee m
on e.manager_id = m.emp_id
where e.emp_age < m.emp_age

--11-write a query to print emp name, manager name and senior manager name (senior manager is manager's manager)

select e.emp_name as Employee_Name, m.emp_name as Manager_Name, sm.emp_name as Senior_Manager_Name
from
employee e join employee m
on e.manager_id = m.emp_id
join employee sm
on m.manager_id = sm.emp_id
