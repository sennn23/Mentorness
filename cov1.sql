create database virus;
use virus;
CREATE TABLE CovidData (
    Province VARCHAR(255),
    CountryRegion VARCHAR(255),
    Latitude FLOAT,
    Longitude FLOAT,
    Date DATE,
    Confirmed INT,
    Deaths INT,
    Recovered INT
);
select * from CovidData;
select * from coviddata;
#1 check null values
SELECT *
FROM CovidData
WHERE Confirmed IS NULL OR Deaths IS NULL OR Recovered IS NULL;
#2 update null values to 0
UPDATE CovidData
SET Confirmed = CASE WHEN Confirmed IS NULL THEN 0 ELSE Confirmed END,
    Deaths = CASE WHEN Deaths IS NULL THEN 0 ELSE Deaths END,
    Recovered = CASE WHEN Recovered IS NULL THEN 0 ELSE Recovered END;

#3 no of rows
select count(*) as rowcount from coviddata;

#4
select date as start_date from coviddata order by date limit 1;
select date as end_date from coviddata order by date desc limit 1;

#5 Number of month present in dataset

SELECT DISTINCT YEAR(Date) AS Year, MONTH(Date) AS Month
FROM CovidData
ORDER BY Year, Month;

# Q6. Find monthly average for confirmed, deaths, recovered

select distinct year(date) as Year,month(date) as Month,avg(confirmed) as cavg,avg(deaths) as mavg,
avg(recovered) as ravg from coviddata group by Year,Month;


#Q8. Find minimum values for confirmed, deaths, recovered per year
select distinct year(date) as Year,min(confirmed) as Min_confirmed,min(deaths) as Min_deaths,
min(recovered) as Min_recovered from coviddata group by Year;

#Q9. Find maximum values of confirmed, deaths, recovered per year
select distinct year(date) as Year,max(confirmed) as Max_confirmed,max(deaths) as Max_deaths,
max(recovered) as Max_recovered from coviddata group by Year;

#-- Q10. The total number of case of confirmed, deaths, recovered each month
select distinct year(date) as Year,month(Date) as Month, count(distinct confirmed) as count_confirmed,
count(distinct deaths) as count_deaths,
count(distinct recovered) as count_recovered from coviddata group by Year,Month;

-- Q11. Check how corona virus spread out with respect to confirmed case
#(Eg.: total confirmed cases, their average, variance & STDEV )
select count(distinct confirmed) as total_confirmed,
avg(confirmed) as avg_confirmed,
variance(confirmed) as var_confirmed,
stddev(confirmed) as std_confirmed from coviddata;

-- Q12. Check how corona virus spread out with respect to death case per month
--      (Eg.: total confirmed cases, their average, variance & STDEV )
select distinct year(date) as Year,month(Date) as Month,count(distinct deaths) as total_deaths,
avg(deaths) as avg_deaths,
variance(deaths) as var_deaths,
stddev(deaths) as std_deaths from coviddata group by Year,Month;

-- Q13. Check how corona virus spread out with respect to recovered case
--      (Eg.: total confirmed cases, their average, variance & STDEV )
select count(distinct recovered) as total_recovered,
avg(recovered) as avg_recovered,
variance(recovered) as var_recovered,
stddev(recovered) as std_recovered from coviddata;

-- Q14. Find Country having highest number of the Confirmed case
select countryregion,count(distinct confirmed) as distinct_conf from coviddata group by countryregion
order by distinct_conf desc limit 1;

-- Q15. Find Country having lowest number of the death case
select countryregion,count(distinct deaths) as distinct_deaths from coviddata group by countryregion
order by distinct_deaths limit 5;

-- Q16. Find top 5 countries having highest recovered case
select countryregion,count(distinct recovered) as distinct_recovered from coviddata group by countryregion
order by distinct_recovered desc limit 5;



