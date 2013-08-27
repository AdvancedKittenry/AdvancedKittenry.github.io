#!/usr/bin/env bash
TMPLDIR=src/templates

TARGET="$2"
DIRPREFIX=`dirname $1 | cut -c 5- | sed -e "s/[^\/]\+\/\?/..\//g"`
LEVEL=$[`dirname $1 | sed -e s/[^\/]*//g | wc -m`-1]
NAVIGATION=$TMPLDIR/navigation-level-${LEVEL}.html

./filter.pl "$1" |                  \
./inlinescripting |                 \
pandoc                              \
    --to html5                      \
    --section-divs                  \
    --smart                         \
    --standalone                    \
    --mathjax                       \
    --include-before    $TMPLDIR/titlebar.html \
    --include-before    $NAVIGATION            \
    --include-before    $TMPLDIR/before.html   \
    --include-after     $TMPLDIR/after.html    \
    --include-in-header $TMPLDIR/header.html   \
    --css ${DIRPREFIX}css/base.css             \
    | ./fix-styles.pl $2                       \
    > "$2"
