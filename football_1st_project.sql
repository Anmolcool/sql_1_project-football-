use map;
select * from country limit 5;

select * from league limit 5;

select * from matches limit 5;

select * from team limit 5;

alter table country add primary key(id);

alter table league add primary key(id);

alter table matches add primary key(match_api_id);

alter table team add primary key(team_api_id);

alter table league add foreign key(country_id) references country(id);

alter table matches add foreign key(home_team_api_id) references team(team_api_id);

alter table matches add foreign key(away_team_api_id) references team(team_api_id);

-- duplicate check

select country_id,name,count(*)
from 
league
group by country_id,name
having count(*)>1;

-- 24558 Switzerland Super League

insert into league values(0,24558,"Switzerland Super League");

select *from league;

delete from league
WHERE id in (select id from
				(select max(id) as id
					from league
						group by country_id,name
                        having count(*)>1)
				A);
                -- Data type mismatch check (converting string to timestamp)
               
select str_to_date(date,'%Y-%m-%d %H:%i:%s')as converted_date, date from matches;
-- change the data type of column

select * from matches;

alter table matches modify column date timestamp;

-- alter table matches alter column date datetime -- MS SQL SERVER

-- views - virtual table 

-- home_team_goal count

-- matches, team

-- Home_team_goal_count view is to identify the number of goals made by team played in the home ground.
-- The minimum number of goals a home team should have done is 3.
                
                create view home_team_goal_count as
select matches.home_team_api_id,
	   team.team_long_name,
       sum(matches.home_team_goal) as goal_count
from
	  matches
      inner join
      team
on
	   matches.home_team_api_id=team.team_api_id
group by matches.home_team_api_id
having sum(matches.home_team_goal)>3;

select count(*) from home_team_goal_count;

  select * from home_team_goal_count order by goal_count desc;
              
-- build a view for away_team_goal_count
-- build a away_team_goal_count view using the matches and team tables.
-- let the total number of away_team_goal_count be a minimum of 3

                create view away_team_goal_count as
select matches.away_team_api_id,
	   team.team_long_name,
       sum(matches.away_team_goal) as goal_count
from
	  matches
      inner join
      team
on
	   matches.away_team_api_id=team.team_api_id
group by matches.away_team_api_id
having sum(matches.away_team_goal)>3;

select count(*) from away_team_goal_count;

  select * from away_team_goal_count order by goal_count desc;
