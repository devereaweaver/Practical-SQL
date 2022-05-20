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
 
 
/* Import census table with PostgreSQL COPY */
COPY us_counties_pop_est_2019
FROM '/Users/devere/Data-Engineering/PracticalSQL/5.Importing-and-Exporting-Data/us_counties_pop_est_2019.csv'
WITH (FORMAT CSV, HEADER);


/* Inspect the new data */
SELECT * FROM us_counties_pop_est_2019
WHERE state_name = 'Florida' AND county_name LIKE 'Escambia%';
 
/* 3 counties with the largest area_land values */
SELECT county_name, state_name, area_land
FROM us_counties_pop_est_2019
ORDER BY area_land DESC
LIMIT 3;
 

/* Importing a subset of columns using COPY, 
 * There may be times when attempting to import data into 
 * a table, there isn't data for all the columns in the table. 
 * When this happens, Postgres' COPY command can import data to 
 * specific columns.
 *
 * To demonstrate, consider researching salaries of two supervisors
 * in your state to analyze government spending trends by geography.
 */
 
 
CREATE TABLE supervisor_salaries (
	id integer GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	town text, 
	county text, 
	supervisor text,
	start_date date, 
	salary numeric(10,2),
	benefits numeric(10,2)
);

/* Attempting to import our smaller data set as in the example above will result 
 * in an error since our columns in the data set won't match the table columns. 
 * Also, attempting to import data with an auto-incrementing integer can cause issues
 * as well. The workaround is to simply tell the DBMS which columns we do have. 
 */
 
COPY supervisor_salaries(town, supervisor, salary)
FROM '/Users/devere/Data-Engineering/PracticalSQL/5.Importing-and-Exporting-Data/supervisor_salaries.csv'
WITH (FORMAT CSV, HEADER);
 
TABLE supervisor_salaries;


/* Importing a Subset of Rows with COPY 
 * PostgreSQL added functionality to filter which 
 * rows from the source CSV to import into a table. 
 * Simply use a WHERE clause with the COPY statement.
 */
 
DELETE FROM supervisor_salaries;    -- delete previously added data from table but will not 
									-- reset the id column's IDENTITY column sequence 

/* Now, filter on rows to include only town column matches 
 * the string 'New Brillig'
 */
COPY supervisor_salaries(town, supervisor, salary)
FROM '/Users/devere/Data-Engineering/PracticalSQL/5.Importing-and-Exporting-Data/supervisor_salaries.csv'
WITH (FORMAT CSV, HEADER)
WHERE town = 'New Brillig';

TABLE supervisor_salaries;
  


/* Adding a value to a column during import 
 *
 * One can add values to a temporary table before adding them to 
 * the actual final table. These temporary tables exist until the 
 * end of the database session. These are useful for performing
 * intermediary operations on data in the processing pipeline. */ 

DELETE FROM supervisor_salaries;

CREATE TEMPORARY TABLE supervisor_salaries_temp (LIKE supervisor_salaries INCLUDING ALL);

COPY supervisor_salaries_temp (town, supervisor, salary)    -- temporary to store incomplete columns
FROM '/Users/devere/Data-Engineering/PracticalSQL/5.Importing-and-Exporting-Data/supervisor_salaries.csv'
WITH (FORMAT CSV, HEADER);

INSERT INTO supervisor_salaries (town, county, supervisor, salary)
SELECT town, 'Mills', supervisor, salary    -- insert data from temp table and hardcode 'Mills' in county column
FROM supervisor_salaries_temp;

DROP TABLE supervisor_salaries_temp;

TABLE supervisor_salaries;    -- notice hardcoded value in all rows from county column



/* Using COPY to Export Data
 * Use PosgreSQL's COPY to export data. 
 */
 
/* Exporting ALL data */

COPY us_counties_pop_est_2019
TO '/Users/devere/Data-Engineering/PracticalSQL/5.Importing-and-Exporting-Data/us_counties_export.txt'
WITH (FORMAT CSV, HEADER, DELIMITER '|');    -- keep column names as header 

 
/* Exporting particular columns 
 * 
 * To do so, simply add the names of the columns 
 * after the table name as they appear in the data
 */
COPY us_counties_pop_est_2019 (county_name, internal_point_lat, internal_point_lon)
TO '/Users/devere/Data-Engineering/PracticalSQL/5.Importing-and-Exporting-Data/us_counties_latlong_export.txt'
WITH (FORMAT CSV, HEADER, DELIMITER '|');  
 
 
/* Exporting query results 
 * 
 * A query can be added to COPY to fine-tune the output.
 */
 
/* Only return rows that match pattern for county name */
COPY(
	SELECT county_name, state_name
	FROM us_counties_pop_est_2019
	WHERE county_name ILIKE '%mill%'    -- case insensitive 
)
TO '/Users/devere/Data-Engineering/PracticalSQL/5.Importing-and-Exporting-Data/us_counties_mill_export.csv'
WITH(FORMAT CSV, HEADER);
