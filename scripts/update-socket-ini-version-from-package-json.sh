#!/usr/bin/env bash

declare version=""

version="$(node -pe "require('./package.json').version")"

rm -f socket.ini.tmp
cat socket.ini | sed "s/version *= *.*/version = $version/g" > socket.ini.tmp
mv -f socket.ini.tmp socket.ini
git add socket.ini || exit $?
