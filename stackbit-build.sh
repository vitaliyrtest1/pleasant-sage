#!/usr/bin/env bash

set -e
set -o pipefail
set -v

curl -s -X POST https://dev-api.stackbit.com/project/5dd501930bf2e4001278e648/webhook/build/pull > /dev/null
if [[ -z "${STACKBIT_API_KEY}" ]]; then
    echo "WARNING: No STACKBIT_API_KEY environment variable set, skipping stackbit-pull"
else
    npx @stackbit/stackbit-pull --stackbit-pull-api-url=https://dev-api.stackbit.com/pull/5dd501930bf2e4001278e648 
fi
curl -s -X POST https://dev-api.stackbit.com/project/5dd501930bf2e4001278e648/webhook/build/ssgbuild > /dev/null
jekyll build
curl -s -X POST https://dev-api.stackbit.com/project/5dd501930bf2e4001278e648/webhook/build/publish > /dev/null
