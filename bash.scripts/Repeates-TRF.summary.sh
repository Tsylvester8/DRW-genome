#!/bin/bash
#SBATCH --job-name=Dab-TRF-summary
#SBATCH --mail-type=ALL
#SBATCH --mail-user=tpsylvst@memphis.edu
#SBATCH --partition=shortq
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=2
#SBATCH --mem=10G
#SBATCH --time=3-00:00:00
#SBATCH --error=err.Dab.TRF.summary.log
#SBATCH --output=out.Dab.TRF.summary.log

# change working dir to run trf
cd ../id-repeats-TRF/

# run TRF summary script
bash ../scripts/TRF-summary.sh -f Diaprepes-nuclear.fa.2.7.7.80.10.50.500.dat
