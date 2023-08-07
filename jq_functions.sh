#!/bin/bash
set -e

echo "# select function returns matched. equals 2."
cat ./_sample.json | jq ".numbers[] | select(.==2)"
# 2

echo "# select function returns matched. equals or larger then 2."
cat ./_sample.json | jq ".numbers[] | select(.>=2)"
# 2
# 3

echo "# select function returns matched. less then 2."
cat ./_sample.json | jq ".numbers[] | select(.<2)"
# 0
# 1

echo "# map function accept array input and project array. equals 2."
cat ./_sample.json | jq ".numbers | map(.+1)"
# [
#   1,
#   2,
#   3,
#   4
# ]

echo "# map_values function accepct object and project value. equals 2."
cat ./_sample.json | jq ".objects | map_values(.+1)"
# {
#   "a": 2,
#   "b": 3,
#   "c": 4
# }

echo "# add function accumulate number values."
cat ./_sample.json | jq ".numbers|add"
# 6

echo "# sort function sort array."
cat ./_sample.json | jq "[.nested_data[].price]|sort"
# [
#   10,
#   205,
#   1020,
#   450302
# ]

echo "# reverse function reverse array."
cat ./_sample.json | jq "[.nested_data[].price]|sort|reverse"
# [
#   450302,
#   1020,
#   205,
#   10
# ]

echo "# any function return true when one of item is match OR true."
cat ./_sample.json | jq "[.nested_data[].price]|any(.==10)"
# true

echo "# all function return true when all items is match OR true."
cat ./_sample.json | jq "[.nested_data[].price]|all(.>0)"
# true

echo "# flatten function any dpeth flatten array."
cat ./_sample.json | jq ".nested_array|flatten"
# [
#   1,
#   2,
#   3,
#   4,
#   5
# ]

echo "# flatten function flatten 1 depth array."
cat ./_sample.json | jq ".nested_array|flatten(1)"
# [
#   1,
#   2,
#   3,
#   [
#     4,
#     5
#   ]
# ]

echo "# bsearch function binary search value and return index."
cat ./_sample.json | jq ".numbers|bsearch(2)"
# 2

echo "# length function return length of string."
cat ./_sample.json | jq ".name|length"
# 8

echo "# length function return length of array."
cat ./_sample.json | jq ".numbers|length"
# 4

echo "# length function return length of map."
cat ./_sample.json | jq ".objects|length"
# 3

echo "# utf8bytelength function return length of string in utf bytes, ascii is 1."
cat ./_sample.json | jq ".ascii_letter|utf8bytelength"
# 1

echo "# utf8bytelength function return length of string in utf bytes, latin1 supplement is 2."
cat ./_sample.json | jq ".latin1supplement_letter|utf8bytelength"
# 1

echo "# utf8bytelength function return length of string in utf bytes, most JP is 3."
cat ./_sample.json | jq ".jp_letter|utf8bytelength"
# 3

echo "# utf8bytelength function return length of string in utf bytes, surrogate JP is 4."
cat ./_sample.json | jq ".surrogate_letter|utf8bytelength"
# 4

echo "# getpath function to access property. (getpath([.prop, nexted_prop, nested_nested_prop]))"
cat ./_sample.json | jq "getpath([\"objects\", \"b\"])"
# 2

echo "# setpath function to replace value. (setpath([.prop, nexted_prop, nested_nested_prop]; value))"
cat ./_sample.json | jq "setpath([\"objects\", \"b\"]; 200)" | jq ".objects"
# {
#   "b": 200,
#   "a": 1,
#   "c": 3
# }

echo "# delpaths function to delete value. (delpaths([.prop, nexted_prop, nested_nested_prop]))"
cat ./_sample.json | jq "delpaths([[\"objects\", \"b\"]])" | jq ".objects"
# {
#   "a": 1,
#   "c": 3
# }

echo "# paths function show path to access property. ([paths])"
cat ./_sample.json | jq ".nested_map|[paths]"
# [
#   [
#     "b"
#   ],
#   [
#     "a"
#   ],
#   [
#     "c"
#   ],
#   [
#     "c",
#     "d"
#   ]
# ]

echo "# leaf_paths function show path to access deppest property. ([leaf_paths])"
cat ./_sample.json | jq ".nested_map|[leaf_paths]"
# [
#   [
#     "b"
#   ],
#   [
#     "a"
#   ],
#   [
#     "c",
#     "d"
#   ]
# ]

echo "# keys function get key and sort. (keys)"
cat ./_sample.json | jq ".nested_map|keys"
# [
#   "b",
#   "a",
#   "c"
# ]

echo "# keys function get key and sort. (keys_unsorted)"
cat ./_sample.json | jq ".nested_map|keys_unsorted"
# [
#   "b",
#   "a",
#   "c"
# ]


echo "# has function return true if object has. (has(\"prop\"))"
cat ./_sample.json | jq ".objects|has(\"b\"), has(\"d\")"
# true
# false


echo "# to_entries function project map to {\"key\": key, \"value\": value}. (to_entries)"
cat ./_sample.json | jq ".objects|to_entries"
# [
#   {
#     "key": "a",
#     "value": 1
#   },
#   {
#     "key": "b",
#     "value": 2
#   },
#   {
#     "key": "c",
#     "value": 3
#   }
# ]

echo "# from_entries function project {\"key\": key, \"value\": value} to map. (from_entries)"
cat ./_sample.json | jq ".objects|to_entries|from_entries"
# {
#   "a": 1,
#   "b": 2,
#   "c": 3
# }

echo "# with_entries function operate map's kep and value. (with_entries)"
cat ./_sample.json | jq ".objects|with_entries(.key=\"key_\"+.key|.value=.value*2)"
# {
#   "key_a": 2,
#   "key_b": 4,
#   "key_c": 6
# }
