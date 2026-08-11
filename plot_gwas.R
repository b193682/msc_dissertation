# GWAS plotting script
# Produces Manhattan and QQ plots for each SPQ phenotype
# Adds personal R library path to find user-installed packages
.libPaths(c("/home/xxxxxxxx/R/x86_64-pc-linux-gnu-library/4.4", .libPaths()))
# Loads qqman package for GWAS visualisation (Turner, 2014)
library(qqman)

# Define input and output directories
gwas_dir <- "gwas"
plot_dir <- "plots"

# Function to create Manhattan and QQ plots for each phenotype
gwas_plot <- function(file_path, phenotype_name, output_dir) {
  
cat("Reading", phenotype_name, "\n")
  
# Read GWAS results into a data frame
gwas <- read.table(file_path, header=TRUE)
  
# Remove NA p-values to avoid errors
gwas <- gwas[!is.na(gwas$P), ]
  
cat("Plotting Manhattan plot for", phenotype_name, "\n")
  
# Create a PNG file to write Manhattan plot into and set dimensions
png(paste0(output_dir, "/manhattan_", phenotype_name, ".png"),
    width=1000, height=500, res=100)
  
# Draw Manhattan plot
manhattan(gwas,
          chr="CHR",
          bp="BP",
          snp="SNP",
          p="P",
          main=paste("Manhattan Plot -", phenotype_name),
          suggestiveline=-log10(1e-5),
          genomewideline=-log10(5e-8),
          col=c("blue", "pink"))
  
# Close PNG file
dev.off()
  
cat("Plotting QQ plot for", phenotype_name, "\n")
  
# Create a PNG file to write QQ plot into and set dimensions
png(paste0(output_dir, "/qq_", phenotype_name, ".png"),
    width=500, height=500, res=100)
  
# Draw QQ plot using p-value column
qq(gwas$P, main=paste("QQ Plot -", phenotype_name))
  
# Close PNG file
dev.off()
  
cat("Plots saved for", phenotype_name, "\n")
}

# Create plots folder
dir.create(plot_dir, showWarnings=FALSE)

# Call the function for each phenotype dimension
gwas_plot(paste0(gwas_dir, "/GS_gwas_total.assoc.linear"), "total", plot_dir)
gwas_plot(paste0(gwas_dir, "/GS_gwas_cogper.assoc.linear"), "cogper", plot_dir)
gwas_plot(paste0(gwas_dir, "/GS_gwas_inter.assoc.linear"), "inter", plot_dir)
gwas_plot(paste0(gwas_dir, "/GS_gwas_disorg.assoc.linear"), "disorg", plot_dir)
