set -x
dk s infer -e extraction data/clean/order_details.avro
dk t create -e extraction -t update_extract

# add to transform:
#   month: int(strftime(${orderDate}, '%Y%m'))
#   total: ${quantity} * ${unitPrice}
python code/update_transform.py

# create final dataset
dk r etl \
  -o data/clean/final.avro \
  -t update_extract \
  data/clean/order_details.avro
