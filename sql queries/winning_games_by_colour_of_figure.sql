with
total_games as
(
select 
	count(winner) as total_number_of_games 
from 
chess_games cg 
),
games_by_winner as
(
select 
	winner 
	,count(winner) as number_of_games
from 
chess_games cg 
group by 1
)
select 
	gbw.winner
	,round((gbw.number_of_games/tg.total_number_of_games)*100,1) as games_percentage
from 
games_by_winner gbw
join total_games tg