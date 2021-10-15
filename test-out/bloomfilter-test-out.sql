.load dist/bloom_filter


CREATE TABLE plants(name);
CREATE VIRTUAL TABLE vegetables USING bloom_filter1(20);
INSERT INTO plants VALUES ('apple'), ('asparagus'), ('cabbage'), ('grass');
INSERT INTO vegetables VALUES ('asparagus'), ('cabbage');
SELECT * FROM plants WHERE EXISTS (SELECT * FROM vegetables(name));
[{"name":"asparagus"},
{"name":"cabbage"}]
SELECT * FROM plants WHERE 1 NOT IN vegetables(name);
[{"name":"apple"},
{"name":"grass"}]
