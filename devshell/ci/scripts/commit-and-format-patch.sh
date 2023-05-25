#!/bin/bash

usage() {
  printf "%s\n\n" "usage: $(basename "$0") <commit-message> <output-file>"
  printf "%s\n\n" "Commits all current changes with <commit-message> as the commit message and writes a patch to <output-file>."
  exit 1
}

if [ $# -ne 2 ]; then
  usage
else
  git commit -am "$1" && git format-patch -1 HEAD --output "$2"
fi
