#!/bin/bash
set -ex

ci_on=""
ci_off=""
if [[ "$CI" != "" ]]; then
  ci_on=::group::
  ci_off="::endgroup::"
fi
function ci_off { echo "${ci_off}"; }

echo "${ci_on}# Show buildin functions"
jq -n 'builtins'

ci_off
echo "${ci_on}# Access to single property. (.prop)"
cat ./_sample.json | jq ".name"
# "John Doe"

ci_off
echo "${ci_on}# String output without quote \"\". (-r .prop)"
cat ./_sample.json | jq -r ".name"
# "John Doe"

ci_off
echo "${ci_on}# Access to muliple property. (.prop1, .prop2))"
cat ./_sample.json | jq ".name, .age"
# "John Doe"
# 20

ci_off
echo "${ci_on}# Access to self on pipe. (.prop | .))"
cat ./_sample.json | jq ".name|."
# "John Doe"

ci_off
echo "${ci_on}# Access to number key property. (.\"prop\")"
cat ./_sample.json | jq '."10"'
# 10

ci_off
echo "${ci_on}# Convet number to string. (|tostring)"
cat ./_sample.json | jq '."10" | tostring'
# "10"

ci_off
echo "${ci_on}# Convet string to number. (|tonumer)"
cat ./_sample.json | jq '."10" | tostring | tonumber'
# 10

ci_off
echo "${ci_on}# Type Match: strings returns string."
cat _sample.json | jq '.complex_data[]|strings'
# "string_data"

ci_off
echo "${ci_on}# Type Match: numbers retrurns number."
cat _sample.json | jq '.complex_data[]|numbers'
# 42

ci_off
echo "${ci_on}# Type Match: iterables returns array or object."
cat _sample.json | jq '.complex_data[]|iterables'
# {
#   "a": 1
# }
# [
#   1,
#   23
# ]

ci_off
echo "${ci_on}# Type Match: arrays returns array"
cat _sample.json | jq '.complex_data[]|arrays'
# [
#   1,
#   23
# ]

ci_off
echo "${ci_on}# Type Match: objects returns objects"
cat _sample.json | jq '.complex_data[]|objects'
# {
#   "a": 1
# }

ci_off
echo "${ci_on}# Type Match: booleans returns booleans"
cat _sample.json | jq '.complex_data[]|booleans'
# true

ci_off
echo "${ci_on}# Type Match: nulls returns nulls"
cat _sample.json | jq '.complex_data[]|nulls'
# null

ci_off
echo "${ci_on}# Access to property recursively from any level. (..)"
cat _sample.json | jq '..|.id?|strings'
# "abcdefg-12345"
# "bcdefgh-23456"
# "cdefghi-34567"
# "defghij-45678"

ci_off
echo "${ci_on}# // return valud if error or null value."
cat _sample.json | jq '.multiple[] | select(.== 0) // "not number"'
# 0
# "not number"
