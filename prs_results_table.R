#Generates Table 4, significant PRS associations after FDR correction across all tests.

# Set working directory to analysis pipeline folder.
setwd("/exports/eddie/scratch/s2223599/gwas_pipeline")

# Create data frame of PRS association tests, input data manually entered from PRSice-2 summary files.
results <- data.frame(
  Discovery = c(rep("Schizophrenia", 4), rep("Bipolar disorder", 4),
                rep("Cannabis use disorder", 4), rep("ADHD", 4),
                rep("Cognitive ability", 4)),
  Phenotype = rep(c("Total", "Cognitive-perceptual", "Interpersonal", "Disorganisation"), 5),
  Threshold = c(0.1, 0.1, 0.2, 0.5,
                0.4, 0.001, 0.4, 0.1,
                0.001, 0.05, 0.001, 0.001,
                0.2, 0.05, 0.2, 0.2,
                0.4, 0.4, 0.05, 0.1),
  R2 = c(0.000610, 0.000487, 0.000181, 0.001170,
         0.001014, 0.001132, 0.000214, 0.001356,
         0.000872, 0.000982, 0.000626, 0.000206,
         0.004075, 0.004559, 0.001374, 0.002959,
         0.002946, 0.003415, 0.002014, 0.000371),
  Coefficient = c(2337.94, 963.064, 955.838, 1841.84,
                  6588.95, 294.987, 1681.52, 1086.69,
                  -5.862, -12.221, -2.761, -0.776,
                  7221.31, 1894.48, 2329.48, 1676.46,
                  -427.972, -212.402, -65.755, -19.382),
  P = c(0.091, 0.127, 0.362, 0.018,
        0.029, 0.020, 0.322, 0.011,
        0.043, 0.030, 0.090, 0.322,
        1.20e-05, 3.02e-06, 0.012, 1.70e-04,
        1.98e-04, 5.34e-05, 0.00235, 0.184),
  FDR = c(0.121, 0.159, 0.362, 0.040,
          0.050, 0.040, 0.339, 0.030,
          0.066, 0.050, 0.121, 0.339,
          0.0001, 0.0001, 0.030, 0.0008,
          0.0008, 0.0004, 0.0078, 0.217)
)

# Add significance column
results$Significant <- ifelse(results$FDR < 0.05, "Yes", "No")

# Filter significant only
sig_results <- results[results$Significant == "Yes",]

# Format p-values
sig_results$P <- formatC(sig_results$P, format="e", digits=3)
sig_results$FDR <- formatC(sig_results$FDR, format="f", digits=4)
sig_results$R2 <- formatC(sig_results$R2, format="f", digits=5)
sig_results$Coefficient <- round(sig_results$Coefficient, 3)

# Remove significance column from output
sig_results$Significant <- NULL

# Print and save
print(sig_results)
write.csv(sig_results, "data/prs_significant_results_table.csv", row.names=FALSE)
