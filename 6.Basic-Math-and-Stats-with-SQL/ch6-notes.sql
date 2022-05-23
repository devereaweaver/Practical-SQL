/* Ch.6 - Basic Math and Stats with SQL */

/* Understanding Math Operators and Functions */

-- NOTE: These operators are specific to Postgres
-- Simple arithmetic 
SELECT 2 + 2;
SELECT 9 - 1;
SELECT 3 * 4;

SELECT 3  ^ 4;    -- exponent 
SELECT |/ 10;    -- sqrt
SELECT sqrt(10);   
SELECT ||/ 10;    -- cubed root
SELECT factorial(4);
-- SELECT 4 !;      -- deprecated factorial operator 



/* Doing Math Across Table Columns */ 
/* Use the names of the columns that contain numeric values 
 * in order to perform computations acorss the rows. 
 */
 
SELECT county_name AS county,
	   state_name AS state, 
	   pop_est_2019 AS pop, 
	   births_2019 AS births,
	   deaths_2019 AS deaths,
	   international_migr_2019 AS int_migr,
	   domestic_migr_2019 AS dom_migr,
	   residual_2019 AS residual
FROM us_counties_pop_est_2019;

/* Adding and Subtracting Columns */ 

-- Compute natural increate (subtract # deats from births)
SELECT county_name AS county,
	   state_name AS state, 
	   births_2019 AS births,
	   deaths_2019 AS deaths, 
	   births_2019 - deaths_2019 AS natural_increase
FROM us_counties_pop_est_2019
ORDER BY state_name, county_name;
 
 
/* Finding percentages of the whole */
/* To do so, simply divide the number in 
 * question by the total.
 */
SELECT county_name AS county,
	   state_name as state,
	   area_water::numeric / (area_land + area_water) * 100 AS pct_water    -- cast to numeric since its of type bigint 
	   -- ANSI version, use CAST command 
FROM us_counties_pop_est_2019
ORDER BY pct_water DESC;


/* Tracking Percent Change */ 
/* Percent change calculations are often employed 
 * when analying changes over time, and they're 
 * particularly useful for comparing change among 
 * similar items.
 */

/* (new - old) / old */ 
CREATE TABLE percent_change(
	department text, 
	spend_2019 numeric(10, 2),
	spend_2022 numeric(10, 2)    -- precision, scale 
);

INSERT INTO percent_change
VALUES ('Assesor', 178556, 179500),
	   ('Building', 250000, 289000), 
	   ('Clerk', 451980, 650000), 
	   ('Library', 87777, 90001), 
	   ('Parks', 250000, 223000), 
	   ('Water', 199000, 195000);
	   
-- compute percentage change 
SELECT department, 
       spend_2019, 
	   spend_2022, 
	   round((spend_2022 - spend_2019) / spend_2019 * 100, 1) AS pct_change    -- round to nearest 1 decimal 
FROM percent_change;

/* This type of query can return results that make it easier for 
 * analysis. For the query above, one can clearly see the percentage 
 * change for one department is sky high compared to the rest. This 
 * can lead one to craft questions as to why this is the case. 
 */

/* Using Aggregate Functions for Averages and Sums */
/* Use avg() and sum() aggregate functions on our table */
SELECT sum(pop_est_2019) AS county_sum,    -- sum of entire population 2019
	   round(avg(pop_est_2019), 0) AS county_average    -- average population 2019 for all counties 
FROM us_counties_pop_est_2019;



















