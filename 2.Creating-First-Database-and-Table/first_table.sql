/* first_table.sql - create first table using SQL and Postgres
 * Author: Devere Anthony Weaver
 * Last Modified: 17 MAY 2022
 */
 
 /* file design */
 CREATE TABLE teachers (    
	 id bigserial,   /* auto incrementing integer */
	 first_name varchar(25),
	 last_name varchar(50),
	 school varchar(50),
	 hire_date date,
	 salary numeric
 );