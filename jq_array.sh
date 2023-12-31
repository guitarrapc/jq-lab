#!/bin/bash
set -e

echo "# Array property access. (.prop)"
cat ./_sample.json | jq "strings"
# [
#   "foo1",
#   "bar2",
#   "piyo3",
#   "tiger4",
#   "fuga5"
# ]

echo "# Array property access. (.prop[])"
cat ./_sample.json | jq "strings[]"
# "foo1"
# "bar2"
# "piyo3"
# "tiger4"
# "fuga5"

echo "# Array property index access. (.prop[0])"
cat ./_sample.json | jq "strings[0]"
# "foo1"

echo "# Array property last index access. (.prop[-1])"
cat ./_sample.json | jq "strings[-1]"
# "fuga5"

echo "# Array property range index access. (.prop[2:4])"
cat ./_sample.json | jq "strings[2:4]"
# [
#   "piyo3",
#   "tiger4"
# ]

echo "# Array objects property access. (.prop[])"
cat ./_sample.json | jq ".nested_data[]"
# {
#   "id": "abcdefg-12345",
#   "price": 10
# }
# {
#   "id": "bcdefgh-23456",
#   "price": 1020
# }
# {
#   "id": "cdefghi-34567",
#   "price": 205
# }
# {
#   "id": "defghij-45678",
#   "price": 450302
# }

echo "# Array object property access. (filter1.filter2)"
cat ./_sample.json | jq ".nested_data[].id"
# "abcdefg-12345"
# "bcdefgh-23456"
# "cdefghi-34567"
# "defghij-45678

echo "# Array object property access result in array. ([filter1.filter2])"
cat ./_sample.json | jq "[.nested_data[].id]"
# [
#   "abcdefg-12345",
#   "bcdefgh-23456",
#   "cdefghi-34567",
#   "defghij-45678"
# ]

echo "# Array object property output as object. ({filter})"
cat ./_sample.json | jq "{id: .nested_data[].id}"
# {
#   "id": "abcdefg-12345"
# }
# {
#   "id": "bcdefgh-23456"
# }
# {
#   "id": "cdefghi-34567"
# }
# {
#   "id": "defghij-45678"
# }

echo "# Array object property output as object and pipe. (filter | {filter})"
cat ./_sample.json | jq ".nested_data[] | {id: .id, price: .price}"
# {
#   "id": "abcdefg-12345",
#   "price": 10
# }
# {
#   "id": "bcdefgh-23456",
#   "price": 1020
# }
# {
#   "id": "cdefghi-34567",
#   "price": 205
# }
# {
#   "id": "defghij-45678",
#   "price": 450302
# }

echo "# Array object property output as object key is prop. (filter | {filter})"
cat ./_sample.json | jq ".nested_data[] | {(.id): .price}"
# {
#   "abcdefg-12345": 10
# }
# {
#   "bcdefgh-23456": 1020
# }
# {
#   "cdefghi-34567": 205
# }
# {
#   "defghij-45678": 450302
# }
