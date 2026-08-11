# Generates Table 1, summarising quality control steps.

# Set working directory to analysis pipeline folder.
setwd("/exports/eddie/scratch/xxxxxxxx/gwas_pipeline")

# Create QC summary table.
qc_table <- data.frame(
  Step = c(
    "Starting dataset",
    "Triallelic exclusion",
    "Keep list applied",
    "Sample missingness",
    "SNP missingness",
    "Hardy-Weinberg equilibrium",
    "Minor allele frequency",
    "Heterozygosity outliers",
    "Final dataset"
  ),
  Filter = c(
    "—",
    "MAF > 2 alleles excluded",
    "One SPQ-B completer per family",
    "Individual missingness > 5%",
    "SNP missingness > 5%",
    "p < 1x10-6",
    "MAF < 0.01",
    "±3 SD from mean",
    "—"
  ),
  SNPs_Removed = c(
    "—",
    "99,858",
    "—",
    "—",
    "0",
    "22",
    "16,462,624",
    "—",
    "—"
  ),
  SNPs_Remaining = c(
    "24,161,581",
    "24,061,723",
    "24,061,723",
    "24,061,723",
    "24,061,723",
    "24,061,701",
    "7,599,077",
    "7,599,077",
    "7,599,077"
  ),
  Individuals_Remaining = c(
    "20,019",
    "20,019",
    "4,619",
    "4,619",
    "4,619",
    "4,619",
    "4,619",
    "4,583",
    "4,583"
  )
)

print(qc_table)
write.csv(qc_table, 
  "data/qc_summary_table.csv", 
  row.names=FALSE)
