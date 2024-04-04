# Terrence Sylvester
# pradakshanas@gmail.com
# 03/17/2023

# load libraries
library(seqinr)
# read data
seq <- read.fasta(file = "full.alignment/CE8-alignment.flank.pruned.fasta",seqtype = "DNA")

empty <- c()

for(i in 1:length(seq)){
  empty[i] <- sum((seq[[i]] == "-")) / length(seq[[i]])
}
hist(empty)

# get sequences with more than 80% missing data and remove them
names(seq)[which(empty > 0.8)]
drop <- which(empty > 0.8)

# remove these sequences
if(length(drop != 0)){
  seq <- seq[-drop]  
}
# write fasta file
write.fasta(sequences = seq,
            names = names(seq),
            file.out = "full.alignment/CE8-alignment.ed.fasta")

