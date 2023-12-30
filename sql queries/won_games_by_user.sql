with
winner_table as
(
select 
	*
	,case 
		when winner = 'White' then white_id 
		when winner = 'Black' then black_id 
		when winner = 'Draw' then 'draw'
	end as winner_player_id
	,case 
		when winner ='White' then white_rating
		when winner = 'Black' then black_rating
		when winner = 'Draw' then 'draw'
	end as winner_rating
	,case 
		when winner ='White' then black_rating
		when winner = 'Black' then white_rating
		when winner = 'Draw' then 'draw'
	end as looser_rating
from 
chess_games cg 
),
winners_and_rating as
(
select
	winner_player_id
	,winner_rating
	,looser_rating
from 
winner_table
),
total_won_games_by_player as
(
select
	winner_player_id
	,count(winner_player_id) as number_of_won_games
from 
winners_and_rating
where winner_player_id <> 'draw'
group by 1
),
won_games_when_higher_rank as 
(
select 
	winner_player_id
	,count(winner_player_id) as number_of_won_games_if_higher_rank
from 
winners_and_rating
where winner_rating > looser_rating
group by 1
)
select 
	tw.winner_player_id
	,tw.number_of_won_games
	,hr.number_of_won_games_if_higher_rank
	,round((hr.number_of_won_games_if_higher_rank/tw.number_of_won_games)*100,1) as percentage_of_won_games_if_higher_rank
from 
total_won_games_by_player tw
join won_games_when_higher_rank hr on tw.winner_player_id = hr.winner_player_id
order by 2 desc
limit 10