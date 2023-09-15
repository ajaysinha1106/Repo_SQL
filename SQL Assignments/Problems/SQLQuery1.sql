--create table Platform_Table
--(
--user_id int, 
--session_start datetime,
--session_end datetime,
--Platforms varchar(20)
--);

--insert into Platform_Table 
--(user_id, session_start,session_end ,Platforms)
--values

--(0,'2020-08-11 05:51:31.000','2020-08-11 05:54:45.000', 'Twitch'),
--(0,'2020-03-11 03:01:40.000','2020-03-11 03:01:59.000', 'Twitch'),
--(0,'2020-08-11 03:50:45.000','2020-08-11 03:55:59.000', 'Youtube'),
--(1,'2020-11-19 06:24:24.000','2020-11-19 07:24:38.000', 'Youtube'),
--(1,'2020-11-20 06:59:57.000','2020-11-20 07:20:11.000', 'Twitch'),
--(2,'2020-07-11 03:36:54.000','2020-07-11 03:37:08.000', 'OTT'),
--(2,'2020-11-14 03:36:05.000','2020-11-14 03:39:19.000', 'Youtube'),
--(2,'2020-07-11 14:32:19.000','2020-07-11 14:42:33.000', 'Youtube'),
--(3,'2020-11-26 11:41:47.000','2020-11-26 11:52:01.000', 'Twitch'),
--(3,'2020-10-11 22:15:14.000','2020-10-11 22:18:28.000', 'Youtube')



select * from Platform_Table;

-- write a query to get the users who are viewers of both platforms "Twitch" & "Youtube"
-- & have atleast once a minimum watch time of 10 minutes.

select user_id
from Platform_Table
where Platforms in ('Twitch', 'Youtube')
group by user_id
having  count(distinct platforms) = 2
and sum(datediff(MINUTE,session_start,session_end))>=10






