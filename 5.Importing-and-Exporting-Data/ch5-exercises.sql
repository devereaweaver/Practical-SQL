/* Chapter 5 Exercises */

/* Write a WITH statement to include with COPY to handle 
 * the import of an imaginary text file whose first couple
 * rows are as given in the text.
 */
 
CREATE TABLE movies (
	id numeric,
	movie text,
	actor text
);

COPY movies
FROM '/Users/devere/Data-Engineering/PracticalSQL/5.Importing-and-Exporting-Data/test.txt'
WITH (FORMAT CSV, HEADER, DELIMITER ':', QUOTE '#');

TABLE movies;


/* Export a to a CSV the 20 counties in the US that had the 
 * most births. Export only county name, state, # births.
 */
SELECT county_name, state_name, births_2019
FROM us_counties_pop_est_2019
ORDER BY births_2019 DESC
LIMIT 20;