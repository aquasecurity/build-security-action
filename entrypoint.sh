#!/bin/bash

set -e

# configure Trivy to use the aqua plugin

if [ -n "${INPUT_AQUA_CSPM_URL}" ]; then
  export CSPM_URL=${INPUT_AQUA_CSPM_URL}
fi

if [ -n "${INPUT_AQUA_API_URL}" ]; then
  export AQUA_URL=${INPUT_AQUA_API_URL}
fi

# if GITHUB_WORKSPACE is defined, move to it
if [ -n "${GITHUB_WORKSPACE}" ]; then
  cd "${GITHUB_WORKSPACE}" || exit
fi

# check if any custom build name has been specified
BUILD=${INPUT_BUILD:-GitHubAction}

# Execute Trivy
export TRIVY_RUN_AS_PLUGIN=aqua
trivy iac --tags "system:github" \
          --tags "build:${BUILD}" \
          --tags "repository:${GITHUB_REPOSITORY}" \
          --tags "branch:${GITHUB_REF_NAME}" \
          --tags "git_user:${GITHUB_ACTOR}" \
          --aqua-key "${INPUT_AQUA_KEY}" \
          --aqua-secret "${INPUT_AQUA_SECRET}" \
          "${GITHUB_WORKSPACE}"
