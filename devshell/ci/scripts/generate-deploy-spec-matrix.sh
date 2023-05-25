#!/bin/bash

usage() {
  printf "%s\n\n" "usage: $(basename "$0") <flake-url> <deployment-hostnames>"
  printf "%s\n\n" "Prints a JSON array of objects that each correspond to a deploy specification."
  printf "%s\n" "<flake-url> refers to the URL of the target flake."
  printf "%s\n\n" "<deployment-hostnames> should be a JSON array of hostnames, e.g., '[\"alpha\", \"bravo\"]'."
  printf "%s\n" "Each object in the output contains the following keys:"
  printf "  %s\n" "\"hostname\": the hostname the deployment is for, e.g., \"alpha\""
  printf "  %s\n" "\"flake-output\": the flake output path, e.g., \"ci.alpha-deploy-spec\""
  printf "  %s\n" "\"hash-name\": the hash + name of the deploy specification that appears in the store path, e.g., \"4cpf0llp2kq6k2m4zrfgd4v4lfbh7igj-cachix-deploy.json\""
  exit 1
}

CI_ATTR="ci"
CI_SUFFIX_REGEX="\"^$CI_ATTR.\""

# JSON array of the flake outputs under `ci` e.g., `["ci.alpha-deploy-spec","ci.bravo-deploy-spec"]`
ci_outputs_json() {
  nix search "$1#$CI_ATTR" --json |
    jq -rc 'keys_unsorted'
}

if [ $# -eq 1 ] || [ $# -eq 2 ]; then
  # `jq` filter that conceptually takes an element of `ci_outputs_json` and the output of `nix path-info --json <flake-output>` as inputs, and
  # returns the hostname, flake output and hash + name.
  # The hostname and flake output are derived from an element of `ci_outputs_json`,
  # while the hash + name is derived from the output of `nix path-info --json <flake-output>`.
  # Literal single quotes around because arguments passed to `parallel` are expanded by the shell twice
  # shellcheck disable=SC2016
  PATH_INFO_FILTER=\''{ "hostname": ($FLAKE_OUTPUT | sub('"$CI_SUFFIX_REGEX"'; "") | sub("-deploy-spec$"; "")), "flake-output": $FLAKE_OUTPUT, "hash-name": (.[] | .path | sub("/nix/store/"; ""))}'\'

  matrix=$(
    ci_outputs_json "$1" |
      jq -rc '.[]' |
      parallel nix path-info "$1#{}" --json '|' jq -c --arg FLAKE_OUTPUT '{}' "$PATH_INFO_FILTER" |
      jq -sc # Combine the JSON objects into an array
  )

  # Only build hosts to be deployed, if deploying
  if [ -n "$2" ]; then
    matrix=$(jq -c --argjson deployments "$2" 'map(select(.hostname | IN($deployments[])))' <<<"$matrix")
  fi

  printf '%s' "$matrix"
else
  usage
fi
