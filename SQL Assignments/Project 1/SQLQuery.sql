select * from credit_card_transcations;

--1- write a query to print top 5 cities with highest spends and their percentage contribution of total credit card spends 

with total_spent_cte as (select sum(cast(amount as bigint)) as total_spent from credit_card_transcations)
select top 5 city,sum(amount) as expense,total_spent,cast((sum(amount)*1.0 /total_spent) * 100 as decimal(5,2)) 
as percentage_contribution
from credit_card_transcations, total_spent_cte
group by city,total_spent
order by expense desc;

select top 5 city,sum(amount) as expense
from credit_card_transcations
group by city
order by expense desc
--2- write a query to print highest spend month and amount spent in that month for each card type

with cte1 as 
(
select  card_type,
datepart(year,transaction_date) as yo, datename(month,transaction_date) as mo 
, sum(amount) as monthly_expense
from credit_card_transcations
group by card_type,datepart(year,transaction_date), datename(month,transaction_date)
),
cte2 as
(
select * , rank() over(partition by card_type order by monthly_expense desc) as rnk
from cte1
)
select * from cte2
where rnk = 1

--3- write a query to print the transaction details(all columns from the table) for each card type when
--it reaches a cumulative of 1000000 total spends(We should have 4 rows in the o/p one for each card type)

with cte1 as(
select *, sum(amount) over(partition by card_type order by card_type, transaction_date, transaction_id) as cumm_sum
from credit_card_transcations
)
, cte2 as
(
select *, rank() over(partition by card_type order by cumm_sum asc) as rnk from cte1
where cumm_sum >=1000000
)
select * from cte2
where rnk = 1


--4- write a query to find city which had lowest percentage spend for gold card type

with cte1 as
(
select  city,sum(amount) as total_expense 
, sum(case when card_type='Gold' then amount else 0 end) as gold_expense
from credit_card_transcations
group by city
having sum(case when card_type='Gold' then amount else 0 end) >0
)
select top 1 * , (gold_expense*1.0/total_expense)*100 as Gold_Contribution
from cte1
order by Gold_Contribution

--5- write a query to print 3 columns:  city, highest_expense_type , lowest_expense_type (example format : Delhi , bills, Fuel)

with cte1 as
(
select city, exp_type, sum(amount) as Total_Sum
from credit_card_transcations
group by city, exp_type
--order by city, exp_type 
)
,cte2 as 
(
select *
,rank() over(partition by city order by Total_Sum desc) as rnk_high
,rank() over(partition by city order by Total_Sum ) as rnk_low

from cte1
)
select city, max(case when rnk_high=1 then exp_type end) as Highest_expense_type
, max(case when rnk_low=1 then exp_type end) as Highest_expense_type
from cte2
where rnk_high =1 or rnk_low =1
group by city

--6- write a query to find percentage contribution of spends by females for each expense type

with cte1 as(
select exp_type, sum(amount) as Total_Expense 
, sum(case when gender = 'F' then amount else 0 end) as Expense_by_Female
from credit_card_transcations
group by exp_type
)
select *, (Expense_by_Female*1.0/Total_Expense)*100 as contribution_By_female from cte1;

--- OR---

with cte1 as(
select exp_type, sum(amount) as total_spent
from credit_card_transcations
group by exp_type
)
,cte2 as(
select exp_type, sum(amount) as female_spent 
from credit_card_transcations
where gender = 'F'
group by exp_type)

select cte1.exp_type, (female_spent*1.0/total_spent)*100 as ContributionByFemale 
from cte1
inner join cte2
on cte1.exp_type = cte2.exp_type 


--7- which card and expense type combination saw highest month over month growth in Jan-2014

with cte1 as
(
select card_type, exp_type,datepart(year,transaction_date) as yo
, datepart(month,transaction_date) as mo ,sum(amount) as Total_sum 
from credit_card_transcations
group by card_type, exp_type, datepart(year,transaction_date)
, datepart(month,transaction_date)
)
, cte2 as(
select *, lag(Total_sum) over(partition by card_type, exp_type order by yo,mo) as Prev_month
from cte1
)
select top 1 *,(Total_sum-Prev_month) as MoMGrowth from cte2
where Prev_month is not null and yo = 2014 and mo=1
order by MoMGrowth desc;

---- OR----

with cte as (
select card_type,exp_type,datepart(year,transaction_date) yt
,datepart(month,transaction_date) mt,sum(amount) as total_spend
from credit_card_transcations
group by card_type,exp_type,datepart(year,transaction_date),datepart(month,transaction_date)
)
select  top 1 *, (total_spend-prev_mont_spend) as mom_growth
from (
select *
,lag(total_spend,1) over(partition by card_type,exp_type order by yt,mt) as prev_mont_spend
from cte) A
where prev_mont_spend is not null and yt=2014 and mt=1
order by mom_growth desc;

--8- during weekends which city has highest total spend to total no of transcations ratio 

select city, sum(amount)/count(transaction_id) as Transaction_Ratio 
from credit_card_transcations
where DATEPART(WEEKDAY,transaction_date) in (1,7)
group by city
order by Transaction_Ratio desc

--9- which city took least number of days to reach its 500th transaction after the first transaction in that city

with cte1 as
(
select *, ROW_NUMBER() over(partition by city order by transaction_date, transaction_id) as rn
from credit_card_transcations
) 
select city, min(transaction_date) as first_transaction, max(transaction_date) as last_transaction
, DATEDIFF(DAY,min(transaction_date),max(transaction_date)) as days_difference
from cte1 
where rn in (1,500)
group by city
having count(*)=2
order by days_difference asc