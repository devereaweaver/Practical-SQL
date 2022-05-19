/* Ch.5 - Importing and Exporting Data using PostgreSQL 
 * 
 * Postgres-specific implementation uses the COPY command 
 * to import and export data into tables. 
 *
 * Three steps to importing:
 *	1. obtain source data in form of delimited text file 
 *  2. create table to store data
 *  3. write COPY statement to perform the import
 * 
 * PostgreSQL doesn't use header rows, so be sure to get 
 * rid of them when importing data. 
 */
 
 
/* Import the census data */ 
CREATE TABLE us_counties_pop_est_2019(
	state_fips text,
	county_fips text,
	region smallint,
	state_name text,
	county_name text,
	area_land bigint,
	area_water bigint,
	internal_point_lat numeric(10, 7),    -- 10 sig-figs, max of 7 decimals places 
	internal_point_lon numeric(10, 7),
	pop_est_2018 integer, 
	pop_est_2019 integer,
	births_2019 integer,
	deaths_2019 integer,
	international_migr_2019 integer,
	domestic_migr_2019 integer,
	residual_2019 integer,
	CONSTRAINT counties_2019_key PRIMARY KEY (state_fips, county_fips)    -- composite primary key implies remaining attributes 
);
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 