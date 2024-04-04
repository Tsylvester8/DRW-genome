#!/bin/bash
#SBATCH --job-name=diaprepes_blast
#SBATCH --mail-type=ALL
#SBATCH --mail-user=tpsylvst@memphis.edu
#SBATCH --partition=bigmemq
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=20
#SBATCH --mem=300G
#SBATCH --time=72:00:00
#SBATCH --error=diaprepes_err_blast.log
#SBATCH --output=diaprepes_out_blast.log

# load blast
module load blast/2.12.0

blastn -query diaprepes.purged.fa -db /home/tpsylvst/databases/NCBI_nt_db/nt \
-outfmt '6 qseqid staxids bitscore std' \
-max_target_seqs 10 \
-max_hsps 1 -evalue 1e-25 \
-out diaprepes-blast-out.txt \
-num_threads 20
