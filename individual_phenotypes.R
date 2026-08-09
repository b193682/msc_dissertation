# Convert SPQ CSV to phenotype files compatible with PLINK
spq <- read.csv("data/spq.csv")

# Add FID and IID columns
total <- data.frame(FID = spq$ID, IID = spq$ID, PHENO = spq$total)
cogper <- data.frame(FID = spq$ID, IID = spq$ID, PHENO = spq$cogper)
inter <- data.frame(FID = spq$ID, IID = spq$ID, PHENO = spq$inter)
disorg <- data.frame(FID = spq$ID, IID = spq$ID, PHENO = spq$disorg)

# Write phenotype files
write.table(total, "data/pheno_total.txt", row.names=FALSE, col.names=FALSE, quote=FALSE)
write.table(cogper, "data/pheno_cogper.txt", row.names=FALSE, col.names=FALSE, quote=FALSE)
write.table(inter, "data/pheno_inter.txt", row.names=FALSE, col.names=FALSE, quote=FALSE)
write.table(disorg, "data/pheno_disorg.txt", row.names=FALSE, col.names=FALSE, quote=FALSE)
