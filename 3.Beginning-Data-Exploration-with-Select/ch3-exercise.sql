/* Query lists the schools in alpha order and
 * teachers by last name A-Z.
 */
 
SELECT school, last_name, first_name FROM teachers
ORDER BY school ASC, last_name ASC;
 
/* Find teacher whose first name starts with 
 * S and who earns more than $40,000
 */
  
SELECT first_name, last_name, salary FROM teachers
WHERE first_name LIKE 'S%'
  	  AND salary > 40000;

/* Rank teachers hired since January 1, 2010, 
 * order by highest paid to lowest,
 */
 
SELECT first_name, last_name, hire_date, salary FROM teachers
WHERE hire_date >= '2010-01-01'
ORDER BY salary DESC;