/* JSON Array Elemet Extraction */

/* Returns first element of each genre array as jsonb*/
SELECT id, film -> 'genre' -> 0 AS genres
FROM films
ORDER BY id;

/* Returns last element in genere array as jsonb*/
SELECT id, film -> 'genre' -> -1 AS genres
FROM films
ORDER BY id;

/* Returns third element in genere array as jsonb
 * (What if it doesn't exist?)
 */
SELECT id, film -> 'genre' -> 2 AS genres
FROM films
ORDER BY id;

/* Return first element as text */
SELECT id, film -> 'genre' -> 0 AS genres
FROM films
ORDER BY id;
