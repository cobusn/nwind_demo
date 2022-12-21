# create ERD
set -x
dk s export -t dot -o output/erd.dot
dot -Tpdf output/erd.dot -o output/erd.pdf
