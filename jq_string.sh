#!/bin/bash
set -e

echo "# String value contains '\"'."
cat ./_sample.json | jq ".name"
# "John Doe"

echo "# -r remove '\"' from string value."
cat ./_sample.json | jq -r ".name"
# John Doe
