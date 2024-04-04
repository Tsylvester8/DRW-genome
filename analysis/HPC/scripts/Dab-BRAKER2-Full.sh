#!/bin/bash
#SBATCH --job-name=Dab-Braker-Annotation-full
#SBATCH --mail-type=ALL
#SBATCH --mail-user=tpsylvst@memphis.edu
#SBATCH --partition=wholeq
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=40
#SBATCH --mem=150G
#SBATCH --time=5-00:00:00
#SBATCH --error=Dab_Braker_full_err_log
#SBATCH --output=Dab_Braker_full_out_log

# protein alignment
# source conda module
source /cm/shared/public/apps/miniconda/3.7/etc/profile.d/conda.sh

# activate EDTA environment
conda activate /home/scratch/tpsylvst/conda-env/Braker2

# load augustus module
module load augustus/3.3.1

# change working dir
cd ../input

# run protein hits
/home/scratch/tpsylvst/software/ProtHint/bin/prothint.py ./Dab.softmasked.fasta ../../Arthropod-odb10-protein-db/proteins.fasta

# run BRAKER
/home/scratch/tpsylvst/software/BRAKER2/scripts/braker.pl \
--genome=./Dab.softmasked.fasta \
--bam=./Dab-RNAseq-alignment.bam \
--hints=./prothint_augustus.gff \
--workingdir=../Braker2-full-annotation \
--cores 40 \
--softmasking \
--species=Diaprepes_abbreviatus_full \
--rounds 5 \
--AUGUSTUS_BIN_PATH=/public/apps/augustus/3.3.1/bin/ \
--AUGUSTUS_CONFIG_PATH=/home/scratch/tpsylvst/software/Augustus/config \
--AUGUSTUS_SCRIPTS_PATH=/home/scratch/tpsylvst/software/Augustus/scripts \
--GENEMARK_PATH=/home/scratch/tpsylvst/software/GeneMark \
--PROTHINT_PATH=/home/scratch/tpsylvst/software/ProtHint/bin \
--GUSHR_PATH=/home/scratch/tpsylvst/software/GUSHR