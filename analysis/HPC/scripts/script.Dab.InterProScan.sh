#!/bin/bash
#SBATCH --job-name=Dab.InterProScan
#SBATCH --mail-type=ALL
#SBATCH --mail-user=tpsylvst@memphis.edu
#SBATCH --partition=computeq
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=40
#SBATCH --mem=180G
#SBATCH --time=10-00:00:00
#SBATCH --error=err.Dab.Dab.InterProScan.log
#SBATCH --output=out.Dab.InterProScan.log

# source conda module
source /cm/shared/public/apps/miniconda/3.7/etc/profile.d/conda.sh

# load conda env
conda activate /home/scratch/tpsylvst/conda-env/InterProScan

# set variables
Braker_dir=/home/scratch/tpsylvst/projects/Diaprepes-genome-assembly/3-Annotation/2-braker/round-1
Interpro_out=/home/scratch/tpsylvst/projects/Diaprepes-genome-assembly/3-Annotation/6-Interproscan

# run InterProScan
/home/scratch/tpsylvst/software/interproscan-5.60-92.0/interproscan.sh \
-i $Braker_dir/augustus.hints.aa \
-f GFF3 \
-cpu 40 \
-dp \
-goterms \
-d $Interpro_out \
-o Dab.interproscan.annotation


