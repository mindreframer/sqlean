.read test/_settings.sql
.load dist/pivot_vtab

-- https://github.com/jakethaw/pivot_vtab/


-- Rows
CREATE TABLE r AS SELECT 1 id UNION SELECT 2 UNION SELECT 3;

-- Columns
CREATE TABLE c( id   INTEGER PRIMARY KEY, name TEXT);
INSERT INTO c (name) VALUES ('a'),('b'),('c'),('d');

CREATE TABLE x( r_id INT, c_id INT, val TEXT);
INSERT INTO x (r_id, c_id, val) SELECT r.id, c.id, c.name || r.id FROM c, r;

SELECT * FROM x;



CREATE VIRTUAL TABLE pivot USING pivot_vtab(
  --
  -- Pivot table row key query
  --
  -- Defines first column of the pivot table
  --
  -- Required to perform a full table scan of the pivot table. This is run when
  -- not joining or filtering by the pivot table key.
  --
  -- The first column name in this query will become the name of the pivot table key column.
  -- The value of the pivot table key column is provided to the pivot query as ?1.
  --
 (SELECT id r_id -- pivot table key
    FROM r),

  --
  -- Pivot table column definition query
  --
  -- Defines second+ column(s) of the pivot table
  --
  -- This query should return pivot table column key/name pairs.
  -- It is run during vtab creation to define the pivot table column names.
  --
  -- The first column of this query is the pivot column key, and is provided
  -- to the pivot query as ?2
  --
  -- The second column of this query is used to name the pivot table columns.
  -- This column is required to return unique values.
  --
  -- Changes to this query can only be propagated by dropping and
  -- re-creating the virtual table
  --
 (SELECT id c_id,   -- pivot column key - can be referenced in pivot query as ?2
         name       -- pivot column name
    FROM c),

  --
  -- Pivot query
  --
  -- This query should define a single value in the pivot table when
  -- filtered by the pivot table row key (1?) and a column key (2?)
  --
 (SELECT val
    FROM x
   WHERE r_id = ?1
     AND c_id = ?2)
);


SELECT *
  FROM pivot;


UPDATE x
   SET val = 'hello'
 WHERE c_id = 3
   AND r_id = 2;

UPDATE x
   SET val = 'world'
 WHERE c_id = 4
   AND r_id = 2;

DELETE
  FROM x
 WHERE c_id = 2
   AND r_id = 3;

SELECT *
  FROM pivot;
