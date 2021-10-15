## **** GENERATED CODE! see gen/generateMakefile.js for more details!

.PHONY: prepare-dist download-sqlite download-native compile-linux compile-windows compile-macos test

SQLITE_RELEASE_YEAR ?= "2021"
SQLITE_VERSION ?= "3360000"


prepare-dist:
	mkdir -p dist
	rm -f dist/*

download-sqlite:
	curl -L http://sqlite.org/$(SQLITE_RELEASE_YEAR)/sqlite-amalgamation-$(SQLITE_VERSION).zip --output src.zip
	unzip src.zip
	mv sqlite-amalgamation-$(SQLITE_VERSION)/* src

download-native:
	curl -L https://github.com/sqlite/sqlite/raw/master/ext/misc/json1.c --output src/sqlite3-json1.c
	curl -L https://github.com/sqlite/sqlite/raw/master/ext/misc/series.c --output src/sqlite3-series.c
	curl -L https://github.com/sqlite/sqlite/raw/master/ext/misc/spellfix.c --output src/sqlite3-spellfix.c
	curl -L https://github.com/sqlite/sqlite/raw/master/ext/misc/memstat.c --output src/sqlite3-memstat.c
	curl -L https://github.com/shawnw/useful_sqlite_extensions/raw/master/src/math_funcs.c --output src/sqlite3-shawnw_math.c
	patch -p0 < diffs/sqlite3-shawnw_math.diff

# fails if grep does find a failed test case
# https://stackoverflow.com/questions/15367674/bash-one-liner-to-exit-with-the-opposite-status-of-a-grep-command/21788642
test:
	sqlite3 < test/$(suite).sql | (! grep -Ex "[0-9]+.0")

compile-linux:
	gcc -fPIC -shared src/sqlite3-crypto.c src/crypto/*.c -o dist/crypto.so -lm
	gcc -fPIC -shared src/sqlite3-ipaddr.c -o dist/ipaddr.so -lm
	gcc -fPIC -shared src/sqlite3-json1.c -o dist/json1.so -lm
	gcc -fPIC -shared src/sqlite3-math.c -o dist/math.so -lm
	gcc -fPIC -shared src/sqlite3-shawnw_math.c -o dist/shawnw_math.so -lm
	gcc -fPIC -shared src/sqlite3-memstat.c -o dist/memstat.so -lm
	gcc -fPIC -shared src/sqlite3-re.c src/re.c -o dist/re.so -lm
	gcc -fPIC -shared src/sqlite3-series.c -o dist/series.so -lm
	gcc -fPIC -shared src/sqlite3-spellfix.c -o dist/spellfix.so -lm
	gcc -fPIC -shared src/sqlite3-stats.c -o dist/stats.so -lm
	gcc -fPIC -shared src/sqlite3-text.c -o dist/text.so -lm
	gcc -fPIC -shared src/sqlite3-unicode.c -o dist/unicode.so -lm
	gcc -fPIC -shared src/sqlite3-vsv.c -o dist/vsv.so -lm

compile-macos:
	gcc -fPIC -dynamiclib -I src src/sqlite3-crypto.c src/crypto/*.c -o dist/crypto.dylib -lm
	gcc -fPIC -dynamiclib -I src src/sqlite3-ipaddr.c -o dist/ipaddr.dylib -lm
	gcc -fPIC -dynamiclib -I src src/sqlite3-json1.c -o dist/json1.dylib -lm
	gcc -fPIC -dynamiclib -I src src/sqlite3-math.c -o dist/math.dylib -lm
	gcc -fPIC -dynamiclib -I src src/sqlite3-shawnw_math.c -o dist/shawnw_math.dylib -lm
	gcc -fPIC -dynamiclib -I src src/sqlite3-memstat.c -o dist/memstat.dylib -lm
	gcc -fPIC -dynamiclib -I src src/sqlite3-re.c src/re.c -o dist/re.dylib -lm
	gcc -fPIC -dynamiclib -I src src/sqlite3-series.c -o dist/series.dylib -lm
	gcc -fPIC -dynamiclib -I src src/sqlite3-spellfix.c -o dist/spellfix.dylib -lm
	gcc -fPIC -dynamiclib -I src src/sqlite3-stats.c -o dist/stats.dylib -lm
	gcc -fPIC -dynamiclib -I src src/sqlite3-text.c -o dist/text.dylib -lm
	gcc -fPIC -dynamiclib -I src src/sqlite3-unicode.c -o dist/unicode.dylib -lm
	gcc -fPIC -dynamiclib -I src src/sqlite3-vsv.c -o dist/vsv.dylib -lm

compile-windows:
	gcc -shared -I. src/sqlite3-crypto.c src/crypto/*.c -o dist/crypto.dll -lm
	gcc -shared -I. src/sqlite3-ipaddr.c -o dist/ipaddr.dll -lm
	gcc -shared -I. src/sqlite3-json1.c -o dist/json1.dll -lm
	gcc -shared -I. src/sqlite3-math.c -o dist/math.dll -lm
	gcc -shared -I. src/sqlite3-shawnw_math.c -o dist/shawnw_math.dll -lm
	gcc -shared -I. src/sqlite3-memstat.c -o dist/memstat.dll -lm
	gcc -shared -I. src/sqlite3-re.c src/re.c -o dist/re.dll -lm
	gcc -shared -I. src/sqlite3-series.c -o dist/series.dll -lm
	gcc -shared -I. src/sqlite3-spellfix.c -o dist/spellfix.dll -lm
	gcc -shared -I. src/sqlite3-stats.c -o dist/stats.dll -lm
	gcc -shared -I. src/sqlite3-text.c -o dist/text.dll -lm
	gcc -shared -I. src/sqlite3-unicode.c -o dist/unicode.dll -lm
	gcc -shared -I. src/sqlite3-vsv.c -o dist/vsv.dll -lm

compile-windows-32:
	gcc -shared -I. src/sqlite3-crypto.c src/crypto/*.c -o dist/crypto-win32.dll -lm
	gcc -shared -I. src/sqlite3-json1.c -o dist/json1-win32.dll -lm
	gcc -shared -I. src/sqlite3-math.c -o dist/math-win32.dll -lm
	gcc -shared -I. src/sqlite3-shawnw_math.c -o dist/shawnw_math-win32.dll -lm
	gcc -shared -I. src/sqlite3-memstat.c -o dist/memstat-win32.dll -lm
	gcc -shared -I. src/sqlite3-re.c src/re.c -o dist/re-win32.dll -lm
	gcc -shared -I. src/sqlite3-series.c -o dist/series-win32.dll -lm
	gcc -shared -I. src/sqlite3-spellfix.c -o dist/spellfix-win32.dll -lm
	gcc -shared -I. src/sqlite3-stats.c -o dist/stats-win32.dll -lm
	gcc -shared -I. src/sqlite3-text.c -o dist/text-win32.dll -lm
	gcc -shared -I. src/sqlite3-unicode.c -o dist/unicode-win32.dll -lm
	gcc -shared -I. src/sqlite3-vsv.c -o dist/vsv-win32.dll -lm