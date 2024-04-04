#!/bin/bash
#SBATCH --job-name=Dab.braker2.full
#SBATCH --mail-type=ALL
#SBATCH --mail-user=tpsylvst@memphis.edu
#SBATCH --partition=shortq
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=40
#SBATCH --mem=150G
#SBATCH --time=3-00:00:00
#SBATCH --error=err.Dab.braker2.full.log
#SBATCH --output=out.Dab.braker2.full.log

# source conda module
source /cm/shared/public/apps/miniconda/3.7/etc/profile.d/conda.sh

# activate EDTA environment
conda activate /home/scratch/tpsylvst/conda-env/Braker2

# load augustus module
module load augustus/3.3.1

# run protein hits
#/home/scratch/tpsylvst/software/ProtHint/bin/prothint.py \
#--threads 40 \
#/home/scratch/tpsylvst/projects/Diaprepes-genome-assembly/RepeatMasking/masked-genome/genome.fasta.combined.masked \
#../../Arthropod-odb10-protein-db/proteins.fasta

# run BRAKER
/home/scratch/tpsylvst/software/BRAKER2/scripts/braker.pl \
--genome=/home/scratch/tpsylvst/projects/Diaprepes-genome-assembly/1-RepeatMasking/3-masked-genome/genome.fasta.combined.masked \
--bam=/home/scratch/tpsylvst/projects/Diaprepes-genome-assembly/2-RNA-mapping/Diaprepes-USDA/Diaprepes-USDAAligned.sortedByCoord.out.bam \
--hints=/home/scratch/tpsylvst/projects/Diaprepes-genome-assembly/3-Annotation/1-input/prothint_augustus.gff \
--workingdir=/home/scratch/tpsylvst/projects/Diaprepes-genome-assembly/3-Annotation/2-braker/round-1 \
--cores 40 \
--softmasking \
--species=1.Diaprepes_abbreviatus \
--etpmode \
--rounds 5 \
--AUGUSTUS_BIN_PATH=/public/apps/augustus/3.3.1/bin/ \
--AUGUSTUS_CONFIG_PATH=/home/scratch/tpsylvst/software/Augustus/config \
--AUGUSTUS_SCRIPTS_PATH=/home/scratch/tpsylvst/software/Augustus/scripts \
--GENEMARK_PATH=/home/scratch/tpsylvst/software/GeneMark \
--PROTHINT_PATH=/home/scratch/tpsylvst/software/ProtHint/bin \
--GUSHR_PATH=/home/scratch/tpsylvst/software/GUSHR


### deprecated code ###

# mRna alignment
# load BWA
# module load bwa/0.7.17

# change working dir
# cd ../input

# index genome 
#bwa index /home/scratch/tpsylvst/projects/Diaprepes-genome-assembly/RepeatMasking/masked-genome/genome.fasta.combined.masked

# run bwa mem alignment
# bwa mem -t 40 /home/scratch/tpsylvst/projects/Diaprepes-genome-assembly/RepeatMasking/masked-genome/genome.fasta.combined.masked \
# /home/tpsylvst/projects/diaprepes_assembly/Annotation/mRNA-fq/SRR2083654_1.fastq \
# /home/tpsylvst/projects/diaprepes_assembly/Annotation/mRNA-fq/SRR2083654_2.fastq | samtools view -b -o Dab-RNAseq-alignment.bam -@ 40
