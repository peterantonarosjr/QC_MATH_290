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
max(TripCount) as dailyMaxTrips,
from tripsPerDate
where extract ('year' from date(hours)) = 2020
group by vendorid, days


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
where extract ('year' from date(hours)) = 2020
group by vendorid, days

/*EXERCISE 3*/
















