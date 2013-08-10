SRC=$(shell find src -iname "*.markdown")
DIRS=$(shell cd src && find . -mindepth 1 -type d \! -path "./templates")
TMPLDIR=src/templates/
DEPS=${TMPLDIR}header.html ${TMPLDIR}after.html filter.pl
HTML=${patsubst src/%,%,${SRC:.markdown=.html}}

all: ${DIRS} ${HTML}

${DIRS}: 
	./make-dir.sh $@

${TMPLDIR}non-index-before.html: ${TMPLDIR}before.html
	echo '<div class="top-nav"><a href="index.html">← index</a></div>' | \
	cat $< - > $@

${HTML}: % : src/${%:.html=.markdown} ${DEPS} ${TMPLDIR}non-index-before.html
	./make-html.sh src/${*:.html=.markdown} ${TMPLDIR}non-index-before.html > $*

#index.html: src/index.markdown ${DEPS} ${TMPLDIR}before.html
#	./make-html.sh $< ${TMPLDIR}before.html > $@

clean:
	rm -f ${HTML}
	rmdir ${DIRS}
	rm -f ${TMPLDIR}non-index-before.html
