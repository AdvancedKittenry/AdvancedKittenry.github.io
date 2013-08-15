#!/usr/bin/env bash

{
  echo "<nav>"
  find src/ -iname "*.markdown" \
    | ./make-indexes.py src/ \
    | pandoc --to html5 --smart
  echo "</nav>"
} > src/templates/navigation-level-0.html 

MAXDEPTH=`find src/ -mindepth 1 -iname "*.markdown" -printf "%d\n" | sort -g | tail -n 1`
PREFIX='..\/'

for LEVEL in `seq $[MAXDEPTH-1]`; do
  sed -e "s/href=\"/&$PREFIX/" src/templates/navigation-level-0.html \
    > src/templates/navigation-level-$LEVEL.html 
  PREFIX="..\\/$PREFIX"
done
