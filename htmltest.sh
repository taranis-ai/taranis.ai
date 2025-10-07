#!/usr/bin/env bash

set -e

echo "Building Hugo site to temporary directory..."
hugo build
echo "Running HTMLTest..."
htmltest -c .htmltest.yml -s public
