# run kmc
../../../software/KMC/bin/kmc -k21 -t10 -ci1 -cs10000 ../fastq/all_reads.fq 21mer tmp/
# run kmc tools to make the k-mer count histogram
../../../software/KMC/bin/kmc_tools transform reads histogram reads.histo -cx10000
