create table people
(id int primary key not null,
name varchar(20),
gender char(2));

create table relations
(
c_id int,
p_id int,
FOREIGN KEY (c_id) REFERENCES people(id),
foreign key (p_id) references people(id)
)

insert into people (id, name, gender)
values
(107,'Days','F'),
(145,'Hawbaker','M'),
(155,'Hansel','F'),
(202,'Blackston','M'),
(227,'Criss','F'),
(278,'Keffer','M'),
(305,'Canty','M'),
(329,'Mozingo','M'),
(425,'Nolf','M'),
(534,'Waugh','M'),
(586,'Tong','M'),
(618,'Dimartino','M'),
(747,'Beane','M'),
(878,'Chatmon','F'),
(904,'Hansard','F')

insert into relations(c_id, p_id)
values
(145, 202),
(145, 107),
(278,305),
(278,155),
(329, 425),
(329,227),
(534,586),
(534,878),
(618,747),
(618,904)

--Write a query that prints the names of a child and his parents in individual 
--columns respectively in order of the name of the child.
/*
The output of the query consists of the given 3 fields:

child
father
mother

Order the result by child in ascending order.

*/
/*
Sample_Output

child	     father   	mother
Dimartino	Beane	    Hansard
Hawbaker	Blackston	Days
Keffer	    Canty	    Hansel
Mozingo	    Nolf	    Criss
Waugh	    Tong	    Chatmon
*/

with cte1 as (
select p.*,r.* 
from people p
inner join relations r
on p.id = r.p_id
union all 
select p.*,r.* 
from people p
inner join relations r
on p.id = r.c_id
)

select 
*, 
case 
when id = p_id and gender='M' then name end as Father,
case
when id = p_id and gender='F' then name end as Mother
from cte1
)
select 

from cte2