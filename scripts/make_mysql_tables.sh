#! /bin/bash
set -x

for TABLE in $(cat tables); do
  dk e create_sql -E $TABLE
done
