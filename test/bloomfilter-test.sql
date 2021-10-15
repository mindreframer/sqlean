.read test/_settings.sql
.load dist/bloom_filter

-- https://github.com/shawnw/useful_sqlite_extensions/blob/master/docs/bloom_filter1.md

CREATE TABLE plants(name);
CREATE VIRTUAL TABLE vegetables USING bloom_filter1(20);
INSERT INTO plants VALUES ('apple'), ('asparagus'), ('cabbage'), ('grass');
INSERT INTO vegetables VALUES ('asparagus'), ('cabbage');
SELECT * FROM plants WHERE EXISTS (SELECT * FROM vegetables(name));
SELECT * FROM plants WHERE 1 NOT IN vegetables(name);
