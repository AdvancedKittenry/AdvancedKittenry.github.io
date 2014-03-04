#!/usr/bin/env bash
TMPLDIR=src/templates

SRC=$1
TARGET=${SRC%.markdown}.html
TARGET=${TARGET#src/}
LEVEL=$[`dirname $1 | sed -e s/[^\/]*//g | wc -m`-1]
NAVIGATION=$TMPLDIR/navigation-level-${LEVEL}.html

lib/filter.pl "$1" |           \
lib/generatedoc $NAVIGATION |  \
lib/fix-styles.pl "$TARGET"    \
    > "$TARGET"
