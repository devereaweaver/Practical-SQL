/* Create a table with a JSON file */
CREATE TABLE films (
	id integer GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	film jsonb NOT NULL    -- surrogate key
);


\copy films(film)    
FROM './films.json';

CREATE INDEX idx_film ON films USING GIN (film);
