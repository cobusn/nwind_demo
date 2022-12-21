#! /bin/bash
# drop tables
set -x

for TABLE in $(cat tables); do
  dk r query -c mysql --query "drop table $TABLE;"
done
