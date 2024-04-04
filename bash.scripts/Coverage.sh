#!/bin/bash
#SBATCH --job-name=coverage
#SBATCH --mail-type=ALL
#SBATCH --mail-user=tpsylvst@memphis.edu
#SBATCH --partition=computeq
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --mem=50G
#SBATCH --time=10:00:00
#SBATCH --error=err.coverage.log
#SBATCH --output=out.coverage.log

# load minimap2
module load minimap2/2.17

# set vars
Dab_Genome=/home/scratch/tpsylvst/rawdata/fasta/Diaprepes/Genome-nuclear/Diaprepes-nuclear.fa
Raw_data=/home/scratch/tpsylvst/rawdata/fastq/DNA/Diaprepes_abbreviatus_raw_reads.fq

# index genomes
samtools faidx $Dab_Genome

# run minimap2 on Pachyrhynchus_sulphureomaculatus
minimap2 -ax map-pb --cs -t 10 $Dab_Genome $Raw_data > ../output/Dab-aln.sam

# samtools sort and index
samtools sort -m2G -@10 -o ../output/Dab-aln-sorted.bam ../output/Dab-aln.sam

# index map file
samtools index ../output/Dab-aln-sorted.bam

# get only mapped reads
samtools view -b -F 4 ../output/Dab-aln-sorted.bam> ../output/Dab-mapped-reads.bam

# index 
samtools index ../output/Dab-mapped-reads.bam

# get coverage
samtools coverage -o ../output/Dab-mapped-reads.cov ../output/Dab-mapped-reads.bam 
