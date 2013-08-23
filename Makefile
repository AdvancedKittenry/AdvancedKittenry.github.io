SRC=$(shell find src -iname "*.markdown")
DIRS=$(shell cd src && find . -mindepth 1 -type d \! -path "./templates")
DEPS=$(wildcard src/templates/*.html) src/templates/navigation-level-0.html filter.pl make-html.sh make-current-selected.pl
HTML=${patsubst src/%,%,${SRC:.markdown=.html}}

reverse = $(if $(wordlist 2,2,$(1)),$(call reverse,$(wordlist 2,$(words $(1)),$(1))) $(firstword $(1)),$(1))

all: ${DIRS} ${HTML}

inlinescripting: inlinescripting.hs
	ghc inlinescripting.hs

${DIRS}:
	mkdir -p $@

src/templates/navigation-level-0.html: make-navigation.sh make-indexes.py ${DIRS}
	./make-navigation.sh .

${TEMPLATES}:

${HTML}: % : src/${%:.html=.markdown} ${DEPS} inlinescripting
	./make-html.sh src/${*:.html=.markdown} $*

clean:
	rm -f ${HTML} src/templates/navigation-level-*.html inlinescripting inlinescripting.o inlinescripting.hi
	rmdir $(call reverse, ${DIRS} )
