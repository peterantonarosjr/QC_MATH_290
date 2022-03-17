/*EXERCISE 2*/
/*Part 1 attempt 1*/
select vendorid,
extract('hour' from tpep_dropoff_datetime) as hours,
count(*) as tripCount
from yellowtaxi_dataset yd
where extract ('year' from date(tpep_dropoff_datetime)) = 2020
group by vendorid, hours;

/*Part 1 attempt 2*/
select vendorid, date_trunc('hour', tpep_dropoff_datetime) as hours,
count(*) as tripCount
from yellowtaxi_dataset yd
where extract ('year' from date(tpep_dropoff_datetime)) = 2020
group by vendorid, hours;

/*Part 2 attempt 1*/
with tripsPerDate as (

	select vendorid, date_trunc('hours', tpep_dropoff_datetime) as hours,
	count(*) as tripCount
	from yellowtaxi_dataset yd
	where extract ('year' from date(tpep_dropoff_datetime)) = 2020
	group by vendorid, hours
)
select vendorid,  date_trunc('days', hours) as days,
avg(tripCount) as dailyAVGTrips,
min(tripCount) as dailyMinTrips,
max(TripCount) as dailyMaxTrips
from tripsPerDate
where extract ('year' from date(hours)) = 2020
group by vendorid, days;

/*Part 2 attempt 2*/
with tripsPerDate as (

	select vendorid, date_trunc('hours', tpep_dropoff_datetime) as hours,
	count(*) as tripCount
	from yellowtaxi_dataset yd
	where extract ('year' from date(tpep_dropoff_datetime)) = 2020
	group by vendorid, hours
)
select vendorid,  date_trunc('days', hours) as days,
avg(tripCount) as dailyAVGTrips,
min(tripCount) as dailyMinTrips,
max(TripCount) as dailyMaxTrips,
PERCENTILE_CONT(0.5) within group(order by tripCount) as medianDailyTrips
from tripsPerDate
group by vendorid, days
order by days;

/*Part 3 attempt 1*/
with tripsPerDate as (

	select vendorid, date_trunc('hours', tpep_dropoff_datetime) as hours,
	trip_distance as tripDist
	from yellowtaxi_dataset yd
	where extract ('hour' from tpep_dropoff_datetime) >=5 and
	extract ('hour' from tpep_dropoff_datetime) <6
	group by vendorid, hours, trip_distance
)
select vendorid,  date_trunc('days', hours) as days,
avg(tripDist) as dailyAvgTripDist,
min(tripDist) as dailyMinTripDist,
max(tripDist) as dailyMaxTripDist,
PERCENTILE_CONT(0.5) within group(order by tripDist) as medDailyTripDist
from tripsPerDate
group by vendorid, days
order by days;

/*Part 4 attempt 1*/
with tripsPerDate as (

	select vendorid, date_trunc('hours', tpep_dropoff_datetime) as hours,
	count(*) as tripCount
	from yellowtaxi_dataset yd
	where extract ('year' from date(tpep_dropoff_datetime)) = 2020
	group by vendorid, hours
)
select vendorid,  date_trunc('days', hours) as days,
tripCount as minTrips,
tripCount as maxTrips
from tripsPerDate
inner join(
	select max(tripCount) as maxT,
	min(tripcount) as minT
	from tripsPerDate
) as minOrMax
on tripsPerDate.tripCount = minormax.maxT
or
tripsPerDate.tripCount = minormax.minT;

/*EXERCISE 3*/
/*Part 1 attempt 1*/
with tripsPerDate as (

	select distinct *
	from yellowtaxi_dataset yd
)
select concat( cast( (sum(tip_amount) / sum(total_amount) * 100)
as varchar(5) ), '%' )
as avgTipPercentage
from tripsPerDate;

/*Part 2 attempt 1*/
with tripsPerDate as (
	select extract ('hour' from tpep_dropoff_datetime) as hours,
	sum(fare_amount + tip_amount) as totalAmount,
	sum(tip_amount) as tipAmount
	from yellowtaxi_dataset yd
	where extract ('year' from date(tpep_dropoff_datetime)) = 2020
	group by extract ('hour' from tpep_dropoff_datetime)
)
select hours, tipAmount/totalAmount as percentTip
from tripsPerDate
order by hours;


/*EXERCISE 4*/
/*Part 1 Attempt 1*/
DROP VIEW IF EXISTS daily_tip_percentage_by_distance;

create or replace
view daily_tip_percentage_by_distance
as
select extract (day from tpep_dropoff_datetime) as dateTime,
	(avg(tip_amount / total_amount)* 100) as tipPercentage,
	case
		when trip_distance >= 0
		and trip_distance < 1 then '0-1 mile'
		when trip_distance >= 1
		and trip_distance < 2 then '1-2 mile'
		when trip_distance >= 2
		and trip_distance < 3 then '2-3 mile'
		when trip_distance >= 3
		and trip_distance < 4 then '3-4 mile'
		when trip_distance >= 4
		and trip_distance < 5 then '4-5 mile'
		when trip_distance >= 5 then '5+ mile'
	end as mileageCases
from yellowtaxi_dataset
where total_amount > 0
group by extract (day from tpep_dropoff_datetime),mileageCases;
select dateTime, mileageCases,tipPercentage
from daily_tip_percentage_by_distance
order by dateTime, mileageCases;





