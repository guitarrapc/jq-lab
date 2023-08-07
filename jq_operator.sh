#!/bin/bash
set -ex

echo "# + operator"
cat ./_sample.json | jq ".numbers[] | .+ 1"
# 1
# 2
# 3
# 4

echo "# - operator"
cat ./_sample.json | jq ".numbers[] | .- 1"
# -1
# 0
# 1
# 2

echo "# * operator"
cat ./_sample.json | jq ".numbers[] | .* 2"
# 0
# 2
# 4
# 6

echo "# / operator"
cat ./_sample.json | jq ".numbers[] | ./ 2"
# 0
# 0.5
# 1
# 1.5

echo "# % operator"
cat ./_sample.json | jq ".numbers[] | .% 2"
# 0
# 1
# 0
# 1

echo "# == opeerator"
cat ./_sample.json | jq ".numbers[] | {(.|tostring + \"==2\"):(. == 2)}"
# {
#   "0==2": false
# }
# {
#   "1==2": false
# }
# {
#   "2==2": true
# }
# {
#   "3==2": false
# }

echo "# != opeerator"
cat ./_sample.json | jq ".numbers[] | {(.|tostring + \"!=2\"):(. != 2)}"
# {
#   "0!=2": true
# }
# {
#   "1!=2": true
# }
# {
#   "2!=2": false
# }
# {
#   "3!=2": true
# }

echo "# > opeerator"
cat ./_sample.json | jq ".numbers[] | {(.|tostring + \">2\"):(. > 2)}"
# {
#   "0>2": false
# }
# {
#   "1>2": false
# }
# {
#   "2>2": false
# }
# {
#   "3>2": true
# }

echo "# >= opeerator"
cat ./_sample.json | jq ".numbers[] | {(.|tostring + \">=2\"):(. >= 2)}"
# {
#   "0>=2": false
# }
# {
#   "1>=2": false
# }
# {
#   "2>=2": true
# }
# {
#   "3>=2": true
# }

echo "# < opeerator"
cat ./_sample.json | jq ".numbers[] | {(.|tostring + \"<2\"):(. < 2)}"
# {
#   "0<2": true
# }
# {
#   "1<2": true
# }
# {
#   "2<2": false
# }
# {
#   "3<2": false
# }

echo "# <= opeerator"
cat ./_sample.json | jq ".numbers[] | {(.|tostring + \"<=2\"):(. <= 2)}"
# {
#   "0<=2": true
# }
# {
#   "1<=2": true
# }
# {
#   "2<=2": true
# }
# {
#   "3<=2": false
# }


echo "# and opeerator"
cat ./_sample.json | jq ".numbers[] | {(\"2 >= \" + (.|tostring) + \" < 3\"):(. >= 2 and . < 3)}"
# {
#   "2 >= 0 < 3": false
# }
# {
#   "2 >= 1 < 3": false
# }
# {
#   "2 >= 2 < 3": true
# }
# {
#   "2 >= 3 < 3": false
# }

echo "# or opeerator"
cat ./_sample.json | jq ".numbers[] | {(\"3 >= \" + (.|tostring) + \" <= 0\"):(. >= 3 or . <= 0)}"
# {
#   "3 >= 0 <= 0": true
# }
# {
#   "3 >= 1 <= 0": false
# }
# {
#   "3 >= 2 <= 0": false
# }
# {
#   "3 >= 3 <= 0": true
# }

echo "# not opeerator"
cat ./_sample.json | jq ".numbers[] | {(\"not \" + (.|tostring) + \" < 2\"):(. < 2|not)}"
# {
#   "not 0 < 2": false
# }
# {
#   "not 1 < 2": false
# }
# {
#   "not 2 < 2": true
# }
# {
#   "not 3 < 2": true
# }
