#!/bin/bash

version=$1
if ! test "$version"; then
  echo "Valid Bootlint version required."
  exit 1
fi

# strip leading 'v' if present
version=`echo $version | sed 's/^v//'`

# ensure
test -x ./node_modules/.bin/uglifyjs || npm install

set -uex
./node_modules/.bin/uglifyjs public/bootlint/$version/bootlint.js \
  -o public/bootlint/$version/bootlint.min.js --compress --mangle --support-ie8 \
 --comments "/(?:^!|@(?:license|preserve|cc_on))/"
