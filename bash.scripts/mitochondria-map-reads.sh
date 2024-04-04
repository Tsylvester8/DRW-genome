#!/bin/bash
#SBATCH --job-name=Dabb_mito_map
#SBATCH --mail-type=ALL
#SBATCH --mail-user=tpsylvst@memphis.edu
#SBATCH --partition=computeq
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=20
#SBATCH --mem=50G
#SBATCH --time=24:00:00
#SBATCH --error=dabb-mito_err_blast.log
#SBATCH --output=dabb-mito_out_blast.log

# load minimap2
module load minimap2/2.17

# run minimap2
minimap2 -x map-pb -a -o Dabb-mito-reads.sam ../blast/diaprepes-mitochondrial-seq.fa ../../fastq/all_reads.fq

