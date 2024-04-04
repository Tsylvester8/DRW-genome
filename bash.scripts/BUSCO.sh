#!/bin/bash
#SBATCH --job-name=diaprepes_assembly
#SBATCH --mail-type=ALL
#SBATCH --mail-user=tpsylvst@memphis.edu
#SBATCH --partition=shortq
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=20
#SBATCH --mem=100G
#SBATCH --time=48:00:00
#SBATCH --error=diaprepes_err_log
#SBATCH --output=diaprepes_out_log

# load busco
module load busco/3.8.7

# run busco
busco -i ../HiFiasm-assemly/diaprepes.fa -o diaprepes_busco -m geno -c 20 -l endopterygota_odb10
