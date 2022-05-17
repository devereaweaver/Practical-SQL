/* Create tables for the zoo database */
CREATE TABLE animal_collection(
	/* Collection of animals that exist in the zoo. */
	id bigserial, 
	scientific_name varchar(50), 
	common_name varchar(25)
);


CREATE TABLE animal_specifics(
	/* Specifics on each animal in the zoo */
	height numeric, 
	weight numeric, 
	diet varchar(20), 
	region varchar(50),
	life_span numeric
);

/* Populate first table with some data */ 
INSERT INTO animal_collection(scientific_name, common_name)
VALUES ('latin lion', 'lion'),
	   ('latin giraffe', 'giraffe'),
	   ('latin croc', 'crocodile');
	   
/* View first table */
SELECT * FROM animal_collection;

/* Populate second table with some data */ 
INSERT INTO animal_specifics(height, weight, diet, region, life_span)
VALUES (5, 500, 'carnivore', 'Africa', 20), 
	   (20, 600, 'herbavore', 'Africa', 20), 
	   (3, 500, 'canivore', 'Africa', 500);

/* View second table data */
SELECT * FROM animal_specifics;
