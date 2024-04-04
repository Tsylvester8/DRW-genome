#!/bin/bash
#SBATCH --job-name=Dab_RNAseq
#SBATCH --mail-type=ALL
#SBATCH --mail-user=tpsylvst@memphis.edu
#SBATCH --partition=bigmemq
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=40
#SBATCH --mem=100G
#SBATCH --time=24:00:00
#SBATCH --error=Dab_RseqAlignment_err_log
#SBATCH --output=Dab_RseqAlignment_out_log

# load BWA
module load bwa/0.7.17

# change working directory
cd ../RNA-alignment

# run bwa mem alignment 
bwa mem -t 40 ../Genome-softmasked/Dab.softmasked.fasta ../mRNA-fq/SRR2083654_1.fastq ../mRNA-fq/SRR2083654_2.fastq | samtools view -b -o Dab-RNAseq-alignment.bam -@ 40

