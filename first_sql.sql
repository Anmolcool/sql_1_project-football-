use first_sql;
select * from country limit 5;

select * from  league limit 5;

select * from  matches limit 5;
select * from  team limit 5;

alter table country add primary key(id);
alter table league add primary key(id);
alter table matches add primary key(match_api_id);
alter table team add primary key(team_api_id);