#!/bin/bash
#SBATCH --job-name=diaprepes_purge_dups
#SBATCH --mail-type=ALL
#SBATCH --mail-user=tpsylvst@memphis.edu
#SBATCH --partition=computeq
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=20
#SBATCH --mem=100G
#SBATCH --time=48:00:00
#SBATCH --error=diaprepes_err_purge_dups_log
#SBATCH --output=diaprepes_out_purge_dups_log

# load minimap2
module load minimap2/2.17

# load bwa
module load bwa/0.7.17

# load busco
module load busco/3.8.7

# load python
module load python/3.9.13/gcc.8.2.0

# step 1
# run minimap2 to allign pacbio data and generate paf files, 
# then calculate read depth histogram and base-level read depth

# step 2
# split an assembly and do a self-self alignment

# step 3
# purge haplotigs and overlaps

# step 4
# get purged primary and haplotig sequences from draft assembly

# step 5
# merge hap.fa and $hap_asm and redo the above steps to get a decent haplotig set 

# run minimap
# minimap2 -I 4G -x map-pb -t 20 /home/tpsylvst/projects/diaprepes_assembly/Dups-purged-assembly/diaprepes.fa /home/tpsylvst/projects/diaprepes_assembly/fastq/all_reads.fq >diaprepes/coverage/all_reads.paf

# run purge dups script
../../../software/purge_dups/scripts/run_purge_dups.py -p bash ./config.json ../../../software/purge_dups/src diaprepes
