#!/bin/bash
# Merges rs numbers from HRC reference panel into GWAS summary stats for FUMA functional annotation
# RS number mapping file (hrcmerge.txt) derived from HRC reference panel from Nagy et al. (2017) https://doi.org/10.1186/s13073-017-0414-4
# Job scheduler instructions to run from current working directory, request 16GB memory, and set a maximum runtime of 24 hours.
#$ -cwd
#$ -l h_vmem=16G
#$ -l h_rt=24:00:00
# Specifies the output and error file locations for the output
#$ -o /home/xxxxxxxx/gwas_pipeline/logs/merge_rs.log
#$ -e /home/xxxxxxxx/gwas_pipeline/logs/merge_rs.err

cd /exports/eddie/scratch/s2223599/gwas_pipeline

awk 'NR==FNR{rs[$1"_"$2]=$3; next} FNR==1{print $0, "RS"; next} {key=$1"_"$3; if(key in rs) print $0, rs[key]; else print $0, "NA"}' /exports/eddie/scratch/s2223599/hrcmerge.txt gwas/GS_gwas_disorg.assoc.linear > gwas/GS_gwas_disorg_rs.assoc.linear
