--1- write a query to find premium customers from orders data. Premium customers are 
--those who have done more orders than average no of orders per customer.

select * from orders

with cte_1 as
(select customer_id ,count(order_id) as Order_per_Customer
from Orders
group by customer_id)
select * from 
cte_1
where Order_per_Customer > (select avg(Order_per_Customer) as avg_order from cte_1)


--2- write a query to find employees whose salary is more than average salary of employees in their department

select * from employee

employee => salary > avg(salary) as dept_wise

select e.* from employee e
join
(select dept_id, avg(salary) as salary_dept_wise
from employee
group by dept_id) d
on e.dept_id = d.dept_id
where e.salary > salary_dept_wise


--3- write a query to find employees whose age is more than average age of all the employees.

select * from employee e
where
emp_age > (select avg(emp_age) as avg_age from employee) 


--4- write a query to print emp name, salary and dep id of highest salaried employee in each department 

select e.emp_name, e.salary, e.dept_id from employee e
join
(select dept_id, max(salary) as highest_salary from employee
group by dept_id) d
on e.dept_id = d.dept_id
where e.salary = highest_salary;


--5- write a query to print emp name, salary and dep id of highest salaried overall

select * from employee 
where salary = 
(
select max(salary) as highest_salary_overall from employee
)

--6- write a query to print product id and total sales of highest selling products (by no of units sold) in each category


select category,product_id ,sum(quantity) as Quantity_sold ,sum(sales) as total_sales from Orders
group by category, product_id
order by Quantity_sold desc ---- confused
;

with product_quantity as (
select category,product_id,sum(quantity) as total_quantity
from orders 
group by category,product_id)
,cat_max_quantity as (
select category,max(total_quantity) as max_quantity from product_quantity 
group by category
)
select *
from product_quantity pq
inner join cat_max_quantity cmq on pq.category=cmq.category
where pq.total_quantity  = cmq.max_quantity




