#!/bin/bash
##
## Submission script for Hawk
## -------------------------------------
##
## Specify queue- in this case the High throughput partition for serial jobs
#SBATCH -p htc
## Specify which project the job is for
#SBATCH --account=scw1429
## Time (1 hour)
#SBATCH -t 1-00:00:00
#SBATCH --mem-per-cpu=40G
#SBATCH --job-name=fullcloud
## Output file name
#SBATCH -o out.txt
## Error file name
#SBATCH -e error.txt
##
##
cd $SLURM_SUBMIT_DIR
##
## -------------------------------------
##
## Module Loads
module load R

##
## Execution
R CMD BATCH Interactions_ARCCA.R
