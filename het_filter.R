# Heterozygosity outlier removal
# Based on Marees et al. (2018) https://doi.org/10.1002/mpr.1608 GitHub tutorial: https://github.com/MareesAT/GWA_tutorial
# Removes individuals more than 3 SD from the mean heterozygosity rate
het <- read.table("qc/GS_het.het", head=TRUE)

# Calculate heterozygosity rate: (total SNPs - homozygous SNPs) / total SNPs
het$HET_RATE <- (het$N.NM. - het$O.HOM.) / het$N.NM.

# Identify individuals more than 3 SD from the mean
het_fail <- subset(het, (het$HET_RATE < mean(het$HET_RATE) - 3*sd(het$HET_RATE)) | 
                        (het$HET_RATE > mean(het$HET_RATE) + 3*sd(het$HET_RATE)))

# Write list of individuals to remove
write.table(het_fail[,c(1,2)], "qc/samples_to_remove.txt", row.names=FALSE, col.names=FALSE, quote=FALSE)
