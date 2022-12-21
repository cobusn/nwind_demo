set -e
sh scripts/create_model.sh
sh scripts/make_list.sh

# build schema and relationships
sh scripts/make_schema.sh
sh scripts/grep_fields.sh
sh scripts/make_relationships.sh
sh scripts/make_erd.sh
sh scripts/do_structure.sh
sh scripts/make_spark_schema.sh

# create mysql tables
python code/update_schema.py
sh scripts/make_mysql_connection.sh
sh scripts/make_mysql_endpoints.sh
sh scripts/make_mysql_tables.sh
sh scripts/etl_mysql.sh

# extract data for analysis
sh scripts/extract_data.sh
sh scripts/create_transform.sh 
### dk x head data/clean/final.avro

# basic exploration
sh scripts/agg.sh
sh scripts/plot_by_month.sh
sh scripts/plot_histogram.sh
sh scripts/summary_order.sh

# main etl
sh scripts/etl_s3.sh
