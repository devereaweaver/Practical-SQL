/* It is generally good practice to start any analysis by 
 * checking whether the data is present and in the format 
 * that is expected.
 */

/* View all the records from a given table */
SELECT * FROM teachers;

TABLE teachers;


/* Query a subset of the columns for a given table */
SELECT last_name, first_name, salary FROM teachers;


/* Querying sorted data */
SELECT first_name, last_name, salary FROM teachers
ORDER BY salary DESC;


/* Data can be sorted by on more than one column.
 * For our example, we sorted the schools by name in 
 * ascending order and then we sorted the hire_date in 
 * descending order so that the newest faculty is first.
 */
SELECT last_name, school, hire_date FROM teachers
ORDER BY school ASC, hire_date DESC;


/* Eliminate duplicate values in a query.
 * This example shows the range of values for our school attribute.
 */ 
SELECT DISTINCT school FROM teachers ORDER BY school;


/* DISTINCT can also be used on more than one colunn at a time 
 * which can be helpful in showing unique pairs or n-tuples in the 
 * given table. 
 */
SELECT DISTINCT school, salary FROM teachers ORDER BY school, salary;



/* Use WHERE to filter rows based on some operator */
SELECT last_name, school, hire_date 
FROM teachers 
WHERE school = 'Myers Middle School';


/* A query that includes everything mentioned througout the chapter */
SELECT first_name, last_name, school, hire_date, salary
FROM teachers
WHERE school LIKE '%Roos%'
ORDER BY hire_date DESC;
