#!/usr/bin/env python
import sys
import re
from collections import defaultdict

strip_prefix = sys.argv[1]
directories = defaultdict(list)

def parse_title(contents, filename):
  titleMatch = re.search(r"^%\s*(.*)[^\n]*", contents)
  if titleMatch:
    return titleMatch.groups()[0] 
  else:
    return re.sub("\.markdown$", "", filename)

def parse_ordering(contents, isIndex):
  orderMatch = re.search(r"<!-- *order: *([0-9]+) *-->", contents)
  return int(orderMatch.groups()[0]) if orderMatch else sys.maxint

def get_files(directories, path):
  directory = sorted(directories[path])
  files = []
  for file in directory:
    files.append(file)
    curdir = "/".join(['.']+file[4][:-1])
    if curdir != path:
      files.extend(get_files(directories, curdir))

  return files

for path in sys.stdin: 
  path = path[:-1] #remove newline
  parts = path[len(strip_prefix):].split("/") #remove prefix and get path directory parts
  filename = parts[-1]
  isIndex = filename.lower() == 'index.markdown'

  directory = ["."]
  directory.extend(parts[:-1])
  depth = len(parts)
  if isIndex:
    directory.pop()
    depth -= 1
  directory = "/".join(directory)
  
  contents = open(path).read()
  title    = parse_title(contents, filename) 
  ordering = parse_ordering(contents, isIndex) 

  directories[directory].append((ordering,title,filename,depth, parts))

"""
for d in directories.keys():
  print '"'+d+'"'
  for f in directories[d]:
    print "  "+str(f[2])
"""
files = get_files(directories, '')

for (ordering, title, filename, depth, path) in files:
  path = "/".join(path)
  path = re.sub(r"\.markdown$", ".html", path)
  print "%s* [%s](%s)" % (depth*"\t", title, path)
