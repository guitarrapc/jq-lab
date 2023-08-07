#!/bin/bash
set -ex

ci_on=""
ci_off=""
if [[ "$CI" != "" ]]; then
  ci_on=::group::
  ci_off="::endgroup::"
fi
function ci_off { echo "${ci_off}"; }

echo "--------------------------"
echo "ISO8601 can work with fromdate/todate."
echo "input string: 2022-01-08T20:49:07Z"
echo "--------------------------"
echo "${ci_on}# Time with fromdate."
cat ./_sample.json | jq -r '.created_at_iso8601 | fromdate'
# 1641674947

ci_off
echo "${ci_on}# Time with todate. UTC+0 to JST+9"
cat ./_sample.json | jq -r '.created_at_iso8601 | fromdate + (60 * 60 * 9) | todate'
# 2022-01-09T05:49:07Z

ci_off
echo "--------------------------"
echo "${ci_on}#%f can't work with milliseconds, remove milliseconds and Z."
echo "input string: 2022-01-08T20:49:07.336Z"
echo "--------------------------"
echo "${ci_on}# Time parse with strptime. Month is start from 0"
cat ./_sample.json | jq -r '.created_at | split(".")[0] | strptime("%Y-%m-%dT%H:%M:%S")'
# [
#   2022,
#   0,
#   8,
#   20,
#   49,
#   7,
#   6,
#   7
# ]

ci_off
echo "${ci_on}# Time parse with strptime then strftime"
cat ./_sample.json | jq -r '.created_at | split(".")[0] | strptime("%Y-%m-%dT%H:%M:%S") | strftime("%F %X")'
# 2022-01-08 20:49:07

ci_off
echo "${ci_on}# Time parse with strptime then mktime, showing unixtime"
cat ./_sample.json | jq -r '.created_at | split(".")[0] | strptime("%Y-%m-%dT%H:%M:%S") | mktime'
# 1641707347

ci_off
echo "${ci_on}# Time parse with strptime, then convert from UTF to JST+9, then output to time format."
cat ./_sample.json | jq -r '.created_at | split(".")[0] | strptime("%Y-%m-%dT%H:%M:%S") | mktime + (60 * 60 * 9) | strftime("%F %X")'
# 2022-01-09 05:49:07

ci_off
echo ""
echo "--------------------------"
echo "%Z use local machine time zone, don't use it but use constant zone."
echo "input string: 2022-01-08T20:49:07+0000"
echo "--------------------------"
echo "${ci_on}# Time parse with strptime. Month is start from 0"
cat ./_sample.json | jq -r '.created_at_tz | strptime("%Y-%m-%dT%H:%M:%S +0000")'
# [
#   2022,
#   0,
#   8,
#   20,
#   49,
#   7,
#   6,
#   7
# ]

ci_off
echo "${ci_on}# Time parse with strptime then strftime"
cat ./_sample.json | jq -r '.created_at_tz | strptime("%Y-%m-%dT%H:%M:%S +0000") | strftime("%F %X")'
# 2022-01-08 20:49:07

ci_off
echo "${ci_on}# Time parse with strptime then mktime, showing unixtime"
cat ./_sample.json | jq -r '.created_at_tz | strptime("%Y-%m-%dT%H:%M:%S +0000") | mktime'
# 1641707347

ci_off
echo "${ci_on}# Time parse with strptime, then convert from UTF to JST+9, then output to time format."
cat ./_sample.json | jq -r '.created_at_tz | strptime("%Y-%m-%dT%H:%M:%S +0000") | mktime + (60 * 60 * 9) | strftime("%F %X")'
# 2022-01-09 05:49:07
