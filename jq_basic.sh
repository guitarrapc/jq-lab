#!/bin/bash
set -e

echo "# Show buildin functions"
jq -n 'builtins'

echo "# Access to single property. (.prop)"
cat ./_sample.json | jq ".name"
# "John Doe"

echo "# Access to muliple property. (.prop1, .prop2))"
cat ./_sample.json | jq ".name, .age"
# "John Doe"
# 20

echo "# Access to self on pipe. (.prop | .))"
cat ./_sample.json | jq ".name|."
# "John Doe"

echo "# Access to number key property. (.\"prop\")"
cat ./_sample.json | jq '."10"'
# 10

echo "# Convet number to string. (|tostring)"
cat ./_sample.json | jq '."10" | tostring'
# "10"

echo "# Convet string to number. (|tonumer)"
cat ./_sample.json | jq '."10" | tostring | tonumber'
# 10

echo "# Type Match: strings returns string."
cat _sample.json | jq '.complex_data[]|strings'
# "string_data"

echo "# Type Match: numbers retrurns number."
cat _sample.json | jq '.complex_data[]|numbers'
# 42

echo "# Type Match: iterables returns array or object."
cat _sample.json | jq '.complex_data[]|iterables'
# {
#   "a": 1
# }
# [
#   1,
#   23
# ]

echo "# Type Match: arrays returns array"
cat _sample.json | jq '.complex_data[]|arrays'
# [
#   1,
#   23
# ]

echo "# Type Match: objects returns objects"
cat _sample.json | jq '.complex_data[]|objects'
# {
#   "a": 1
# }

echo "# Type Match: booleans returns booleans"
cat _sample.json | jq '.complex_data[]|booleans'
# true

echo "# Type Match: nulls returns nulls"
cat _sample.json | jq '.complex_data[]|nulls'
# null

echo "# Access to property recursively from any level. (..)"
cat _sample.json | jq '..|.id?|strings'
# "abcdefg-12345"
# "bcdefgh-23456"
# "cdefghi-34567"
# "defghij-45678"

echo "# // return valud if error or null value."
cat _sample.json | jq '.multiple[] | select(.== 0) // "not number"'
# 0
# "not number"
