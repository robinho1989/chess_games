with
total_games as
(
select 
	count(winner) as total_number_of_games 
from 
chess_games cg 
),
all_games_with_with_winner_check as
(
select 
*
,case 
	when white_rating > black_rating and winner = 'White' then 'Higher Ranked Palyer Won'
	when white_rating < black_rating and winner = 'Black' then 'Higher Ranked Palyer Won'
	when white_rating = black_rating then 'Same Ranked Players'
	else 'Lower Ranked Player Won'
end who_won
from 
chess_games cg 
),
total_games_by_rank as
(
select
	who_won
	,count(who_won) as total_number_of_won_games 
from
all_games_with_with_winner_check
group by 1
)
select 
	tgbr.who_won
	,round((tgbr.total_number_of_won_games/tg.total_number_of_games)*100,2) as games_percentage
from 
total_games_by_rank tgbr
join total_games tg