set -x

# summarize by month
dk r agg \
  -g month \
  --sum total:total \
  --sort month \
  -o data/clean/by_month.avro \
  data/clean/final.avro 

# summarise by productName
dk r agg \
  -g productName \
  --count total:count \
  --sum total:total \
  --sort total \
  --reversed \
  -o data/clean/by_product.avro \
  data/clean/final.avro 

# summarise by order 
dk r agg \
  -g orderID \
  --count total:count \
  --sum total:total \
  --sort total \
  --reversed \
  -o data/clean/by_order_id.avro \
  data/clean/final.avro 

