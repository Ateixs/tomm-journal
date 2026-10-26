#!/usr/bin/env bash
# Build every fig_*.tex (or the ones given) with XeLaTeX and write PNG previews.
set -u
cd "$(dirname "$0")"
mkdir -p preview logs
files=("$@"); [ ${#files[@]} -eq 0 ] && files=(fig[0-9]*.tex)
for f in "${files[@]}"; do
  b="${f%.tex}"
  if xelatex -interaction=nonstopmode -halt-on-error "$f" > "logs/$b.log" 2>&1; then
    size=$(pdfinfo "$b.pdf" | awk '/Page size/{printf "%.1f x %.1f mm", $3*0.3528, $5*0.3528}')
    pdftoppm -r 220 -png -singlefile "$b.pdf" "preview/$b"
    warn=$(grep -c -E "Overfull|Missing character" "logs/$b.log")
    echo "OK   $b  ($size, warnings: $warn)"
  else
    echo "FAIL $b"; grep -E "^!" -A3 "logs/$b.log" | head -8
  fi
done
rm -f *.aux
