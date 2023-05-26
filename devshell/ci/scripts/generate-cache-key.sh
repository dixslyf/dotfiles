#!/bin/bash

usage() {
  printf "%s\n\n" "usage: $(basename "$0")"
  printf "%s\n\n" "Reads the output of \`generate-deploy-spec-matrix.sh\` from \`stdin\`, and returns a cache key."
  exit 1
}

generate_key() {
  jq -c 'map(.hashName | sub("-cachix-deploy.json.drv$"; "")) | join("")'
}

if [ $# -eq 0 ]; then
  generate_key <"/dev/stdin"
else
  usage
fi
