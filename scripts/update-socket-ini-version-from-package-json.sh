#!/usr/bin/env bash

declare version=""

version="$(node -pe "require('./package.json').version")"

sed -i "s/version\s*=\s*.*/version = $version/g" socket.ini || exit $?
git add socket.ini || exit $?
