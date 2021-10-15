### 0.8.6-3360

- EXT: new extension - shawnw_math (https://github.com/shawnw/useful_sqlite_extensions/raw/master/src/math_funcs.c)

  - it includes more statistical functions and also some mathematical functions not present in the Std-lib for SQLite (https://www.sqlite.org/lang_mathfunc.html)
    Documentation:
    - https://github.com/shawnw/useful_sqlite_extensions/blob/master/docs/math_funcs.md

- CI: more robust tests, that explicitly set the SQLITE settings
- CI: Snapshot-based test suite runner implemented in Node.js
- CI: Use latest SQLite binary for Github Actions (https://github.com/mindreframer/sqlite/releases/tag/0.7.1-3360)
