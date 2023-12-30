with
total_games as
(
select 
	count(winner) as total_number_of_games 
from 
chess_games cg 
),
total_games_by_move as
(
select 
	opening_shortname 
	,count(opening_shortname) as total_number_of_games_by_opening_move
from 
chess_games cg 
group by 1
),
games_by_white_figure_and_move as 
(
select 
	opening_shortname 
	,count(opening_shortname) as number_of_games_white_won
from
chess_games
where winner = 'White'
group by 1
),
games_by_black_figure_and_move as
(
select 
	opening_shortname 
	,count(opening_shortname) as number_of_games_black_won
from
chess_games
where winner = 'Black'
group by 1
)
select 
	tgn.opening_shortname as opening_move_name
	,round((tgn.total_number_of_games_by_opening_move/tg.total_number_of_games)*100,2) as percentage_of_total_games
	,round((bw.number_of_games_white_won/tg.total_number_of_games)*100,2) as percentage_of_total_games_if_white
	,round((bb.number_of_games_black_won/tg.total_number_of_games)*100,2) as percentage_of_total_games_if_black
from 
total_games_by_move tgn
join games_by_white_figure_and_move bw on tgn.opening_shortname = bw.opening_shortname
join games_by_black_figure_and_move bb on tgn.opening_shortname = bb.opening_shortname
join total_games tg
order by 2 desc
limit 10
