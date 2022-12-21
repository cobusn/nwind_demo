set -x
dk r query \
    -v \
    -c mysql \
    --file sql/orders.sql \
    -o data/clean/order_details.avro
