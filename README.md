# Microsatellites_detection_pipeline_with_TRF_and_HipSTR

## Phase 1: Discover Microsatellites with TRFinder

### Step A: Extracting panel of Microsatellites from Reference Genome (Tandem Repeat Finder)

`trf [Fasta] [Match] [Mismatch] [Delta] [PM] [PI] [Minscore] [MaxPeriod] -l [int] -f -h -ngs`
with:
- fasta: the FASTA file we'll mask.
- Match: the Matching Weight
- Mismatch: the Mismatching Penalty
- Delta: the Indel Penalty
- PM: the Match Probability
- PI: the Indel Probability
- Minscore: the Minimum Alignment Score to report
- MaxPeriod: the Maximum Period Size to report
- -l: the maximum TR length expected (in millions) (eg, -l 3 or -l=3 for 3 million)
- -f: Output flanking sequences
- -h: suppress HTML output
- -ngs: Compact .DAT output

For this pipeline, we took the parameters used by [McComish et al. (2024)](https://academic.oup.com/gbe/article/16/3/evae017/7614887).
- match weight 2
- mismatch weight 7
- indel weight 7
- matching probability 80
- indel probability 10
- minimum alignment score 18
- maximum period size 6

The output is a .DAT format file, detailed [...] with the following entries:
- Indices of the repeat relative to the start of the sequence
- Period size of the repeat
- Number of copies aligned with the consensus pattern
- Size of consensus pattern (may differ slightly from the period size)
- Percent of matches between adjacent copies overall
- Percent of indels between adjacent copies overall
- Alignment score
- Percent composition for each of the four nucleotides
- Entropy measure based on percent composition
- The Microsatellite's pattern
- The Microsatellite's repeated pattern
- The Microsatellite's flanking sequences

With entries looking like:

`@NC_049201.1 Anguilla anguilla isolate fAngAng1 chromosome 1, fAngAng1.pri, whole genome shotgun sequence`

`3053 3073 4 5.2 4 100 0 42 28 23 23 23 2.00 AGCT AGCTAGCTAGCTAGCTAGCTA AACCGCACAGTCACAAATAATATTGTGGCGATCCTGACAAAGACTAAGCA AGCTGCAAAGCAATGTGGGGGGGGGGGGGGGGGGGGGTTTGCATGAAATG`

Note: HipSTR does not take as input the compressed .DAT format, so we convert it to a BED file with `AB_dat2bed.sh` 
### Step B: Finding Microsatellites in BAM files (HipSTR)

[HipSTR](https://hipstr-tool.github.io/HipSTR/) is a tool that was developped to obtain more robust STR genotypes by dealing with alignment errors and PCR stutter errors. It does so mainly by:
- Learning locus-specific PCR stutter models using an [EM algorithm](https://en.wikipedia.org/wiki/Expectation%E2%80%93maximization_algorithm)
- Mining candidate STR alleles from population-scale sequencing data
- Employing a specialized hidden Markov model to align reads to candidate alleles while accounting for STR artifacts
- Utilizing phased SNP haplotypes to genotype and phase STRs

Depending on scenario, HipSTR require different set of parameters and options. Please refer to their documentation for further information. In our case, we used De Novo stutter estimation + STR calling with De Novo allele generation.

`HipSTR --bam-files [TXT] --fasta [REF] --regions [BED] --str-vcf [OUT]`
