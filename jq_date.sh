#!/bin/bash
set -e

date="2022-01-08T20:49:07.336Z"
echo "--------------------------"
echo "%f can't work with milliseconds, remove milliseconds and Z."
echo "Date string: ${date}"
echo "--------------------------"
echo "# Time with strptime -> array"
echo "{\"created_at\": \"${date}\"}" | jq -r '.created_at | split(".")[0] | strptime("%Y-%m-%dT%H:%M:%S")'
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

echo "# Time with strftime -> string"
echo "{\"created_at\": \"${date}\"}" | jq -r '.created_at | split(".")[0] | strptime("%Y-%m-%dT%H:%M:%S") | strftime("%F %X")'
# 2022-01-08 20:49:07

echo "# Time with mktime -> unixtime"
echo "{\"created_at\": \"${date}\"}" | jq -r '.created_at | split(".")[0] | strptime("%Y-%m-%dT%H:%M:%S") | mktime'
# 1641707347

echo "# Timezone conversion. UTC+0 to JST+9"
echo "{\"created_at\": \"${date}\"}" | jq -r '.created_at | split(".")[0] | strptime("%Y-%m-%dT%H:%M:%S") | mktime + (60 * 60 * 9) | strftime("%F %X")'
# 2022-01-09 05:49:07


dateZ="2022-01-08T20:49:07+0000"
echo ""
echo "--------------------------"
echo "%Z use local machine time zone, don't use it but use constant zone."
echo "Date string: ${dateZ}"
echo "--------------------------"
echo "# Time with strptime -> array"
echo "{\"created_at\": \"${dateZ}\"}" | jq -r '.created_at | strptime("%Y-%m-%dT%H:%M:%S +0000")'
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

echo "# Time with strftime -> string"
echo "{\"created_at\": \"${dateZ}\"}" | jq -r '.created_at | strptime("%Y-%m-%dT%H:%M:%S +0000") | strftime("%F %X")'
# 2022-01-08 20:49:07

echo "# Time with mktime -> unixtime"
echo "{\"created_at\": \"${dateZ}\"}" | jq -r '.created_at | strptime("%Y-%m-%dT%H:%M:%S +0000") | mktime'
# 1641707347

echo "# Timezone conversion. UTC+0 to JST+9"
echo "{\"created_at\": \"${dateZ}\"}" | jq -r '.created_at | strptime("%Y-%m-%dT%H:%M:%S +0000") | mktime + (60 * 60 * 9) | strftime("%F %X")'
# 2022-01-09 05:49:07
