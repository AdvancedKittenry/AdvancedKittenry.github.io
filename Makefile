SRC=$(shell find src -iname "*.markdown")
DIRS=$(shell cd src && find . -mindepth 1 -type d \! -path "./templates")
DEPS=$(wildcard src/templates/*.html) src/templates/navigation-level-0.html filter.pl make-html.sh
HTML=${patsubst src/%,%,${SRC:.markdown=.html}}

all: ${DIRS} ${HTML}

${DIRS}:
	mkdir -p $@

src/templates/navigation-level-0.html: make-navigation.sh make-indexes.py ${DIRS}
	./make-navigation.sh .

${TEMPLATES}:

${HTML}: % : src/${%:.html=.markdown} ${DEPS}
	./make-html.sh src/${*:.html=.markdown} > $*

clean:
	rm -f ${HTML} src/templates/navigation-level-*.html
	rmdir ${DIRS}
