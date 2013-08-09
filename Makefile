SRC=$(wildcard src/*.markdown)
DEPS=src/templates/header.html src/templates/after.html filter.pl
HTML=${patsubst src/%,%,${SRC:.markdown=.html}}

all: ${HTML}

src/templates/non-index-before.html: src/templates/before.html
	echo '<div class=\"top-nav\"><a href=\"index.html\">← index</a></div>' | \
	cat $< - > $@

index.html: src/index.markdown ${DEPS} src/templates/before.html
	./make-html.sh $< src/templates/before.html > $@

%.html: src/%.markdown ${DEPS} src/templates/non-index-before.html
	./make-html.sh $< src/templates/non-index-before.html > $@

clean:
	rm -f *.html
	rm -f src/templates/non-index-before.html
