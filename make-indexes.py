#!/usr/bin/env python
import sys
import re

strip_prefix = sys.argv[1]
files = []

for path in sys.stdin: 
  path = path[:-1]
  relativepath = path[len(strip_prefix):]
  parts = relativepath.split("/")
  filename = parts[-1]
  isIndex = filename.lower() == 'index.markdown'

  depth = len(parts)
  if isIndex:
    depth -= 1
  
  contents = open(path).read()
    
  titleMatch = re.search(r"^%\s*(.*)[^\n]*", contents)
  if titleMatch:
    title = titleMatch.groups()[0] 
  else:
    title = re.sub("\.markdown$", "", filename)
  
  if isIndex:
    ordering = 0
  else: 
    orderMatch = re.search(r"<!-- *order: *([0-9]+) *-->", contents)
    ordering = int(orderMatch.groups()[0]) if orderMatch else sys.maxint

  files.append(("/".join(parts[:-1]),ordering,title,filename,depth))

files.sort()

for (path, ordering, title, filename, depth) in files:
  filename = re.sub(r"\.markdown$", ".html", filename)
  path += filename if path == "" else "/" + filename
  print "%s* [%s](%s)" % (depth*"\t", title, path)
