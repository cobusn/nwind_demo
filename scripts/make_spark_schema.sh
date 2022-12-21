# create ERD
set -x
dk s export \
  -t spark \
  -o output/sprk_schema.py
