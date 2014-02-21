TAG="<\!-- Tags: ([a-zA-Z0-9_-]+,)*$1(,[a-zA-Z0-9_-]+)* -->"
DIR="src/"

function filter {
  while read LINE; do
    FILE=${LINE##*](}
    FILE=${FILE%.html)}.markdown
    if egrep -qi "$TAG" $DIR$FILE; then 
      echo "$LINE"
    fi
  done
}

function putrootlink {
  sed -e "s/](/]({{rootdir}}/"
}

find src/ -iname "*.markdown" \
  | ./make-indexes.py src/ \
  | filter \
  | putrootlink
