#!/bin/bash

usage() {
  printf "%s\n\n" "usage: $(basename "$0") <source-files...>"
  printf "%s\n\n" "Prints a JSON array of objects that each correspond to an \`npins\` source."
  printf "%s\n\n" "Each value in <source-files...> should be a path to an \`npins\` \`sources.json\` file."
  printf "%s\n" "Each object in the output contains the following keys:"
  printf "  %s\n" "\"name\": the name of the pin as per its entry in its \`sources.json\`"
  printf "  %s\n" "\"sources-file\": the path to the \`sources.json\` file that contains the pin"
  exit 1
}

if [ $# -eq 0 ]; then
  usage
else
  jq -sc 'map(.pins | keys_unsorted | { name: .[], "sources-file": input_filename })' "$@"
fi
