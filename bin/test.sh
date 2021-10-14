#/usr/bin/env bash

for f in test/*.sql; do
    echo "--- $f ---";
    sqlite3 < $f
done