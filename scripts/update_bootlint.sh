#!/bin/bash
root=$(pwd)
version=$1
if ! test "$version"; then
  echo "Valid Bootlint version required."
  exit 1
fi

# strip leading 'v' if present
version=`echo $version | sed 's/^v//'`

if test -d public/bootlint/$version; then
  echo "Bootlint version already found."
  exit 1
fi

set -uex
mkdir public/bootlint/$version
wget --quiet --output-document public/bootlint/$version/bootlint.js \
  https://raw.githubusercontent.com/twbs/bootlint/$version/dist/browser/bootlint.js

cd public/bootlint
rm latest
ln -s $version latest

cd $root
./scripts/lint.sh $version

set +x
echo " "
echo "Do not forget to update 'config/_config.yml!'"
