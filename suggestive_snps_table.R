# Generates Table 2, lead suggestive SNPs (p < 1x10-5) for non-significant schizotypy phenotypes.

# Set working directory to analysis pipeline folder
setwd("/exports/eddie/scratch/xxxxxxxx/gwas_pipeline")

#Create data frame for table, input data are from GWAS summary files, rs numbers from hrcmerge.txt (HRC reference panel) from Nagy et al. (2017). 
suggestive_snps <- data.frame(
  Phenotype = c("Total score", "Cognitive-perceptual", "Interpersonal"),
  RS = c("rs182679383", "rs138743013", "rs786415"),
  CHR = c(1, 13, 2),
  BP = c(108892149, 87698753, 44699075),
  A1 = c("A", "T", "T"),
  BETA = c(2.015, 0.733, -0.463),
  P = c(1.819e-07, 1.299e-07, 1.515e-07),
  Annotation = c("LOC124905416 intronic",
                 "LOC105370301 intronic",
                 "CAMKMT intronic")
)

# Format columns for scientific notation and round to 4 decimal places
suggestive_snps$P <- formatC(suggestive_snps$P, format="e", digits=4)
suggestive_snps$BETA <- round(suggestive_snps$BETA, 4)

print(suggestive_snps)
write.csv(suggestive_snps,
  "data/suggestive_snps_table.csv",
  row.names=FALSE)
