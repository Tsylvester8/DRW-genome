# read blast output
Bac.blast.out <- read.delim("../output/bacteria-blast-out.txt", as.is = T, header = F)
Anm.blast.out <- read.delim("../output/animal-blast-out.txt", as.is = T, header = F)
# change column names
colnames(Bac.blast.out) <- c("qseqid", "sseqid", "pident", "length", "mismatch", "gapopen", "qstart", "qend", "sstart", "send", "evalue", "bitscore", "qcovs", "qcovhsp")
colnames(Anm.blast.out) <- c("qseqid", "sseqid", "pident", "length", "mismatch", "gapopen", "qstart", "qend", "sstart", "send", "evalue", "bitscore", "qcovs", "qcovhsp")
# change bacteria blast qseqid to match with animal blast qseqid
Bac.blast.out$qseqid <- paste(Bac.blast.out$qseqid,":",Bac.blast.out$qstart,"-",Bac.blast.out$qend, sep = "")
# get the list of contigs that have a lower evalue than bacterial blast
contig.list <- c()
for(i in 1:nrow(Bac.blast.out)){
  evalue <- (Anm.blast.out$evalue[Anm.blast.out$qseqid %in% Bac.blast.out$qseqid[i]])  
  if(sum(evalue < Bac.blast.out$evalue[i]) >= 1){
    contig.list <- c(contig.list,Bac.blast.out$qseqid[i])
  }
}
# get all unique matches
contig.list <- unique(contig.list)
# write the list of contigs
#write(contig.list,file = "potential-hits.txt")

# missing contigs
missing.contig.list <- Bac.blast.out$qseqid[!(Bac.blast.out$qseqid %in% Anm.blast.out$qseqid)]
unique(missing.contig.list)

# read gff
augustus.gff <- read.delim("../input/augustus.hints.gtf", header = F, as.is = T)

for(i in 1:length(contig.list)){
  target <- contig.list[i]
  contig <- strsplit(x = target,split = ":")[[1]][1]
  range <- as.numeric(unlist(strsplit(strsplit(x = target,split = ":")[[1]][2],split = "-")))
  foo <- augustus.gff[augustus.gff$V1 == contig,]
  
  x <- foo[foo$V4 >= range[1] & foo$V5 <= range[2],]
  
  if(nrow(x) >= 1){
    print(x)
  }
}
