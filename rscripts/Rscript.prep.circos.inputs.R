# Terrence Sylvester
# pradakshanas@gmail.com
# 2/28/2023

# read BUSCO results
Dab.busco <- read.delim("../analysis/Xchromosome/Diaprepes-busco-full-table.tsv",
                        as.is = T,
                        header = T)
Tcas.busco <- read.delim("../analysis/Xchromosome/Tribolium-busco-full-table.tsv",
                         as.is = T, 
                         header = T)
Pcer.busco <- read.delim("../analysis/Xchromosome/Polydrusus-busco-full-table.tsv",
                         as.is = T, 
                         header = T)

# filter BUSCO data based on the sex chromosomes
Tcas.busco <- Tcas.busco[Tcas.busco$Sequence == "NC_007416.3",]
Pcer.busco <- Pcer.busco[Pcer.busco$Sequence == "OW284520.1",]

# retain only complete single copy BUSCOs
Tcas.busco.complete <- Tcas.busco[Tcas.busco$Status == "Complete",]
Pcer.busco.complete <- Pcer.busco[Pcer.busco$Status == "Complete",]

#### Tcas vs Dab ####
# parse Dab busco based on Tcas busco gene ids
Dab.Tcas.busco.overlap <- Dab.busco[Dab.busco$Busco.id %in% Tcas.busco.complete$Busco.id,]
# keep only complete buscos
Dab.Tcas.busco.complete <- Dab.Tcas.busco.overlap[Dab.Tcas.busco.overlap$Status == "Complete",]
# remove missing buscos from Tcas gene set
Tcas.busco.complete <- Tcas.busco.complete[Tcas.busco.complete$Busco.id %in% Dab.Tcas.busco.complete$Busco.id,]

#### genome index ####
# read diaprepes genome index
Dab.genome.index <- read.delim("../analysis/Xchromosome/Diaprepes-nuclear.fa.fai", 
                               as.is = T,
                               header = F)
Dab.genome.index <- Dab.genome.index[order(Dab.genome.index$V2,decreasing = T),]
# read Tcas genome index
Tcas.genome.index <- read.delim("../analysis/Xchromosome/Tribolium-LGX.fasta.fai", 
                                as.is = T,
                                header = F)

# make karyotype table for Dab genome
Dab.genome.index <- Dab.genome.index[Dab.genome.index$V1 %in% Dab.Tcas.busco.complete$Sequence,]
Dab.genome.index <- Dab.genome.index[,c(1,2)]
colnames(Dab.genome.index) <- c("Chr","End")

# add additional cols
Dab.genome.index$identifier <- "chr"
Dab.genome.index$start <- 0
Dab.genome.index$cols <- "b2abd2"
Dab.genome.index$name <- paste("Dab",1:nrow(Dab.genome.index),sep = "")
Dab.genome.index$sep <- "-"

# re-order columns
Dab.genome.index <- Dab.genome.index[,c(3,7,1,6,4,2,5)]

# make karyotype table for Tcas genome
Tcas.genome.index <- Tcas.genome.index[,c(1,2)]
colnames(Tcas.genome.index) <- c("Chr","End")

# add additional cols
Tcas.genome.index$identifier <- "chr"
Tcas.genome.index$start <- 0
Tcas.genome.index$cols <- "blue"
Tcas.genome.index$name <- "LGX"
Tcas.genome.index$sep <- "-"

# re-order columns
Tcas.genome.index <- Tcas.genome.index[,c(3,7,1,6,4,2,5)]

# sort busco tables based on busco ID
Tcas.busco.complete <- Tcas.busco.complete[order(Tcas.busco.complete$Busco.id),]
Dab.Tcas.busco.complete <- Dab.Tcas.busco.complete[order(Dab.Tcas.busco.complete$Busco.id),]

# get the start and end possitions
Tcas.busco.match <- Tcas.busco.complete[,c(3,4,5)]
Dab.busco.match <- Dab.Tcas.busco.complete[,c(3,4,5)]

for(i in 1:nrow(Dab.busco.match)){
  Dab.busco.match$Sequence[i] <- which(Dab.genome.index$Chr %in% Dab.busco.match$Sequence[i])
}
colnames(Dab.busco.match) <- c("Species_1", "Start_1", "End_1")
Dab.busco.match$Species_1 <- paste("Da-",Dab.busco.match$Species_1,sep = "")

Tcas.busco.match$Sequence <- rep("Tc-x", nrow(Tcas.busco.match))
colnames(Tcas.busco.match) <- c("Species_2", "Start_2", "End_2")

#### Pcer vs Dab ####
# parse Dab busco based on Tcas busco gene ids
Dab.Per.busco.overlap <- Dab.busco[Dab.busco$Busco.id %in% Pcer.busco.complete$Busco.id,]
# keep only complete buscos
Dab.Per.busco.complete <- Dab.Per.busco.overlap[Dab.Per.busco.overlap$Status == "Complete",]
# remove missing buscos from Tcas gene set
Pcer.busco.complete <- Pcer.busco.complete[Pcer.busco.complete$Busco.id %in% Dab.Per.busco.complete$Busco.id,]

# read diaprepes genome index
Dab.genome.index.pcer <- read.delim("../analysis/Xchromosome/Diaprepes-nuclear.fa.fai", 
                               as.is = T,
                               header = F)
Dab.genome.index.pcer <- Dab.genome.index.pcer[order(Dab.genome.index.pcer$V2,decreasing = T),]
# read Tcas genome index
Pcer.genome.index <- read.delim("../analysis/Xchromosome/Polydrusus-genome.fna.fai", 
                                as.is = T,
                                header = F)

sum(Tcas.busco.complete$Busco.id %in% Pcer.busco.complete$Busco.id)

# make karyotype table for Dab genome
Dab.genome.index.pcer <- Dab.genome.index.pcer[Dab.genome.index.pcer$V1 %in% Dab.Per.busco.complete$Sequence,]
Dab.genome.index.pcer <- Dab.genome.index.pcer[,c(1,2)]
colnames(Dab.genome.index.pcer) <- c("Chr","End")

# add additional cols
Dab.genome.index.pcer$identifier <- "chr"
Dab.genome.index.pcer$start <- 0
Dab.genome.index.pcer$cols <- "b2abd2"
Dab.genome.index.pcer$name <- paste("Dab",1:nrow(Dab.genome.index.pcer),sep = "")
Dab.genome.index.pcer$sep <- "-"

# re-order columns
Dab.genome.index.pcer <- Dab.genome.index.pcer[,c(3,7,1,6,4,2,5)]

# make karyotype table for Tcas genome
Pcer.genome.index <- Pcer.genome.index[,c(1,2)]
Pcer.genome.index <- Pcer.genome.index[which(Pcer.genome.index$V1 == "OW284520.1"),]
colnames(Pcer.genome.index) <- c("Chr","End")

# add additional cols
Pcer.genome.index$identifier <- "chr"
Pcer.genome.index$start <- 0
Pcer.genome.index$cols <- "blue"
Pcer.genome.index$name <- "ChrX"
Pcer.genome.index$sep <- "-"

# re-order columns
Pcer.genome.index <- Pcer.genome.index[,c(3,7,1,6,4,2,5)]

# adjust chromosome names accordingly
Tcas.genome.index$Chr <- "Tc-x"
Pcer.genome.index$Chr <- "PcX"

# sort busco tables based on busco ID
Pcer.busco.complete <- Pcer.busco.complete[order(Pcer.busco.complete$Busco.id),]
Dab.Per.busco.complete <- Dab.Per.busco.complete[order(Dab.Per.busco.complete$Busco.id),]
# get the start and end possitions
Pcer.busco.match <- Pcer.busco.complete[,c(3,4,5)]
Dab.per.busco.match <- Dab.Per.busco.complete[,c(3,4,5)]

for(i in 1:nrow(Dab.per.busco.match)){
  Dab.per.busco.match$Sequence[i] <- which(Dab.genome.index$Chr %in% Dab.per.busco.match$Sequence[i])
}

Dab.per.busco.match$Species_1 <- paste("Da-",Dab.per.busco.match$Species_1,sep = "")

colnames(Dab.per.busco.match) <- c("Species_1", "Start_1", "End_1")
Pcer.busco.match$Sequence <- rep("PcX", nrow(Pcer.busco.match))
colnames(Pcer.busco.match) <- c("Species_2", "Start_2", "End_2")

# assign colours
uniqCol <- "b2abd2"
shareCol <- "fdb863"
mostCol <- "e66101"

# make the synteny table
synteny.dab.tcas <- cbind(Dab.busco.match,Tcas.busco.match)
# make the synteny table
synteny.dab.pcer <- cbind(Dab.per.busco.match,Pcer.busco.match)

# colour shared contigs
Dab.genome.index$cols[Dab.genome.index$Chr %in% Dab.genome.index.pcer$Chr] <- shareCol
Dab.genome.index.pcer$cols[Dab.genome.index.pcer$Chr %in% Dab.genome.index$Chr] <- shareCol
# colour uniq contigs
Dab.genome.index$cols[!(Dab.genome.index$Chr %in% Dab.genome.index.pcer$Chr)] <- uniqCol
Dab.genome.index.pcer$cols[!(Dab.genome.index.pcer$Chr %in% Dab.genome.index$Chr)] <- uniqCol

# rename contig names
contNames <- paste("Da-", 1:length(Dab.genome.index$Chr),sep = "")
names(contNames) <- Dab.genome.index$Chr
for(i in 1:nrow(Dab.genome.index)){
  Dab.genome.index$Chr[i] <- contNames[names(contNames) == Dab.genome.index$Chr[i]]
}
for(i in 1:nrow(Dab.genome.index.pcer)){
  Dab.genome.index.pcer$Chr[i] <- contNames[names(contNames) == Dab.genome.index.pcer$Chr[i]]
}
# colour the contig with the most connection
Dab.genome.index$cols[Dab.genome.index$Chr == names(which(table(synteny.dab.tcas$Species_1) > 20))] <- mostCol
Dab.genome.index.pcer$cols[Dab.genome.index.pcer$Chr == names(which(table(synteny.dab.pcer$Species_1) > 20))] <- mostCol

# subset synteny tabs
synteny.dab.tcas_Da_2 <- synteny.dab.tcas[synteny.dab.tcas$Species_1 == names(which(table(synteny.dab.tcas$Species_1) > 20)),]
synteny.dab.tcas_other <- synteny.dab.tcas[synteny.dab.tcas$Species_1 != names(which(table(synteny.dab.tcas$Species_1) > 20)),]

synteny.dab.pcer_Da_2 <- synteny.dab.pcer[synteny.dab.pcer$Species_1 == names(which(table(synteny.dab.pcer$Species_1) > 20)),]
synteny.dab.pcer_other <- synteny.dab.pcer[synteny.dab.pcer$Species_1 != names(which(table(synteny.dab.pcer$Species_1) > 20)),]

# write files
dir.create("../figures/Sex-chromosome-ID/Dab-tcas/",recursive = T)
dir.create("../figures/Sex-chromosome-ID/Dab-Pcer/",recursive = T)

write.table(Dab.genome.index, file = "../figures/Sex-chromosome-ID/Dab-tcas/circos.karyotype.diaprepes.txt",quote = F,col.names = F,row.names = F,sep = "\t")
write.table(Tcas.genome.index, file = "../figures/Sex-chromosome-ID/Dab-tcas/circos.karyotype.tribolium.txt",quote = F,col.names = F,row.names = F,sep = "\t")
write.table(synteny.dab.tcas_other, file = "../figures/Sex-chromosome-ID/Dab-tcas/links.txt",quote = F,col.names = F,row.names = F,sep = " ",)
write.table(synteny.dab.tcas_Da_2, file = "../figures/Sex-chromosome-ID/Dab-tcas/links-2.txt",quote = F,col.names = F,row.names = F,sep = " ",)

write.table(Dab.genome.index.pcer, file = "../figures/Sex-chromosome-ID/Dab-Pcer/circos.karyotype.diaprepes.txt",quote = F,col.names = F,row.names = F,sep = "\t")
write.table(Pcer.genome.index, file = "../figures/Sex-chromosome-ID/Dab-Pcer/circos.karyotype.pcer.txt",quote = F,col.names = F,row.names = F,sep = "\t")
write.table(synteny.dab.pcer_other, file = "../figures/Sex-chromosome-ID/Dab-Pcer/links.txt",quote = F,col.names = F,row.names = F,sep = " ",)
write.table(synteny.dab.pcer_Da_2, file = "../figures/Sex-chromosome-ID/Dab-Pcer/links-2.txt",quote = F,col.names = F,row.names = F,sep = " ",)

