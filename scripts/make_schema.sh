# !/bin/bash

for TABLE in $(cat tables); do
  echo $table
  dk s infer -v -e ${TABLE} data/csv/${TABLE}.csv
done
