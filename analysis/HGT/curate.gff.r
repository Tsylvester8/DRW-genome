gff.in <- read.delim("Diaprepes-curated-annotation.gff3", as.is = T,
                  header = F)
gff <- gff.in[gff.in$V3 %in% "polypeptide",]
for(i in 1:nrow(gff)){
  gff$V9[i] <- unlist(strsplit(gff$V9[i], split = "md5="))[2]  
}

dups <- names(sort(table(gff$V9),decreasing = T)[sort(table(gff$V9),decreasing = T)>2])

keep.genes <- gff$V1[!(duplicated(gff$V9))]
keep.genes.single <- gff$V1[!(gff$V9 %in% dups)]

gff.single <- gff.in[gff.in$V1 %in% keep.genes.single,]

write.table(gff, "Diaprepes-nodup.gff",row.names = F,col.names = F,quote = F,sep = "\t")
write.table(gff.single, "Diaprepes-single.gff",row.names = F,col.names = F,quote = F,sep = "\t")

