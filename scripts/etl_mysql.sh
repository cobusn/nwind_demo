#! /bin/bash
# Extract data from csv and load into mysql
set -x

for TABLE in $(cat tables); do
  dk r etl -v -e ${TABLE} -o ::${TABLE} data/csv/${TABLE}.csv
done
