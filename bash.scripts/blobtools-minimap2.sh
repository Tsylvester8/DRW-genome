#!/bin/bash
#SBATCH --job-name=diaprepes_minimap2
#SBATCH --mail-type=ALL
#SBATCH --mail-user=tpsylvst@memphis.edu
#SBATCH --partition=computeq
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=20
#SBATCH --mem=100G
#SBATCH --time=48:00:00
#SBATCH --error=diaprepes_err_minimap2.log
#SBATCH --output=diaprepes_out_minimap2.log

# load blast
# module load minimap2/2.17
# run minimap
# minimap2 -a -o diaprepes-blobtools-map.sam -x map-pb -t 20 diaprepes.purged.fa ../fastq/all_reads.fq
# load samtools
module load samtools/1.9
# run samtools
# samtools view -b -o diaprepes-blobtools-map.bam diaprepes-blobtools-map.sam
samtools sort -@ 20 -O BAM -o diaprepes-sorted.bam diaprepes-blobtools-map.bam
samtools index diaprepes-sorted.bam
