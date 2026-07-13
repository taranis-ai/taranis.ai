#!/usr/bin/env bash

set -e

export BROWSERSLIST_ROOT_PATH="${BROWSERSLIST_ROOT_PATH:-$PWD}"

echo "Building Hugo site to temporary directory..."
hugo build
echo "Running HTMLTest..."
htmltest -c .htmltest.yml -s public
