#!/bin/bash

#Usage: HipSTR --bams <list_of_bams> --fasta <genome.fa> --regions <region_file.bed> --str-vcf <str_gts.vcf.gz> [OPTIONS]
#Required parameters:
#--bams <list_of_bams>        Comma separated list of BAM/CRAM files. Either --bams or --bam-files must be specified
#--fasta <genome.fa>          FASTA file containing all of the relevant sequences for your organism
#                             When analyzing CRAMs, this FASTA file must match the file used for compression
#--regions <region_file.bed>  BED file containing coordinates for each STR region
#--str-vcf <str_gts.vcf.gz>   Bgzipped VCF file to which STR genotypes will be written
#Optional input parameters:
#--bam-files <bam_files.txt>  File containing BAM/CRAM files to analyze, one per line
txt="/YOUR/LIST/OF/BAMs.txt"
ref="/YOUR/REF/genome.fa"
bed="/YOUR/TRF/microsats.bed"
out="/YOUR/OUTPUT.vcf.gz"
HipSTR --bam-files $txt --fasta $ref --regions $bed --str-vcf $out
