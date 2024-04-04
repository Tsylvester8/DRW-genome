# read blast output
HGT.blast.out <- read.delim("../output/bacteria-blast-out.txt", as.is = T, header = F)
head(HGT.blast.out)

cat(paste(HGT.blast.out$V1,":",HGT.blast.out$V10,"-",HGT.blast.out$V11, sep = ""),sep = "\n",file = "filter-fasta.txt")
