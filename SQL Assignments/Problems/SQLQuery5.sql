create table LOG_TABLE
(
ID int, 
[Date] date,
FLAG int
)

insert into LOG_TABLE
(ID, [Date], FLAG)
values 
(1,'2019-01-01',NULL),
(1,'2019-01-02',NULL),
(1,'2019-01-03',NULL),
(1,'2019-01-04',1),
(1,'2019-01-05',NULL),
(1,'2019-01-06',NULL),
(1,'2019-01-07',1),
(2,'2019-01-02',1),
(2,'2019-01-03',NULL),
(2,'2019-01-04',1),
(2,'2019-01-05',NULL),
(2,'2019-01-06',NULL)



select * from LOG_TABLE;

with cte as 
(
select *, case when flag is null then row_number() over(order by date,id) else null end as rnk
,row_number() over(partition by id,(case when flag is null then 1 else 0 end) order by [date]) as rnk1
from LOG_TABLE)

select * , case when flag is null then ROW_NUMBER()over(partition by id, rnk-rnk1 order by id, [date]) else
null end as wow
from cte
order by id, [date]



select 
*, case when flag is null then dense_rank() over(order by id, date) 
else null end as rw_n1, ROW_NUMBER()over(order by id, date) as new_id
,
from LOG_TABLE


WITH DataWithFlag AS (
    SELECT
        *,
        CASE
            WHEN FLAG IS NULL THEN 1  -- Reset counter for NULL values
            ELSE NULL
        END AS FlagReset
    FROM LOG_TABLE
)

SELECT
    *,
    SUM(FlagReset) OVER (ORDER BY id,Date) AS RunningNumber
FROM DataWithFlag;
