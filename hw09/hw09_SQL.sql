/*Question 1*/
/*Check .ipynb file in directory*/

/*Question 2*/


/*Question 3*/
select xtb."primarytitle", xtr."averagerating"
	from xf_title_basic xtb
full outer join xf_title_ratings xtr
	on xtb."tconst" = xtr."tconst"
where xtb."genres" = '{Comedy}' and xtb."titletype" = 'short'
	and xtr."averagerating" is not null
	and xtb."startyear" between 2000 and 2010
order by xtr."averagerating" desc

/*Question 4*/
