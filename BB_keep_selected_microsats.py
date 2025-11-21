import pandas as pd

tsv=r"/PATH/TO/YOUR/GENOME/matrix.tsv"
ssr=r"/PATH/TO/YOUR/SELECTED/microsats.tsv"
out=r"/PATH/TO/YOUR/FILTERED/genome_matrix.tsv"
df = pd.read_csv(tsv, sep="\t")
targets = pd.read_csv(ssr, sep="\t", header=None, names=["CHROM","POS"])
filtered = df.merge(targets, on=["CHROM","POS"])
filtered.to_csv(out, sep="\t", index=False)
