#!/bin/bash
#SBATCH --job-name=Dab.HGT-blast.full
#SBATCH --mail-type=ALL
#SBATCH --mail-user=tpsylvst@memphis.edu
#SBATCH --partition=shortq
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=40
#SBATCH --mem=150G
#SBATCH --time=3-00:00:00
#SBATCH --error=err.Dab.HGT.blast-bacteria.log
#SBATCH --output=out.Dab.HGT.blast-bacteria.log

# load blast module
module load blast/2.12.0

# make blast database
# makeblastdb \
# -in /home/scratch/tpsylvst/rawdata/Bacterial_fasta/NCBI-Bacterial-genomes.fasta \
# -input_type fasta \
# -dbtype nucl \
# -title bacteria-genome-db \
# -parse_seqids \
# -out /home/scratch/tpsylvst/databases/Bacterial-genomes-blast-db/bacteria-genome-db \

# run blast
blastn \
-query /home/scratch/tpsylvst/rawdata/fasta/Diaprepes/Genome-nuclear-RepeatMasked-soft/Diaprepes-nuclear-genome-masked.fa \
-db /home/scratch/tpsylvst/databases/Bacterial-genomes-blast-db/bacteria-genome-db \
-out ../output/bacteria-blast-out.txt \
-outfmt '6 qseqid staxids bitscore std' \
-num_threads 40 \
-evalue 1e-5

