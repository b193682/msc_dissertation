#!/bin/bash
# Polygenic risk score analysis for attention-deficit hyperactivity disorder, using C+T threshold derived from Choi and O'Reilly (2020) https://doi.org/10.1038/s41596-020-0353-1
# PRS calculated using PRSice-2 v2.1.11 https://choishingwan.github.io/PRSice/
# Discovery dataset from Demontis et al. (2023) https://doi.org/10.1038/s41588-022-01285-8
# Job scheduler instructions to run from current working directory, request 32GB memory, and set a maximum runtime of 24 hours.
#$ -cwd
#$ -l h_vmem=32G
#$ -l h_rt=24:00:00
# Specifies the output and erorr file locations for the output.
#$ -o /home/xxxxxxxx/gwas_pipeline/logs/prs_adhd.log
#$ -e /home/xxxxxxxx/gwas_pipeline/logs/prs_adhd.err

#Initialise the modules system to work in qsub job scripts.
. /etc/profile.d/modules.sh
module load igmm/apps/PRSice/2.1.11

cd /exports/eddie/scratch/s2223599/gwas_pipeline

# PRS for ADHD against all four SPQ-B phenotypes

# Total score
PRSice \
  --base data/ADHD2022_iPSYCH_deCODE_PGC.meta.gz \
  --target qc/GS_qc_final_rs \
  --binary-target F \
  --pheno-file data/pheno_total.txt \
  --cov-file data/covars_header.covar \
  --stat OR \
  --or \
  --snp SNP \
  --A1 A1 \
  --A2 A2 \
  --pvalue P \
  --bar-levels 0.001,0.05,0.1,0.2,0.3,0.4,0.5,1 \
  --fastscore \
  --out prs/GS_prs_adhd_total

# Cognitive-perceptual
PRSice \
  --base data/ADHD2022_iPSYCH_deCODE_PGC.meta.gz \
  --target qc/GS_qc_final_rs \
  --binary-target F \
  --pheno-file data/pheno_cogper.txt \
  --cov-file data/covars_header.covar \
  --stat OR \
  --or \
  --snp SNP \
  --A1 A1 \
  --A2 A2 \
  --pvalue P \
  --bar-levels 0.001,0.05,0.1,0.2,0.3,0.4,0.5,1 \
  --fastscore \
  --out prs/GS_prs_adhd_cogper

# Interpersonal
PRSice \
  --base data/ADHD2022_iPSYCH_deCODE_PGC.meta.gz \
  --target qc/GS_qc_final_rs \
  --binary-target F \
  --pheno-file data/pheno_inter.txt \
  --cov-file data/covars_header.covar \
  --stat OR \
  --or \
  --snp SNP \
  --A1 A1 \
  --A2 A2 \
  --pvalue P \
  --bar-levels 0.001,0.05,0.1,0.2,0.3,0.4,0.5,1 \
  --fastscore \
  --out prs/GS_prs_adhd_inter

# Disorganisation
PRSice \
  --base data/ADHD2022_iPSYCH_deCODE_PGC.meta.gz \
  --target qc/GS_qc_final_rs \
  --binary-target F \
  --pheno-file data/pheno_disorg.txt \
  --cov-file data/covars_header.covar \
  --stat OR \
  --or \
  --snp SNP \
  --A1 A1 \
  --A2 A2 \
  --pvalue P \
  --bar-levels 0.001,0.05,0.1,0.2,0.3,0.4,0.5,1 \
  --fastscore \
  --out prs/GS_prs_adhd_disorg
