--with cte1 as
--(
--select *, row_number()over(order by (select null)) as rw_nm from Products_Table
--)
--, cte2 as
--select * from cte1

===============================================================================================================
-------------------------------Question asked in Instagram-----------------------------------------------------
===============================================================================================================
--select * from input_table;

with cte as 
(
select SUBSTRING(Names,1,CHARINDEX(' ', Names)) as First_Name,
substring(Names,charindex(' ',Names)+1,len(Names)) as Last_Name
from input_table
)
select upper(SUBSTRING(First_Name,1,1)) + lower(SUBSTRING(First_Name,2,len(First_Name))) as First_Name
,upper(SUBSTRING(Last_Name,1,1)) + lower(SUBSTRING(Last_Name,2,len(Last_Name))) as Last_Name
from cte

==================================================================================================================
---- Foreign Key------------
create table emp_c
(
emp_id int,
salary int,
dept_id int foreign key references dept_c(dep_id)
);

create table dept_c
(
dep_id int primary KEY 
);

===============================================================================================================
--write a user defined functions  which takes 2 input parameters of DATE data type. 
The function should return no of business days between the 2 dates.
note -> if any of the 2 input dates are falling on saturday or sunday then function should use immediate Monday 
date for calculation

example if we pass dates as 2022-12-18 and 2022-12-24..then it should calculate business days 
between 2022-12-19 and 2022-12-26

create function func_bus_day (@a date, @b date)
returns int
begin
return (select )
end

select datediff(day,order_date,ship_date)  
from orders

select datename(dw,getdate()-3)

=========================================================================================================================

with cte as 
(
select 1 as id 
union all
select id+1 as id 
from cte
where id+1 <= 11
)
select * from cte

=========================================================================================================================

create proc sp_emp
as
declare @cnt int
begin
select @cnt = count(*) from employee;
if @cnt <10 
print 'Number of employee is less than 10'
else
print 'Number of emplyee is greater or equal to 10'
end


create proc sp_emp1 (@dept_id int)
as
declare @cnt int
begin
select @cnt = count(*) from employee
where dept_id = @dept_id

if @cnt>0
print 'Number ' + cast(@cnt as varchar(10))
else
print'no'
end

sp_emp1 400