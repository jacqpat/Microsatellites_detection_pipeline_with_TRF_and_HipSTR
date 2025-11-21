#!/bin/bash

# How to use:
# AD_vcf2tsv.sh > /YOUR/TSV/output.tsv
VCF="/YOUR/HIPSTR/output.vcf.gz"
TXT="./samples_names.txt"
printf "CHROM\tPOS\tID\tREF\tALT"
while read s
do
  printf "\t%s" "$s"
done < $TXT
printf "\n"
bcftools query -f '%CHROM\t%POS\t%ID\t%REF\t%ALT[\t%GT]\n' $VCF
