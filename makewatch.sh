#!/bin/bash

while 
  find src *.pl *.py *.sh Makefile -not -iname ".*" -print0 \
  | xargs -0 inotifywait -e close_write -e moved_to | true; do
  make
done
