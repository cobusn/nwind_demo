set -x 

# create final schema
dk s infer -v -e final_orders data/clean/final.avro

# run Etl JOB
python code/etl_main.py data/clean/final.avro

# listing
aws s3 --profile personal ls s3://northwind.db/orders/
aws s3 --profile personal ls s3://northwind.db/orders/month=199612/
