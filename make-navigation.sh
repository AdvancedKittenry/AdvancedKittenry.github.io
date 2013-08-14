#!/usr/bin/env bash

{
  echo "<nav>"
  find src/ -iname "*.markdown" \
    | ./make-indexes.py src/ \
    | pandoc --to html5 --smart
  echo "</nav>"
} > src/templates/navigation.html 
