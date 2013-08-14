#!/usr/bin/env bash
TMPLDIR=src/templates

./filter.pl "$1" |                  \
pandoc                              \
    --to html5                      \
    --section-divs                  \
    --smart                         \
    --standalone                    \
    --mathjax                       \
    --include-before    $TMPLDIR/titlebar.html \
    --include-before    $TMPLDIR/navigation.html \
    --include-before    $TMPLDIR/before.html \
    --include-after     $TMPLDIR/after.html  \
    --include-in-header $TMPLDIR/header.html \
    --css css/base.css              \
