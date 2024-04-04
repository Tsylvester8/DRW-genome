#!/bin/bash
#SBATCH --job-name=Dab_BRAKER2
#SBATCH --mail-type=ALL
#SBATCH --mail-user=tpsylvst@memphis.edu
#SBATCH --partition=bigmemq
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=40
#SBATCH --mem=300G
#SBATCH --time=7-00:00:00
#SBATCH --error=Dab_Braker_err_log
#SBATCH --output=Dab_Braker_out_log


# source conda module
source /cm/shared/public/apps/miniconda/3.7/etc/profile.d/conda.sh

# activate EDTA environment
conda activate /home/tpsylvst/conda-env/braker2

# change working dir
cd ../BRAKER/

# run BRAKER
/home/tpsylvst/software/BRAKER-2.1.6/scripts/braker.pl \
--genome=../Genome-softmasked/Dab.softmasked.fasta \
--bam=../RNA-alignment/Dab-RNAseq-alignment.bam \
--workingdir=./Dab_out \
--cores 40 \
--GENEMARK_PATH=/home/tpsylvst/software/Braker2-dependencies/GeneMark/ \
--PROTHINT_PATH=/home/tpsylvst/software/Braker2-dependencies/ProtHint-2.6.0/bin/ \
--GUSHR_PATH=/home/tpsylvst/software/Braker2-dependencies/GUSHR/gushr.py \
--AUGUSTUS_CONFIG_PATH=/home/tpsylvst/software/Augustus/config/ \
--AUGUSTUS_BIN_PATH=/home/tpsylvst/software/Augustus/bin/ \
--AUGUSTUS_SCRIPTS_PATH=/home/tpsylvst/software/Augustus/scripts