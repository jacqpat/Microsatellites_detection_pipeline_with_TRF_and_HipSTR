#!/bin/bash

folder="/YOUR/FOLDER/PATH"
for fa in $folder/*.fa
do
# One output per FASTA file in folder
# trf file Match Mismatch Delta PM PI Minscore MaxPeriod
  echo $fa
  bsname=$(basename -- $fa)
  bsn=${bsname%.*}
  trf $fa 2 7 7 80 10 18 6 -l 1 -f -h -ngs | tee $bsn.dat
  # Match: matching weight
  # Mismatch: mismatching penalty
  # Delta: indel penalty
  # PM: match probability
  # PI: indel probability
  # Maxperiod: the program will find all repeats with period size between 1 and Maxperiod
  # -l <n> maximum TR length expected (in millions)
  # -ngs compact .dat output
  # -h suppress html output
  # -f flanking sequences
  # tee print the results as they're being saved
done 
