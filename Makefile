SRC=$(shell find src -iname "*.markdown" -exec ls -t {} + )
DIRS=$(shell cd src && find . -mindepth 1 -type d \! -path "./templates")
DEPS=$(wildcard src/templates/*.html) src/templates/navigation-level-0.html lib/filter.pl make-html.sh lib/fix-styles.pl lib/generatedoc
HTML=${patsubst src/%,%,${SRC:.markdown=.html}}

reverse = $(if $(wordlist 2,2,$(1)),$(call reverse,$(wordlist 2,$(words $(1)),$(1))) $(firstword $(1)),$(1))

all: ${DIRS} ${HTML}


lib/generatedoc: lib/generatedoc.hs
	ghc lib/generatedoc.hs

${DIRS}:
	mkdir -p $@

src/templates/navigation-level-0.html: make-navigation.sh make-indexes.py ${DIRS}
	./make-navigation.sh .

${TEMPLATES}:

${HTML}: %.html : src/%.markdown $@ ${DEPS}
	./make-html.sh src/$*.markdown

clean: cleanpages
	rm -f generatedoc generatedoc.o generatedoc.hi

cleanpages:
	rm -f ${HTML} src/templates/navigation-level-*.html 
	rmdir $(call reverse, ${DIRS} )
