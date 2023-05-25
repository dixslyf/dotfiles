#!/bin/bash

usage() {
  printf "%s\n\n" "usage: $(basename "$0") <user.name> <user.email>"
  printf "%s\n\n" "Configures the \`git\` user name and email."
  exit 1
}

if [ $# -ne 2 ]; then
  usage
else
  git config user.name "$1"
  git config user.email "$2"
fi
