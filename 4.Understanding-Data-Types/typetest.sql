/* Build and load a simple table and then eport the data 
 * to an texdt file on your computer. 
 * The output text file shows the fixed-length column as 
 * well as the variable length columns. 
 */
 
CREATE TABLE char_data_types (
	char_column char(10), 
	varchar_column varchar(10),
	text_column text
);


INSERT INTO char_data_types
VALUES ('abc', 'abc', 'abc'),
	   ('defghi', 'defghi', 'defghi');
	   
	   
/* COPY function is PostgreSQL specific */
COPY char_data_types TO '/Users/devere/Data-Engineering/PracticalSQL/4.Understanding-Data-Types/typetest.txt'
WITH (FORMAT CSV, HEADER, DELIMITER '|');