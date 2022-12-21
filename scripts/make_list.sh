set -x
# make list of tables from csv filenames
for F in data/csv/*.csv; do
  n=${F%.csv} 
  echo ${n##*/} >> tables
done
