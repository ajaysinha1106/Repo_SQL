--data aggregation
select count(*) as no_of_records  from orders

select sum(sales) as total_sales from orders

select max(sales) as max_sales from orders

select min(sales) as min_sales from orders

select avg(sales) as avg_sales from orders

select sum(sales)/count(*) as avg_sales from orders

--group by 
select category,sum(sales) as category_sales
from orders
group by category
;
select region,sum(sales) as region_sales,avg(sales) as region_avg
from orders
group by region


select category,sub_category,sum(sales) as category_sales
from orders
group by category,sub_category
order by category,sub_category


select category,region,sum(sales) as sales
from orders
group by category,region
order by category,region

select category,sub_category,region,sum(sales) as sales
from orders
group by category,sub_category,region
order by category,sub_category,region


select category,sum(sales) as category_sales
from orders
where region='West'
group by category
order by category_sales
;
/*category		category_sales
Office Supplies	719047.032
Furniture		741999.795299999
Technology		836154.032999997
*/

from
where
group by
having
select
order by
top;

select region,sum(sales) as region_sales,avg(sales) as region_avg,max(sales) as max_sales
from orders
group by region
having max(sales) < 15000 and sum(sales) > 700000



select region,sum(sales) as region_sales,avg(sales) as region_avg,max(sales) as max_sales
from orders
group by region
having max_sales < 15000 

--391721.905
sum(sales)>400,000

select category,region,sum(sales) as region_sales
from orders
group by category


select category,region,sum(sales) as region_sales
from orders
group by category,region
order by category

order_id,category, order_date, sales
1,furniture, '2023-01-01'
1,furniture, '2023-04-01'
1,technology, '2023-02-01'
1,technology, '2023-03-01'

select category ,max(order_date) latest_order_date
from orders
group by category
having max(order_date)>'2020-03-01'

select category 
from orders
where order_date > '2020-03-01'
group by category

select distinct category,region
from orders
order by category,region

select category ,region
from orders
group by category, region
order by category,region

--group by category
--having max(order_date)>'2023-03-01'

select count(*)
,count(order_id)
,count(postal_code)
,avg(sales)
,count(distinct order_id) total_distinct_orders
from orders

category, sales
furniture, 100
furniture, 200
furniture, 0
300/3
where sales>0
select category ,count(order_id) as cnt,count(distinct order_id) as no_of_orders
from orders
group by category
300/2;

select * from orders
furniture, west , 100 
furniture, west , null 
furniture, west , null 
furniture, east , 0 


furniture, west , 100 
furniture, east , 0 

select category , max(region) as m_region
from orders
where region like 'W%'
group by category
having max(region) like 'W%'

order_id, category , sales
1 , furniture, 100
1 , furniture, 200
1 , furniture, 300
1 , technology, 100
1 , technology, 300
1 , technology, 500

select category,sum(sales)
from orders
--where sales < 400
group by category
furnitute,600
technology,900

select category,min(sales),avg(sales),max(sales)
from orders
--where sales < 400
group by category
having sum(sales)=300

select category,max(sales)
from orders
group by category
having max(sales)=300
--order by 1
furniture,300
technology,500

select order_id,category,segment 
from orders
where category='Furniture' and segment='Corporate'








