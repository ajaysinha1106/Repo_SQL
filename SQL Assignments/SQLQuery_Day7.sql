select * from icc_world_cup;

--1 write a query to produce below output from icc_world_cup table.
--team_name, no_of_matches_played , no_of_wins , no_of_losses

india, 2, 2,0
SL, 2,0,2
SA,1,1,1,


select Team ,count(*) as no_of_matches_played
, sum(Win_Flag) as no_of_wins, count(*) - sum(Win_flag) as no_of_losses
,sum(case when Win_flag =0 then 1 else 0 end) as no_of_losses
from 
(select Team_1 as Team , case when Team_1 = Winner then 1 else 0 end as Win_flag
from icc_world_cup
union all
select Team_2 as Team , case when Team_2 = Winner then 1 else 0 end as Win_flag
from icc_world_cup) A
group by team


select * from drivers;

/*write a query to print below output using drivers table. Profit rides are the no of rides where end location 
of a ride is same as start location of immediate next ride for a driver
id, total_rides , profit_rides
dri_1,5,1
dri_2,2,0 */

select d1.id , count(d1.id) as total_rides
,sum(case when d1.end_time = d2.start_time then 1 else 0 end) as Profit_rides
,count(d2.id) as Profit_rides
from drivers d1 
left join drivers d2
on d1.id = d2.id and d1.end_loc = d2.start_loc and d1.end_time = d2.start_time
group by d1.id

/*
3-write a query to print below output from orders data. example output
hierarchy type,hierarchy name ,total_sales_in_west_region,total_sales_in_east_region
category , Technology, ,
category, Furniture, ,
category, Office Supplies, ,
sub_category, Art , ,
sub_category, Furnishings, ,
--and so on all the category ,subcategory and ship_mode hierarchies 
*/

select * from orders

select 'category' as hierarchy_type , category as hierarchy_name
, sum(case when region = 'west' then sales end) as total_sales_in_west_region
, sum(case when region = 'east' then sales end) as total_sales_in_east_region
from Orders
group by category
union all
select 'sub_category' as sub_category_Name, sub_category 
,sum(case when region='West' then sales end) as total_sales_in_west_region
,sum(case when region='East' then sales end) as total_sales_in_east_region
from orders
group by sub_category
union all 
select 
'ship_mode ',ship_mode 
,sum(case when region='West' then sales end) as total_sales_in_west_region
,sum(case when region='East' then sales end) as total_sales_in_east_region
from orders
group by ship_mode 










