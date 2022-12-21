set -x
dk x plot \
  -x month \
  -y total \
  --title "By Month" \
  --type line \
  data/clean/by_month.avro 
  # -o by_month.pdf \
  # --script gp.plt \
