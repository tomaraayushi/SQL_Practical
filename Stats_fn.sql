SELECT 
	county_name AS county,
	state_name AS state,
	pop_est_2019 AS pop,
	births_2019 AS births,
	deaths_2019 AS deaths,
	international_migr_2019 AS int_migr,
	domestic_migr_2019 AS dom_migr,
	residual_2019 AS residual
FROM 
	us_counties_pop_est_2019;
	
--Add & Substract columns
SELECT 
	county_name AS county,
	state_name AS state,
	births_2019 AS births,
	deaths_2019 AS deaths,
	births_2019 - deaths_2019 AS natural_increase
FROM us_counties_pop_est_2019
ORDER BY state_name , county_name;

--Validate the data
SELECT
	county_name AS county,
	state_name AS state,
	pop_est_2019 AS pop,
	pop_est_2018 + births_2019 - deaths_2019 + 
		international_migr_2019 + domestic_migr_2019 + residual_2019 
		AS component_total,
	pop_est_2019 - (pop_est_2018 + births_2019 - deaths_2019 + 
						international_migr_2019 + domestic_migr_2019 + residual_2019)
		AS difference
FROM us_counties_pop_est_2019
ORDER BY difference DESC;

--Finding Percentage of the whole
SELECT 
	county_name AS county,
	state_name AS state,
	area_water::numeric / (area_land + area_water) * 100 AS water_pct
FROM us_counties_pop_est_2019
ORDER BY water_pct DESC;

--Tracking Percentage Change
CREATE TABLE percent_change(
	department text,
	spend_2019 numeric(10,2),
	spend_2022 numeric(10,2)
);

INSERT INTO percent_change
VALUES
	('Assessor', 178556, 179500),
	('Building', 250000, 289000),
	('Clerk', 451980, 650000),
	('Library', 87777, 90001),
	('Parks', 250000, 223000),
	('Water', 199000, 195000);
	
SELECT
	department,
	spend_2019,
	spend_2022,
	round( (spend_2022 - spend_2019) / spend_2019 *100,1)  AS change_pct
FROM percent_change;
	
--Using Aggreagate function 
SELECT
	sum(pop_est_2019) AS county_sum,
	round(avg(pop_est_2019), 0) AS county_average
FROM us_counties_pop_est_2019;
	
--Finding the median with percentile functions'
CREATE TABLE percentile_test(
							numbers integer);

INSERT INTO percentile_test VALUES (1), (2), (3), (4), (5), (6);								

SELECT 
	percentile_cont(.5)
	WITHIN GROUP(ORDER BY numbers),
	percentile_disc(.5)
	WITHIN GROUP(ORDER BY numbers)
FROM percentile_test;

--finding median with census data
SELECT
	sum(pop_est_2019) AS county_sum,
	round(avg(pop_est_2019), 0) AS county_average,
	percentile_cont(.5)
	WITHIN GROUP(ORDER BY pop_est_2019) AS county_median
FROM us_counties_pop_est_2019;	

--finding other quantiles
SELECT unnest(
	percentile_cont(ARRAY[.25, .5, .75])
	WITHIN GROUP(ORDER BY pop_est_2019) 
	)AS quartiles
FROM us_counties_pop_est_2019;

--finding the mode
SELECT
	mode()
	WITHIN GROUP(ORDER BY births_2019)
FROM us_counties_pop_est_2019;












