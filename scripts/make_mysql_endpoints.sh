#! /bin/bash
set -x

for TABLE in $(cat tables); do
  dk e add -e $TABLE -c mysql -E $TABLE
done
