#!/bin/bash
set -e

echo "--------------------------"
echo "ISO8601 can work with fromdate/todate."
echo "input string: 2022-01-08T20:49:07Z"
echo "--------------------------"
echo "# Time with fromdate."
cat ./_sample.json | jq -r '.created_at_iso8601 | fromdate'
# 1641674947

echo "# Time with todate. UTC+0 to JST+9"
cat ./_sample.json | jq -r '.created_at_iso8601 | fromdate + (60 * 60 * 9) | todate'
# 2022-01-09T05:49:07Z

echo "--------------------------"
echo "#%f can't work with milliseconds, remove milliseconds and Z."
echo "input string: 2022-01-08T20:49:07.336Z"
echo "--------------------------"
echo "# Time parse with strptime. Month is start from 0"
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

echo "# Time parse with strptime then strftime"
cat ./_sample.json | jq -r '.created_at | split(".")[0] | strptime("%Y-%m-%dT%H:%M:%S") | strftime("%F %X")'
# 2022-01-08 20:49:07

echo "# Time parse with strptime then mktime, showing unixtime"
cat ./_sample.json | jq -r '.created_at | split(".")[0] | strptime("%Y-%m-%dT%H:%M:%S") | mktime'
# 1641707347

echo "# Time parse with strptime, then convert from UTF to JST+9, then output to time format."
cat ./_sample.json | jq -r '.created_at | split(".")[0] | strptime("%Y-%m-%dT%H:%M:%S") | mktime + (60 * 60 * 9) | strftime("%F %X")'
# 2022-01-09 05:49:07

echo ""
echo "--------------------------"
echo "%Z use local machine time zone, don't use it but use constant zone."
echo "input string: 2022-01-08T20:49:07+0000"
echo "--------------------------"
echo "# Time parse with strptime. Month is start from 0"
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

echo "# Time parse with strptime then strftime"
cat ./_sample.json | jq -r '.created_at_tz | strptime("%Y-%m-%dT%H:%M:%S +0000") | strftime("%F %X")'
# 2022-01-08 20:49:07

echo "# Time parse with strptime then mktime, showing unixtime"
cat ./_sample.json | jq -r '.created_at_tz | strptime("%Y-%m-%dT%H:%M:%S +0000") | mktime'
# 1641707347

echo "# Time parse with strptime, then convert from UTF to JST+9, then output to time format."
cat ./_sample.json | jq -r '.created_at_tz | strptime("%Y-%m-%dT%H:%M:%S +0000") | mktime + (60 * 60 * 9) | strftime("%F %X")'
# 2022-01-09 05:49:07


echo ""
echo "--------------------------"
echo "Dynamic time conversion."
echo "input string: 2022/01/08 20:49:07"
echo "--------------------------"
echo "# JQ each time elements"
cat ./_sample.json | jq '.json_log[] | {type: .data_type, year: .created_at | strptime("%Y/%m/%d %H:%M:%S") | (mktime + (60 * 60 * 9)) | strftime("%Y"), month: .created_at | strptime("%Y/%m/%d %H:%M:%S") | (mktime + (60 * 60 * 9)) | strftime("%m"), day: .created_at | strptime("%Y/%m/%d %H:%M:%S") | (mktime + (60 * 60 * 9)) | strftime("%d"), hour: .created_at | strptime("%Y/%m/%d %H:%M:%S") | (mktime + (60 * 60 * 9)) | strftime("%H")}'

echo "# JQ time parse then split element"
cat ./_sample.json | jq '.json_log[] | {type: .data_type, time: .created_at | strptime("%Y/%m/%d %H:%M:%S") | (mktime + (60 * 60 * 9)) } | {data_type: .type, year: .time | strftime("%Y"), month: .time | strftime("%m"), day: .time | strftime("%d"), hour: .time | strftime("%H")}'
