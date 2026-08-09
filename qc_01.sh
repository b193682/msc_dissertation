#!/bin/bash
# QC parameters follow established protocols from Anderson et al. (2010) and Marees et al. (2018)
# PLINK v1.90b7.2 documentation: https://www.cog-genomics.org/plink/1.9/ 
# Job scheduler instructions to run from current working directory, request 10GB memory, and set a maximum runtime of 100 hours.
#$ -cwd
#$ -l h_vmem=10G
#$ -l h_rt=100:00:00

# Initialise the modules system to work in qsub job scripts.
. /etc/profile.d/modules.sh

# Loads PLINK and R.
module load igmm/apps/plink/1.90b7.2
module load R

#Navigates to pipeline directory.
cd /exports/eddie/scratch/s2223599/gwas_pipeline
#Step 1: Initial SNP and sample filters
#Minor Allele Frequency < 0.01, SNP missingness > 5%, HWE deviation, sample missingness > 5%
plink --bfile data/GS_merged \
  --allow-no-sex \
  --keep data/spqpeople.txt \
  --exclude data/triallele \
  --maf 0.01 \
  --geno 0.05 \
  --hwe 1e-6 \
  --mind 0.05 \
  --make-bed \
  --out qc/GS_qc1

#Step 2: LD Pruning
#Removes SNPs with r2 > 0.2
plink --bfile qc/GS_qc1 \
  --allow-no-sex \
  --indep-pairwise 50 5 0.2 \
  --out qc/GS_ldpruned
  
#Step 3: Extract LD pruned SNPs
plink --bfile qc/GS_qc1 \
  --allow-no-sex \
  --extract qc/GS_ldpruned.prune.in \
  --make-bed \
  --out qc/GS_pruned

# Step 4: Heterozygosity check
# Generates per-sample heterozygosity statistics for outlier removal
plink --bfile qc/GS_pruned \
  --allow-no-sex \
  --het \
  --out qc/GS_het

#Step 5: Remove heterozygosity outliers
#R script removes individuals more than 3 SD from mean heterozygosity rate
Rscript /home/s2223599/gwas_pipeline/scripts/het_filter.R

#Step 6: Apply heterozygosity exclusions to full SNP set
plink --bfile qc/GS_qc1 \
  --allow-no-sex \
  --remove qc/samples_to_remove.txt \
  --make-bed \
  --out qc/GS_qc_final
