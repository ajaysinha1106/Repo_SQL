--1- write a query to print 3rd highest salaried employee details for each department .

select * from employee;

with cte_1 as
(
select *, dense_Rank() over(partition by dept_id order by salary desc) as d_rnk
from employee)
select * from cte_1 where d_rnk = 3;

--OR

select * from 
(select *, dense_Rank() over(partition by dept_id order by salary desc) as rn
from employee) a
where rn = 3;

--2- write a query to print 3rd highest salaried employee details for each department 
--(give preferece to younger employee in case of a tie). 
--In case a department has less than 3 employees then print the details of highest salaried employee in that department.

with cte_1 as
(
select *, dense_rank() over(partition by dept_id order by salary desc ) as rn from employee
)
,cte_2 as
(
select dept_id, count(*) as cnt from employee
group by dept_id
)
select * from cte_1
inner join cte_2 on cte_1.dept_id = cte_2.dept_id
where rn = 3 or (rn=1 and cnt<3)

--3- write a query to find top 3 and bottom 3 products by sales in each region.

with cte1 as
(
select region,product_id, sum(sales) as total_sales
from Orders
group by region, product_id
)
, rnk as 
(
select *, rank() over(partition by region order by total_sales desc) as rn_desc
, rank() over(partition by region order by total_sales ) as rn_asc
from cte1
)
select region, product_id, total_sales
,case when rn_desc <=3 then 'Top 3' else 'Bottom 3' end as top_bottom
from rnk
where rn_desc <=3 or rn_asc<=3


--4- Among all the sub categories,which sub category had highest month over month growth by sales in Jan 2020.

with cte1 as
(
select sub_category,product_id,DATEPART(MONTH,order_date) as MoM, sum(sales) as total_sales 
from Orders
where DATEPART(MONTH, order_date) = '12' and DATEPART(YEAR,order_date) = '2019'
or DATEPART(MONTH, order_date) = '01' and DATEPART(YEAR,order_date) = '2020'
group by sub_category,product_id,DATEPART(MONTH,order_date)
)
, cte2 as
(
select *, lead(total_sales,1) over(partition by sub_category order by MoM) as prev_sales from cte1
)
select *, (total_sales-prev_sales)/prev_sales*100.0 as MoM_Growth from cte2 
where MoM =1
order by MoM_Growth desc;


--1	Bookcases	202001	2239.536	2652.2422	-0.155606527940774

with sbc_sales as (
select sub_category,format(order_date,'yyyyMM') as year_month, sum(sales) as sales
from orders
group by sub_category,format(order_date,'yyyyMM')
)
, prev_month_sales as 
(
select *,lag(sales) over(partition by sub_category order by year_month) as prev_sales
from sbc_sales
)
select   * , (sales-prev_sales)/prev_sales as mom_growth
from prev_month_sales
where year_month='202001'
order by mom_growth desc

--5- write a query to print top 3 products in each category by year over year sales growth in year 2020.
---> meaning (first - last )/first

with cte1 as 
(
select category, product_id, DATEPART(YEAR, order_date) as YoY, sum(sales) as total_sales from Orders
where DATEPART(YEAR, order_date) in (2019, 2020)
group by category, product_id, DATEPART(YEAR, order_date)
)
, cte2 as
(
select *, lag(total_sales,1) over(partition by category, product_id order by YoY ) as prev_sales
from cte1
)
, cte3 as
(
select *, (total_sales-prev_sales)/prev_sales as YoY_Growth from cte2
where prev_sales is not null
)
, rnk_tbl as 
(
select *, rank() over(partition by category order by YoY_Growth desc) as rnk from cte3
)
select * from rnk_tbl where rnk <=3;


-- write a query to get start time and end time of each call from above 2 tables.Also create a column 
--of call duration in minutes.  Please do take into account that there will be multiple calls from one 
--phone number and each entry in start table has a corresponding entry in end table.

select s.phone_number,s.rnk,e.end_time,s.start_time, DATEDIFF(MINUTE, s.start_time,e.end_time) as call_duration from 
(select *, ROW_NUMBER() over(partition by phone_number order by start_time) as rnk from call_start_logs) s
inner join
(select *, ROW_NUMBER() over(partition by phone_number order by end_time) as rnk from call_end_logs) e
on s.phone_number = e.phone_number and e.rnk = s.rnk




