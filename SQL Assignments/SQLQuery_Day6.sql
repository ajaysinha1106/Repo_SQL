select * from employee

--1- write a query to print emp name , their manager name and diffrence in their age (in days) 
--for employees whose year of birth is before their managers year of birth


select e.emp_name as Employee_Name, m.emp_name as Manager_Name
,DATEDIFF(day, e.dob, m.dob) as day_diff
from
employee e join employee m 
on e.manager_id = m.emp_id
where DATEPART(YEAR,e.dob) < DATEPART(YEAR, m.dob)



--2- write a query to find subcategories who never had any return orders in the month of november (irrespective of years)

select o.sub_category
from
Orders o left join returns r 
on o.order_id = r.order_id
where datepart(month,order_date) = 11
group by o.sub_category
having count(r.return_reason) = 0


--3- orders table can have multiple rows for a particular order_id when customers buys more than 1 product in an order.
--write a query to find order ids where there is only 1 product bought by the customer.
select * from Orders

select order_id
from 
Orders
group by order_id
having count(*) = 1


--4- write a query to print manager names along with the comma separated list
--of all employees directly reporting to him.

select m.emp_name , STRING_AGG(e.emp_name, ',') within group (order by e.salary) as Employee_List
from employee e join
employee m on
e.manager_id = m.emp_id
group by m.emp_name


--5- write a query to get number of business days between order_date and ship_date (exclude weekends). 
--Assume that all order date and ship date are on weekdays only

select order_id, order_date,ship_date,
datediff(day,order_date,ship_date)-2*(DATEPART(week,ship_date) - datepart(week,order_date)) as Day_difference
from Orders;

--6- write a query to print 3 columns : category, total_sales and (total sales of returned orders)

select o.category,sum(o.sales) as total_sales,
sum(case when r.order_id is not null then sales end) as total_sales_of_returned_orders
from orders o
left join returns r
on o.order_id = r.order_id
group by category


--7- write a query to print below 3 columns
--category, total_sales_2019(sales in year 2019), total_sales_2020(sales in year 2020)

select category, sum(case when datepart(year,order_date) = 2019 then sales end) as total_sales_2019,
sum(case when datepart(year,order_date) =2020 then sales end) as total_sales_2020
from Orders
group by category

--8- write a query print top 5 cities in west region by average no of days between order date and ship date.

select top 5 city , avg(datediff(day,order_date,ship_date)) as average_days
from Orders
where region = 'west'
group by city
order by average_days desc

--9- write a query to print customer name and no of occurence of character 'n' in the customer name.
--customer_name , count_of_occurence_of_n

select customer_name,(len(customer_name)-len(replace(customer_name,'n',''))) as count_of_occurence_of_n
from Orders

--10- write a query to print first name and last name of a customer using orders table
--(everything after first space can be considered as last name)
--customer_name, first_name,last_name

select customer_name,
substring(customer_name,1,charIndex('X',replace(customer_name,' ','X'))) as First_Name
,substring(customer_name,charIndex('X',replace(customer_name,' ','X')),len(customer_name)) as Last_Name
from Orders







select customer_name , trim(SUBSTRING(customer_name,1,CHARINDEX(' ',customer_name))) as first_name
, SUBSTRING(customer_name,CHARINDEX(' ',customer_name)+1,len(customer_name)-CHARINDEX(' ',customer_name)+1) as second_name
from orders
