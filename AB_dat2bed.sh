#!/bin/bash
# Usage: ./trf2bed.sh input.dat > output.bed
# Works with TRF -ngs compact output
# first step: Header lines start with "@" so we remove it
# second step: we convert the second line into something good for BED
awk '
BEGIN { OFS="\t" }
/^@/ {
  split($0, a, " ")
  contig = substr(a[1], 2)   # remove leading "@"
  next
}
{
  start = $1 - 1  # BED is 0-based, TRF is 1-based
  end   = $2      # BED is 0-based, but ending is EXCLUSIVE.
  period = $3
  copies = $4
  motif  = ${14}    # motif string
  print contig, start, end, motif, period, copies
}
' "$1"  
