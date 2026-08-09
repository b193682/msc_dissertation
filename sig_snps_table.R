# Generated Table 3, significant SNPs identified for the disorganisation dimension of schizotypy in GS

# Set working directory to analysis pipeline folder
setwd("exports/eddie/scratch/s2223599/gwas_pipeline")

# Create data frame of genome-wide significant SNPs, input data manually entered from GWAS disorg output.
sig_snps <- data.frame(
  SNP = c("6_139854568_T_A", "10_55394932_C_T", "10_55541259_C_T",
          "10_55587065_T_C", "10_55660369_C_T"),
  RS = c("rs112569372", "rs78408999", "rs147694207",
         "rs45466098", "rs117659869"),
  CHR = c(6, 10, 10, 10, 10),
  BP = c(139854568, 55394932, 55541259, 55587065, 55660369),
  A1 = c("A", "T", "T", "C", "T"),
  BETA = c(0.4895, 0.4630, 0.4528, 0.5976, 0.5931),
  BETA_ADJ = c(0.0440, 0.03200, 0.0338, 0.5435, 0.5252),
  P = c(2.263e-08, 4.399e-08, 3.416e-08, 1.73e-10, 3.309e-10),
  MAF = c(0.0144, 0.0155, 0.0165, 0.0126, 0.0123),
  Annotation = c("Intergenic", "Intergenic", "Intergenic",
                 "PCDH15 intronic", "PCDH15 intronic")
)

# Sort by ascending p-value
sig_snps <- sig_snps[order(sig_snps$P),]

# Columns are rounded to 4 decimal places
sig_snps$P <- formatC(sig_snps$P, format="e", digits=3)
sig_snps$BETA <- round(sig_snps$BETA, 4)
sig_snps$MAF <- round(sig_snps$MAF, 4)

print(sig_snps)
write.csv(sig_snps, "data/significant_snps_final_table.csv", row.names=FALSE)
