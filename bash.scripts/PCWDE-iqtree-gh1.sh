#!/bin/bash
#SBATCH --job-name=GH1-phy
#SBATCH --mail-type=ALL
#SBATCH --mail-user=tpsylvst@memphis.edu
#SBATCH --partition=wholeq
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=40
#SBATCH --mem=150G
#SBATCH --time=5-00:00:00
#SBATCH --error=err.iqtree.gh1.log
#SBATCH --output=out.iqtree.gh1.log

# set vars
gene=GH1
input=/home/scratch/tpsylvst/projects/Diaprepes-genome-assembly/11-PCWDE-phylogeny/PCWDE-genes/Alignment

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
-T 40 \
-pre $gene/$gene \
-B 1000
