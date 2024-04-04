#!/bin/bash
#SBATCH --job-name=RepeatID
#SBATCH --mail-type=ALL
#SBATCH --mail-user=tpsylvst@memphis.edu
#SBATCH --partition=bigmemq
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=20
#SBATCH --mem=700G
#SBATCH --time=7-00:00:00
#SBATCH --error=err.Dab.EDTA.log
#SBATCH --output=out.Dab.EDTA.log

# source conda module
source /cm/shared/public/apps/miniconda/3.7/etc/profile.d/conda.sh

# activate EDTA environment
conda activate /home/tpsylvst/conda-env/EDTA

# change directory
cd ../id-repeats-EDTA/

# genome location
genome=/home/scratch/tpsylvst/rawdata/fasta/Diaprepes/Genome-nuclear/Diaprepes-nuclear.fa

# run EDTA pipeline
perl /home/tpsylvst/software/EDTA/EDTA.pl \
--genome $genome \
--species others \
--step all \
--overwrite 1 \
--sensitive 1 \
--anno 1 \
--threads 40
