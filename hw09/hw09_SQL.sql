/*Question 1*/
select count("averagerating") as samp_size from xf_title_ratings xtr
select min(xtr."averagerating") as minium from xf_title_ratings xtr
select max(xtr."averagerating") as maximum from xf_title_ratings xtr
select avg(xtr."averagerating") as mean from xf_title_ratings xtr
select variance(xtr."averagerating") as var from xf_title_ratings xtr

with skewness as (
select
 	avg(xtr."averagerating") as mean_val,
 	percentile_cont(0.5) within group(
  		order by xtr."averagerating"
  	) as median_val,
  	stddev(xtr."averagerating") as std_deviation
   		from xf_title_ratings xtr
	)
select round(3*(mean_val - median_val)::numeric / std_deviation, 4) as skewness
	from skewness

/*Question 2*/
select "title", "primaryname", "category", "characters_"
	from  xf_title_principals xtp
left join xf_name_basics xnb
	on xtp."nconst" = xnb."nconst"
left join xf_title_akas xta
	on xtp."tconst" = xta."titleid"
where "title" = 'Lord of War' and (category = 'actor' or category = 'actress')

/*Question 3*/
select xtb."primarytitle", xtr."averagerating"
	from xf_title_basic xtb
full outer join xf_title_ratings xtr
	on xtb."tconst" = xtr."tconst"
where xtb."genres" @> '{Comedy}' and xtb."titletype" = 'short'
	and xtr."averagerating" is not null
	and xtb."startyear" between 2000 and 2010
order by xtr."averagerating" desc

/*Question 4*/
select avg(xtr."numvotes"), case
	when xtr."averagerating" >=1 and xtr."averagerating" < 2
		then '1-2'
	when xtr."averagerating" >=2 and xtr."averagerating" < 3
		then '2-3'
	when xtr."averagerating" >=3 and xtr."averagerating" < 4
		then '3-4'
	when xtr."averagerating" >=4 and xtr."averagerating" < 5
		then '4-5'
	else '>=5'
end as avg_rating_window
from xf_title_ratings xtr
group by avg_rating_window
