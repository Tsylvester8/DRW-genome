#!/bin/bash
#SBATCH --job-name=Dab.RNA.map
#SBATCH --mail-type=ALL
#SBATCH --mail-user=tpsylvst@memphis.edu
#SBATCH --partition=shortq
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=40
#SBATCH --mem=80G
#SBATCH --time=3-00:00:00
#SBATCH --error=err.Dab.RNA.map.log
#SBATCH --output=out.Dab.RNA.map.log

# create genome index
/home/scratch/tpsylvst/software/STAR/source/STAR \
--runThreadN 40 \
--runMode genomeGenerate \
--genomeDir /home/scratch/tpsylvst/rawdata/fasta/Diaprepes/Genome-nuclear-RepeatMasked-soft/ \
--genomeFastaFiles /home/scratch/tpsylvst/rawdata/fasta/Diaprepes/Genome-nuclear-RepeatMasked-soft/Diaprepes-nuclear-genome-masked.fa 
#--sjdbOverhang 149

echo "####"
echo "genome index generation complete"
echo "####"

# align reads
/home/scratch/tpsylvst/software/STAR/source/STAR \
--runThreadN 40 \
--genomeDir /home/scratch/tpsylvst/rawdata/fasta/Diaprepes/Genome-nuclear-RepeatMasked-soft/ \
--readFilesIn  /home/scratch/tpsylvst/rawdata/fastq/RNA/Diaprepes-USDA/SRR2083654_1.fastq /home/scratch/tpsylvst/rawdata/fastq/RNA/Diaprepes-USDA/SRR2083654_2.fastq \
--outFileNamePrefix /home/scratch/tpsylvst/projects/Diaprepes-genome-assembly/2-RNA-mapping/Diaprepes-USDA/Diaprepes-USDA \
--outSAMtype BAM SortedByCoordinate \
--outSAMunmapped Within \
--outSAMattributes Standard 

echo "####"
echo "STAR mapping Diaprepes USDA complete"
echo "####"

# align reads
/home/scratch/tpsylvst/software/STAR/source/STAR \
--runThreadN 40 \
--genomeDir /home/scratch/tpsylvst/rawdata/fasta/Diaprepes/Genome-nuclear-RepeatMasked-soft/ \
--readFilesIn  /home/scratch/tpsylvst/rawdata/fastq/RNA/Diaprepes-PuetoRico/SRR17868967_1.fastq /home/scratch/tpsylvst/rawdata/fastq/RNA/Diaprepes-PuetoRico/SRR17868967_2.fastq \
--outFileNamePrefix /home/scratch/tpsylvst/projects/Diaprepes-genome-assembly/2-RNA-mapping/Diaprepes-PuetoRico/Diaprepes-PuetoRico \
--outSAMtype BAM SortedByCoordinate \
--outSAMunmapped Within \
--outSAMattributes Standard