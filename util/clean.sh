set -x 
rm -f data/clean/*
rm -f output/*
sh util/drop_mysql_tables.sh
rm -f tables
rm model.yml model.yml.bak
