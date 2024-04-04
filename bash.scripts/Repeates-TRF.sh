#!/bin/bash
#SBATCH --job-name=Dab-TRF
#SBATCH --mail-type=ALL
#SBATCH --mail-user=tpsylvst@memphis.edu
#SBATCH --partition=shortq
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=40
#SBATCH --mem=170G
#SBATCH --time=3-00:00:00
#SBATCH --error=err.Dab.TRF.log
#SBATCH --output=out.Dab.TRF.log

# genome location
genome=/home/scratch/tpsylvst/rawdata/fasta/Diaprepes/Genome-nuclear/Diaprepes-nuclear.fa

# source conda module
source /cm/shared/public/apps/miniconda/3.7/etc/profile.d/conda.sh

# activate EDTA environment
conda activate /home/scratch/tpsylvst/conda-env/RepeatMask

# change working dir to run trf
cd ../id-repeats-TRF/

# run TRF
trf $genome 2 7 7 80 10 50 500 -d -m -h

