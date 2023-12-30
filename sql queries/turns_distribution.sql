with
total_games as
(
select 
	count(winner) as total_number_of_games 
from 
chess_games cg 
),
turns_range_added as
(
select 
	*
	,case 
	when turns <= 50 then '0-50'	
	when turns <=100 then '51-100'
	when turns <=150 then '101-150'
	when turns <=200 then '151-200'
	when turns <=250 then '201-250'
	when turns <=300 then '251-300'
	when turns <=350 then '301-350'
	when turns <=400 then '351-400'
end as turns_range
from 
chess_games cg 
),
games_distribution as
(
select
	turns_range
	,count(turns_range) as number_of_games
from 
turns_range_added
group by 1
)
select 
	gd.turns_range
	,round((gd.number_of_games/tg.total_number_of_games)*100,2) as games_percentage
from 
games_distribution gd
join total_games tg