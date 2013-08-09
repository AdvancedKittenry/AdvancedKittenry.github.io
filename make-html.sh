#!/usr/bin/env bash

./filter.pl "$1" |                  \
pandoc                              \
    --to html5                      \
    --section-divs                  \
    --smart                         \
    --standalone                    \
    --mathjax                       \
    --include-before    "$2"        \
    --include-after     src/templates/after.html  \
    --include-in-header src/templates/header.html \
    --css css/base.css              \
