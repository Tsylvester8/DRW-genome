#!/bin/bash
#SBATCH --job-name=CE8-phy
#SBATCH --mail-type=ALL
#SBATCH --mail-user=tpsylvst@memphis.edu
#SBATCH --partition=computeq
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=15
#SBATCH --mem=80G
#SBATCH --time=3-00:00:00
#SBATCH --error=err.iqtree.CE8.log
#SBATCH --output=out.iqtree.CE8.log

# set vars
gene=CE8
input=/home/scratch/tpsylvst/projects/Diaprepes-genome-assembly/11-PCWDE-phylogeny/PCWDE-genes/Alignment
cpu=${SLURM_CPUS_PER_TASK}
# load augustus module
module load iqtree/2.1.3

# change working dir
cd ../output/
# make output file
mkdir $gene

# run iqtree
iqtree2 -s $input/$gene-alignment.ed.fasta \
--seqtype AA \
--mem 150G \
--runs 10 \
-T $cpu \
-pre $gene/$gene \
-B 1000
