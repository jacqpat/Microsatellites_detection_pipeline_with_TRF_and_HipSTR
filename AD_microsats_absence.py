import pandas as pd

tsv=r"/PATH/TO/YOUR/TSV/here.tsv"
txt=r"/PATH/TO/YOUR/MICROSATS/positions.txt"
miss_samples=r"/PATH/TO/YOUR/OUTPUT/miss_samples.csv"
df = pd.read_csv(tsv, sep="\t")
targets = pd.read_csv(txt, sep="\t", header=None, names=["CHROM","POS"])
# MISS pour les échantillons
indiv_cols = df.columns[5:] # get only genotype data
missing_counts = (df[indiv_cols] == ".").sum()
total_counts = df[indiv_cols].shape[0]
missing_percent = (missing_counts / total_counts) * 100
print(missing_percent)
# MISS pour les sites
n_indiv = len(indiv_cols)
df["missing_percent"] = (df[indiv_cols] == ".").sum(axis=1) / n_indiv * 100
print(df[["CHROM", "POS", "missing_percent"]])
missing_percent.to_csv(r"C:\Users\pajacques\Documents\Microsat\2025-11-20_HipSTR\Aa_anciens_str_52_SAMPLES_MISS.csv", index=True)
df[["CHROM", "POS", "missing_percent"]].to_csv(r"C:\Users\pajacques\Documents\Microsat\2025-11-20_HipSTR\Aa_anciens_str_52_samples_SITES_MISS.csv", index=False)
filtered = df.merge(targets, on=["CHROM","POS"])
filtered.to_csv(r"C:\Users\pajacques\Documents\Microsat\2025-11-20_HipSTR\Aa_anciens_str_calls_52samples_35SSRs.tsv", sep="\t", index=False)
