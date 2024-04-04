#!/bin/bash
#SBATCH --job-name=Dab.braker2.full
#SBATCH --mail-type=ALL
#SBATCH --mail-user=tpsylvst@memphis.edu
#SBATCH --partition=computeq
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=40
#SBATCH --mem=150G
#SBATCH --time=10-00:00:00
#SBATCH --error=err.Dab.HGT.log
#SBATCH --output=out.Dab.HGT.log

# load blast module
module load blast/2.12.0

# make blast database
makeblastdb 
-in \
-input_type fasta \
-dbtype nucl
-title bacteria-genome-db
-parse_seqids \
-out /home/scratch/tpsylvst/database/blast/bactera-genomes/bacteria-genome-db \

# run blast
blastn \
-db /home/scratch/tpsylvst/database/blast/bactera-genomes/bacteria-genome-db \
-out ../output/bacteria-blast-out.txt \
-max_hsps \
-max_target_seqs \
-num_threads 40 \

