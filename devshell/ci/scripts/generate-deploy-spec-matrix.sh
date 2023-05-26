#!/bin/bash

usage() {
  printf "%s\n\n" "usage: $(basename "$0") <flake-url> <deployment-hostnames>"
  printf "%s\n\n" "Prints a JSON array of objects that each correspond to a deploy specification."
  printf "%s\n" "<flake-url> refers to the URL of the target flake."
  printf "%s\n\n" "<deployment-hostnames> should be a JSON array of hostnames, e.g., '[\"alpha\", \"bravo\"]'."
  printf "%s\n" "Each object in the output contains the following keys:"
  printf "  %s\n" "\"hostname\": the hostname the deployment specification is for, e.g., \"alpha\""
  printf "  %s\n" "\"drvPath\": the path to the deploy specification's derivation file, e.g., \"/nix/store/2vw9kybixrpa6ymvpmh8ff1a8fnd07ki-cachix-deploy.json.drv\""
  printf "  %s\n" "\"hashName\": the hash + name that appears in the store path of the deploy specification's derivation file, e.g., \"2vw9kybixrpa6ymvpmh8ff1a8fnd07ki-cachix-deploy.json.drv\""
  exit 1
}

CI_ATTR="ci"

if [ $# -eq 1 ] || [ $# -eq 2 ]; then
  # Use `nix-eval-jobs` to evaluate each job under the `ci` attribute
  matrix=$(
    nix-eval-jobs --flake "$1#$CI_ATTR" |
      jq -sc --arg CI_ATTR "$CI_ATTR" \
        'map({ "hostname": (.attr | sub("-deploy-spec$"; "")), "drvPath": .drvPath, "hashName": (.drvPath | sub("/nix/store/"; "")) })'
  )

  # Only keep the hosts to be deployed, if deploying
  # Ideally, this should be done before or within `nix-eval-jobs` to prevent unnecessary evaluation, but
  # this is blocked by https://github.com/nix-community/nix-eval-jobs/issues/149.
  if [ -n "$2" ]; then
    matrix=$(jq -c --argjson deployments "$2" 'map(select(.hostname | IN($deployments[])))' <<<"$matrix")
  fi

  printf '%s' "$matrix"
else
  usage
fi
