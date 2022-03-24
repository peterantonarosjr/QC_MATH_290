/*Create the target tables (NO SPECIFIC DATATYPES)*/

create table imdb.public.name_basics(
nconst text,
primaryName text,
birthYear text,
deathYear text,
primaryProfession text,
knownForTitles text
);

create table  imdb.public.title_akas(
titleId text,
ordering_ text,
title text,
region text,
language_ text,
types_ text,
attributes_ text,
isOriginalTitle text
);

create table  imdb.public.title_basics(
tconst text,
titleType text,
primaryTitle text,
originalTitle text,
isAdult text,
startYear text,
endYear text,
runtimeMinutes text,
genres text
);

create table  imdb.public.title_crew(
tconst text,
directors text,
writers text
);

create table  imdb.public.title_episode(
tconst text,
parentTconst text,
seasonNumber text,
episodeNumber text
);

create table  imdb.public.title_principals(
tconst text,
ordering_ text,
nconst text,
category text,
job text,
characters_ text
);

create table  imdb.public.title_ratings(
tconst text,
averageRating text,
numVotes text
);

/*Testing copy statements to check if tables are populated*/
select * from name_basics nb;
select * from title_akas ta;
select * from title_basics tb;
select * from title_crew tc;
select * from title_episode te;
select * from title_principals tp;
select * from title_ratings tr;

/*Fixing my mistake of first row being column name*/
delete from name_basics where nconst = 'nconst';
delete from title_akas where titleid = 'titleId';
delete from title_basics where tconst = 'tconst';
delete from title_crew where tconst = 'tconst';
delete from title_episode where tconst = 'tconst';
delete from title_principals where tconst = 'tconst';
delete from title_ratings where tconst = 'tconst';

/*Testing the cardinality of columns for a unique primary key*/
select count(*) from name_basics nb; /*11,498,571*/
select count(distinct nconst) from name_basics nb; /*11,498,571*/

select count(*) from title_akas ta; /*31,436,720*/
select count(distinct titleid) from title_akas nb; /*6,214,679*/
select count(distinct (titleid,ordering_)) from title_akas nb; /*31,436,720*/

select count(*) from title_basics tb; /*8,784,772*/
select count(distinct tconst) from title_basics tb; /*8,784,772*/

select count(*) from title_crew tc; /*8,784,772*/
select count(distinct tconst) from title_crew tc; /*8,784,772*/

select count(*) from title_episode te; /*6,581,647*/
select count(distinct tconst) from title_episode te; /*6,581,647*/

select count(*) from title_principals tp; /*49,478,209*/
select count(distinct tconst) from title_principals tp; /*7,913,307*/
select count(distinct (tconst, ordering_)) from title_principals tp; /*49,478,209*/

select count(*) from title_ratings tr; /*1,226,998*/
select count(distinct tconst) from title_ratings tr; /*1,226,998*/


/*Altering tables to set a primary key*/
alter table name_basics add primary key (nconst);
alter table title_akas add primary key (titleId, ordering_);
alter table title_basics add primary key (tconst);
alter table title_crew add primary key (tconst);
alter table title_episode add primary key (tconst);
alter table title_principals add primary key (tconst, ordering_);
alter table title_ratings add primary key (tconst);


/*Testing for foreign key*/
select count(*) from(
	select tconst from title_ratings tr
	except
	select tconst from title_basics tb
) as tconstCounter; /*Returns 4 -> present in title_r not in title_b*/

select count(*) from(
	select tconst from title_basics tb
	except
	select tconst from title_ratings tr
) as tconstCounter; /*Returns 7,557,778 -> present in title_b not in title_r*/

select * from(
	select tconst from title_ratings tr
	except
	select tconst from title_basics tb
) as tconstVals;

select count(*) from(
	select tconst from title_ratings tr
	intersect
	select tconst from title_basics tb
) as tconstIntersec; /*Returns 1,226,994*/


/*Attempting to add a foreign key*/
alter table title_ratings add constraint
	fk_title_basics_tconst foreign key (tconst)
	references title_basics (tconst); /*title_basics parent*/

alter table title_basics add constraint
	fk_title_ratings_tconst foreign key (tconst)
	references title_ratings (tconst); /*title_ratings parent*/


