/*What is the total runtime of all movies in the IMDB database where Nicolas Cage appeared as an actor?*/
select sum(runtimeminutes) as cage_runtime_minutes
	from xf_title_principals xtp
full outer join xf_name_basics xnb
	on xtp.nconst = xnb.nconst
full outer join xf_title_basic xtb
	on xtp.tconst = xtb.tconst
where xnb.primaryname = 'Nicolas Cage'
	and xtb."titletype" = 'movie'
	and category = 'actor'

/*Which actor had the most number of titles in 2012?*/
select "primaryname", count(*) numOfMovies
	from  xf_title_principals xtp
full outer join xf_name_basics xnb
	on xtp."nconst" = xnb."nconst"
full outer join xf_title_basic xtb
	on xtp."tconst" = xtb."tconst"
where category = 'actor' and startyear = 2012
	group by primaryname
	order by numOfMovies desc

/*What Nicolas Cage's move received the highest average rating?*/
select xnb."primaryname", xtb."primarytitle", xtr."averagerating"
	from  xf_title_principals xtp
full outer join xf_name_basics xnb
	on xtp."nconst" = xnb."nconst"
full outer join xf_title_basic xtb
	on xtp."tconst" = xtb."tconst"
full outer join xf_title_ratings xtr
	on xtp."tconst" = xtr."tconst"
where xnb."primaryname" = 'Nicolas Cage'
	and xtr."averagerating" is not null
	and xtp."category" = 'actor'
order by xtr."averagerating" desc

/*Which short move received the highest average rating in 2009?*/
select xtb."primarytitle", xtr."averagerating"
	from xf_title_basic xtb
full outer join xf_title_ratings xtr
	on xtb."tconst" = xtr."tconst"
where xtb."genres" = '{Short}'
	and xtr."averagerating" is not null
	and xtb."startyear" = 2009
order by xtr."averagerating" desc

/*Return the top 10 actors with most movies where the runtime is between 45 and 60 minutes and the start year is between 2000 and 2010?*/
select xnb."primaryname", count(*) numOfMovies
	from  xf_title_principals xtp
full outer join xf_name_basics xnb
	on xtp."nconst" = xnb."nconst"
full outer join xf_title_basic xtb
	on xtp."tconst" = xtb."tconst"
where xtp."category" = 'actor'
	and xtb."startyear" >= 2000 and xtb."startyear" <= 2010
	and xtb."runtimeminutes" >= 45 and xtb."runtimeminutes" <= 60
	and xnb."primaryname" is not null
group by xnb."primaryname"
order by numOfMovies desc
limit 10

/*What are the top 10 highly rated movies with only three words in their titles?*/
with three_word_titles as(
	select "tconst", regexp_split_to_array("primarytitle", ' ') three_words
	from xf_title_basic xtb
)
select "three_words" as title_name, xtr."numvotes"
	from xf_title_ratings xtr
full outer join three_word_titles
	on three_word_titles."tconst" = xtr."tconst"
where array_length("three_words", 1) = 3
	and xtr."numvotes" is not null
	order by xtr."numvotes" desc
limit 10

/*Extra credit: Are three-word movie titles more popular than two-word titles?*/
with two_versus_three_title as (
	select array_length(regexp_split_to_array("primarytitle", ' '), 1) as title_length,
		xtr."averagerating", "numvotes", "primarytitle", xtb."titletype"
	from xf_title_ratings xtr
	full outer join xf_title_basic xtb
		on xtb."tconst" = xtr."tconst"
)
select "title_length", sum("numvotes") total_votes, avg("averagerating") avgRating
	from two_versus_three_title
where "title_length" > 1 and "title_length" < 4
	and "titletype" = 'movie'
group by "title_length"
