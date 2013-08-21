#!/usr/bin/env bash
TMPLDIR=src/templates

TARGET="$2"
DIRPREFIX=`dirname $1 | cut -c 5- | sed -e "s/[^\/]\+\/\?/..\//g"`
LEVEL=$[`dirname $1 | sed -e s/[^\/]*//g | wc -m`-1]

test
if [[ -f $2 && $1 -ot $2 ]]; then
  exit 0
fi

./filter.pl "$1" |                  \
./inlinescripting |                 \
pandoc                              \
    --to html5                      \
    --section-divs                  \
    --smart                         \
    --standalone                    \
    --mathjax                       \
    --include-before    $TMPLDIR/titlebar.html \
    --include-before    $TMPLDIR/navigation-level-${LEVEL}.html \
    --include-before    $TMPLDIR/before.html \
    --include-after     $TMPLDIR/after.html  \
    --include-in-header $TMPLDIR/header.html \
    --css ${DIRPREFIX}css/base.css              \
    > "$2"
