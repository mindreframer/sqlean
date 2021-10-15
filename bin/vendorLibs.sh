#!/usr/bin/env bash

### official SQLite extensions

curl -L https://github.com/sqlite/sqlite/raw/master/ext/misc/json1.c --output src/sqlite3-json1.c
curl -L https://github.com/sqlite/sqlite/raw/master/ext/misc/series.c --output src/sqlite3-series.c
curl -L https://github.com/sqlite/sqlite/raw/master/ext/misc/spellfix.c --output src/sqlite3-spellfix.c
curl -L https://github.com/sqlite/sqlite/raw/master/ext/misc/memstat.c --output src/sqlite3-memstat.c

### communinity maintained extensions

curl -L https://github.com/shawnw/useful_sqlite_extensions/raw/master/src/math_funcs.c --output src/sqlite3-shawnw_math.c
patch -p0 < diffs/sqlite3-shawnw_math.diff

curl -L https://github.com/shawnw/useful_sqlite_extensions/raw/master/src/bloom_filter.c --output src/sqlite3-bloom_filter.c
patch -p0 < diffs/sqlite3-bloom_filter.diff

curl -L https://github.com/abetlen/sqlite3-bfsvtab-ext/raw/main/bfsvtab.c --output src/sqlite3-bfsvtab.c
