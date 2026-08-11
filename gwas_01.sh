#!/bin/bash
# GWAS methodology based on McCarthy et al. (2008).
# PLINK v1.90b7.2 documentation: https://www.cog-genomics.org/plink/1.9/ 
# Job scheduler instructions to run from current working directory, request 32GB memory, and set a maximum runtime of 100 hours.
#$ -cwd
#$ -l h_vmem=32G
#$ -l h_rt=100:00:00
# Specifies the output and error file locations for the output.
#$ -o /home/xxxxxxxx/gwas_pipeline/logs/GS_gwas.log
#$ -e /home/xxxxxxxx/gwas_pipeline/logs/GS_gwas.err

#Initialise the modules system to work in qsub job scripts.
. /etc/profile.d/modules.sh

#Load PLINK
module load igmm/apps/plink/1.90b7.2

#Navigates to pipeline directory
cd /exports/eddie/scratch/s2223599/gwas_pipeline

# GWAS for total SPQ score
plink --bfile qc/GS_qc_final \
 --allow-no-sex \
 --linear \
 --pheno data/pheno_total.txt \
 --covar data/covars_header.covar \
 --covar-number 1-12 \
 --hide-covar \
 --out gwas/GS_gwas_total

# GWAS for cognitive-perceptual dimension
plink --bfile qc/GS_qc_final \
  --allow-no-sex \
  --linear \
  --pheno data/pheno_cogper.txt \
  --covar data/covars_header.covar \
  --covar-number 1-12 \
  --hide-covar \
  --out gwas/GS_gwas_cogper

# GWAS for interpersonal dimension
plink --bfile qc/GS_qc_final \
  --allow-no-sex \
  --linear \
  --pheno data/pheno_inter.txt \
  --covar data/covars_header.covar \
  --covar-number 1-12 \
  --hide-covar \
  --out gwas/GS_gwas_inter

# GWAS for disorganisation dimension
plink --bfile qc/GS_qc_final \
  --allow-no-sex \
  --linear \
  --pheno data/pheno_disorg.txt \
  --covar data/covars_header.covar \
  --covar-number 1-12 \
  --hide-covar \
  --out gwas/GS_gwas_disorg
