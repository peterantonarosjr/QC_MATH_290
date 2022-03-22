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


