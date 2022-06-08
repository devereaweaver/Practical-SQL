/* Return jsonb */
SELECT id, film -> 'title' AS title
FROM films
ORDER BY id;

/* Return text */
SELECT id, film ->> 'title' AS title 
FROM films
ORDER BY id;

/* Return jsonb */
SELECT id, film -> 'genre' AS genre
FROM films
ORDER BY id;
