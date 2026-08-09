# Applies winner's curse sensitivity analysis to significant SNP effect sizes from disorganisation GWAS.
# Based on Approximate conditional likelihood method detailed in Ghosh et al. (2008) and Zhong and Prentice (2008).
# Code is adapted from https://cloufield.github.io/GWASTutorial/15_winners_curse/#implementation-in-r 
WC_correction <- function(BETA, SE, alpha=5e-8){

# Calculate z-score cutpoint
  Q <- qchisq(alpha, df=1, lower.tail=FALSE)
  c <- sqrt(Q)
# Bias function
  bias <- function(betaTrue, betaObs, se){
    z <- betaTrue / se
    num <- dnorm(z - c) - dnorm(-z - c)
    den <- pnorm(z - c) + pnorm(-z - c)
    return(betaObs - betaTrue - se * num / den)
  }
# Solve for true beta
  solveBetaTrue <- function(betaObs, se){
    result <- uniroot(
      f = function(b) bias(b, betaObs, se),
      lower = -100,
      upper = 100
    )
    return(result$root)
  }
# Apply correction to all variants
  BETA_corrected <- sapply(
    1:length(BETA),
    function(i) solveBetaTrue(BETA[i], SE[i])
  )
  return(BETA_corrected)
}
# Create data frame of significant SNPs and apply correction
sig_snps <- data.frame(
  RS = c("rs45466098", "rs117659869", "rs112569372",
         "rs147694207", "rs78408999"),
  BETA = c(0.5976, 0.5931, 0.4895, 0.4528, 0.4630),
  SE = c(0.0934, 0.0942, 0.0874, 0.0819, 0.0845)
)

sig_snps$BETA_corrected <- WC_correction(
  BETA = sig_snps$BETA,
  SE = sig_snps$SE
)

sig_snps$bias <- sig_snps$BETA - sig_snps$BETA_corrected
sig_snps$pct_reduction <- (sig_snps$bias / sig_snps$BETA) * 100

print(sig_snps)
write.csv(sig_snps, 
  "/exports/eddie/scratch/s2223599/gwas_pipeline/data/winners_curse_corrected.csv",
  row.names=FALSE)
