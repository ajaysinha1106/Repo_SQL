create table Company_table
(
emp_id int,
emp_name varchar(20),
salary int,
manager_id int,
emp_age int,
dep_id int,
dep_name varchar(20),
gender varchar(10)
);

insert into Company_table
(emp_id ,emp_name,salary,manager_id,emp_age,dep_id,dep_name,gender)
values 
(1,'Ankit',14300,4,39,100,'Analytics','Female'),
(2,'Mohit',14000,5,48,200,'IT','Male'),
(3,'Vikas',12100,4,37,100,'Analytics','Female'),
(4,'Rohit',7260,2,16,100,'Analytics','Female'),
(5,'Mudit',15000,6,55,200,'IT','Male'),
(6,'Agam',15600,2,14,200,'IT','Male'),
(7,'Sanjay',12000,2,13,200,'IT','Male'),
(8,'Ashish',7200,2,12,200,'IT','Male'),
(9,'Mukesh',7000,6,51,300,'HR','Male'),
(10,'Rakesh',8000,6,50,300,'HR','Male'),
(11,'Akhil',4000,1,31,500,'Ops','Male');

Write a query to find 3rd highest salary employee in each department, In case there are less than 3 empployee in each
 department then return employee with lowest salary in that department.
select * from Company_table;


with cte1 as
(
select *,RANK() over(partition by dep_id order by salary desc) as rnk
from Company_table
)
,cte2 as
(
select *,count(*) over(partition by dep_id) as cnt 
from cte1
)
select * 
from cte2
where rnk= 3 or
(cnt<3 and rnk=cnt)
