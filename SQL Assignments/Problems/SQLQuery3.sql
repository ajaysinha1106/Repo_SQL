SELECT TABLE_NAME 
FROM practice.INFORMATION_SCHEMA.TABLES

select * from Company_table;

select * from Company_table
order by salary desc
offset 2 rows fetch next 3 rows only

select * into new_table from Company_table

select * into no_data from new_table where 1=2

select * from no_data

select * into with_data from new_table where 1=1

select * from with_data


-- Count total number of rows (Records) from a table without using aggregate function (count)

select top(1) * from 
(select row_number() over(order by emp_id) as rnk from Company_table) as A
order by rnk desc

--Write a SQL query to find the running Salary from a table

select *, sum(salary) over(order by emp_id) as Running_Salary from Company_table

-- How to find the number of columns in a particular table

select count(*) as Number_of_Columns from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME = 'Company_table'

-- How to identify all stored procedures reffering a particular table

select * from sys.procedures
where OBJECT_DEFINITION (object_id) like '%Company_Table%'  

-- Write a query to find the total occurance of particular character like 'a' in specific column

select *,len(emp_name)-len(REPLACE(emp_name,'a','')) from company_table;

--Write a Query to find the position of alphabet 'a' in any specific column

select CHARINDEX('a',emp_name,1) from company_table


