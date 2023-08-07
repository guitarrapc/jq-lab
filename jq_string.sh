#!/bin/bash
set -e

echo "# select property contains '\"'."
echo "{\"message\": \"foobar\"}" | jq ".message"

echo "# -r remove '\"' from result."
echo "{\"message\": \"foobar\"}" | jq -r ".message"
