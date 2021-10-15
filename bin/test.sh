#!/usr/bin/env bash

## call with `bin/test.sh CI` for CI testing!
node testrunner/index.js $@
exit $?
