#!/bin/bash
#SBATCH --job-name=Dab.SVIM-asm
#SBATCH --mail-type=ALL
#SBATCH --mail-user=tpsylvst@memphis.edu
#SBATCH --partition=shortq
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=40
#SBATCH --mem=180G
#SBATCH --time=3-00:00:00
#SBATCH --error=err.Dab.SVIM-asm-new.log
#SBATCH --output=out.Dab.SVIM-asm-new.log

# source conda module
source /cm/shared/public/apps/miniconda/3.7/etc/profile.d/conda.sh

# load conda env
conda activate /home/scratch/tpsylvst/conda-env/svimasm

# map Diaprepes genome against a reference genome
# minimap2 -a -x asm5 --cs -r2k -t <num_threads> <reference.fa> <assembly.fasta> > <alignments.sam>

# set variables
Ref_Genome=/home/scratch/tpsylvst/rawdata/genomes
Dab_Genome=/home/scratch/tpsylvst/rawdata/fasta/Diaprepes/Genome-nuclear-RepeatMasked-soft/Diaprepes-nuclear-genome-masked.fa
Out_dir_root=/home/scratch/tpsylvst/projects/Diaprepes-genome-assembly/4-GenomeComparisons

# index genomes
# samtools faidx $Ref_Genome/Pachyrhynchus_sulphureomaculatus/GCA_019049505.1.fna
samtools faidx $Ref_Genome/Dendroctonas_pondarosae/GCF_020466585.1.fna
samtools faidx $Ref_Genome/Hypothenemus_hampei/GCA_013372445.1.fna
# samtools faidx $Dab_Genome

# load minimap2
module load minimap2/2.17

# run minimap2 on Pachyrhynchus_sulphureomaculatus
# minimap2 -a -x asm5 --cs -r2k -t 40 \ 
# $Ref_Genome/Pachyrhynchus_sulphureomaculatus/GCA_019049505.1.fna \
# $Dab_Genome > \
# $Out_dir_root/output/Psupl/Psupl-mapping.sam

# run minimap2 on Dendroctonas_pondarosae
minimap2 -a -x asm5 --cs -r2k -t 40 \ 
$Ref_Genome/Dendroctonas_pondarosae/GCF_020466585.1.fna \
$Dab_Genome > \
$Out_dir_root/output/Dpon/Dpon-mapping.sam

# run minimap2 on Hypothenemus_hampei
minimap2 -a -x asm5 --cs -r2k -t 40 \ 
$Ref_Genome/Hypothenemus_hampei/GCA_013372445.1.fna \
$Dab_Genome > \
$Out_dir_root/output/Hham/Hham-mapping.sam

# sort map file 
# samtools sort -m4G -@40 -o \
# $Out_dir_root/output/Psupl/Psupl-mapping-sorted.sam \
# $Out_dir_root/output/Psupl/Psupl-mapping.sam

samtools sort -m4G -@40 -o \
$Out_dir_root/output/Dpon/Dpon-mapping-sorted.sam \
$Out_dir_root/output/Dpon/Dpon-mapping.sam

samtools sort -m4G -@40 -o \
$Out_dir_root/output/Hham/Hham-mapping-sorted.sam \
$Out_dir_root/output/Hham/Hham-mapping.sam

# index map file
# samtools index $Out_dir_root/output/Psupl/Psupl-mapping-sorted.sam
samtools index $Out_dir_root/output/Dpon/Dpon-mapping-sorted.sam
samtools index $Out_dir_root/output/Hham/Hham-mapping-sorted.sam

# run SVIM-asm
# svim-asm haploid \
# $Out_dir_root/output/Psupl \
# $Out_dir_root/output/Psupl/Psupl-mapping-sorted.bam \
# $Ref_Genome/Pachyrhynchus_sulphureomaculatus/GCA_019049505.1.fna

svim-asm haploid \
$Out_dir_root/output/Dpon \
$Out_dir_root/output/Dpon/Dpon-mapping-sorted.bam \
$Ref_Genome/Dendroctonas_pondarosae/GCF_020466585.1.fna

svim-asm haploid \
$Out_dir_root/output/Hham \
$Out_dir_root/output/Hham/Hham-mapping-sorted.bam \
$Ref_Genome/Hypothenemus_hampei/GCA_013372445.1.fna
