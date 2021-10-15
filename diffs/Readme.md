$ cp src/sqlite3-shawnw_math.c src/sqlite3-shawnw_math-fixed.c

## fix src/sqlite3-shawnw_math-fixed.c...

$ diff -u src/sqlite3-shawnw_math.c src/sqlite3-shawnw_math-fixed.c > diffs/sqlite3-shawnw_math.diff
$ rm src/sqlite3-shawnw_math-fixed.c

## apply patch (-p0 to handle folders!)

`patch -p0 < diffs/sqlite3-shawnw_math.diff`

## reverse patch

`patch -p0 -R < diffs/sqlite3-shawnw_math.diff`
