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

#### Pcer vs Dab ####
# parse Dab busco based on Tcas busco gene ids
Dab.Per.busco.overlap <- Dab.busco[Dab.busco$Busco.id %in% Pcer.busco.complete$Busco.id,]
# keep only complete buscos
Dab.Per.busco.complete <- Dab.Per.busco.overlap[Dab.Per.busco.overlap$Status == "Complete",]
# remove missing buscos from Tcas gene set
Pcer.busco.complete <- Pcer.busco.complete[Pcer.busco.complete$Busco.id %in% Dab.Per.busco.complete$Busco.id,]

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
# read Tcas genome index
Pcer.genome.index <- read.delim("../analysis/Xchromosome/Polydrusus-genome.fna.fai", 
                                as.is = T,
                                header = F)


# make karyotype table for Dab genome
Dab.genome.index.tcas <- Dab.genome.index[Dab.genome.index$V1 %in% Dab.Tcas.busco.complete$Sequence,]
Dab.genome.index.tcas <- Dab.genome.index.tcas[,c(1,2)]
colnames(Dab.genome.index.tcas) <- c("Chr","End")
Dab.genome.index.tcas$Start <- rep(1, nrow(Dab.genome.index.tcas))
Dab.genome.index.tcas <- Dab.genome.index.tcas[,c(1,3,2)]
Dab.genome.index.tcas$fill <- rep(969696, nrow(Dab.genome.index.tcas))
Dab.genome.index.tcas$species <- rep("D. abbreviatus", nrow(Dab.genome.index.tcas))
Dab.genome.index.tcas$size <- rep(12, nrow(Dab.genome.index.tcas))
Dab.genome.index.tcas$color <- rep(252525, nrow(Dab.genome.index.tcas))
# make karyotype table for Tcas genome
Tcas.genome.index <- Tcas.genome.index[,c(1,2)]
colnames(Tcas.genome.index) <- c("Chr","End")
Tcas.genome.index$Start <- rep(1, nrow(Tcas.genome.index))
Tcas.genome.index <- Tcas.genome.index[,c(1,3,2)]
Tcas.genome.index$fill <- rep(gsub("#","",(viridis::viridis(3)))[1], nrow(Tcas.genome.index))
Tcas.genome.index$species <- rep("T. castaneum", nrow(Tcas.genome.index))
Tcas.genome.index$size <- rep(12, nrow(Tcas.genome.index))
Tcas.genome.index$color <- rep(252525, nrow(Tcas.genome.index))
# combine both karyotype table
karyotype <- rbind(Dab.genome.index.tcas,Tcas.genome.index)
rownames(karyotype) <- 1:nrow(karyotype)




# sort busco tables based on busco ID
Tcas.busco.complete <- Tcas.busco.complete[order(Tcas.busco.complete$Busco.id),]
Dab.Tcas.busco.complete <- Dab.Tcas.busco.complete[order(Dab.Tcas.busco.complete$Busco.id),]
# get the start and end possitions
Tcas.busco.match <- Tcas.busco.complete[,c(3,4,5)]
Dab.busco.match <- Dab.Tcas.busco.complete[,c(3,4,5)]
for(i in 1:nrow(Dab.busco.match)){
  Dab.busco.match$Sequence[i] <- which(karyotype$Chr %in% Dab.busco.match$Sequence[i])
}
colnames(Dab.busco.match) <- c("Species_1", "Start_1", "End_1")
Tcas.busco.match$Sequence <- rep(1, nrow(Tcas.busco.match))
colnames(Tcas.busco.match) <- c("Species_2", "Start_2", "End_2")
# make the synteny table
synteny <- cbind(Dab.busco.match,Tcas.busco.match)
synteny$fill <- rep("cccccc",nrow(synteny))
synteny$Species_1 <- as.numeric(synteny$Species_1)
# change colours accordingly
karyotype$fill[which(table(synteny$Species_1) >= 2)] <- gsub("#","",(viridis::viridis(3)))[2]
karyotype$fill[which(table(synteny$Species_1) < 2)] <- gsub("#","",(viridis::viridis(3)))[3]
#karyotype$fill[c(3,4,10,19)] <- "31688EFF"
#synteny$fill[synteny$Species_1 == 6] <- "440154FF"
synteny$fill[synteny$Species_1 %in% which(table(synteny$Species_1) >= 2) ] <- gsub("#","",(viridis::viridis(3)))[2]
synteny$fill[synteny$Species_1 %in% which(table(synteny$Species_1) < 2) ] <- gsub("#","",(viridis::viridis(3)))[3]
# write contignames
conts <- karyotype$Chr[-20]
write(conts, "BUSCO-hits-Tcas-Dab.txt")
karyotype$Chr <- c(letters[1:(nrow(karyotype)-1)],"LGX")
#karyotype$Chr <- c(rep(NA,21),"LGX")
karyotype$size <- rep(12, nrow(karyotype))





#karyotype <- karyotype[c(order(table(synteny$Species_1),decreasing = T),22),]
ideogram(karyotype = karyotype,
         synteny = synteny)
convertSVG("chromosome.svg", device = "png")

#### Pcer vs Dab ####
# parse Dab busco based on Tcas busco gene ids
Dab.Per.busco.overlap <- Dab.busco[Dab.busco$Busco.id %in% Pcer.busco.complete$Busco.id,]
# keep only complete buscos
Dab.Per.busco.complete <- Dab.Per.busco.overlap[Dab.Per.busco.overlap$Status == "Complete",]
# remove missing buscos from Tcas gene set
Pcer.busco.complete <- Pcer.busco.complete[Pcer.busco.complete$Busco.id %in% Dab.Per.busco.complete$Busco.id,]
# remove other variales from environment
#rm(list = c("Dab.busco","Dab.busco.overlap","Tcas.busco"))
# read diaprepes genome index
Dab.genome.index <- read.delim("../analysis/Xchromosome/Diaprepes-nuclear.fa.fai", 
                               as.is = T,
                               header = F)
Dab.genome.index <- Dab.genome.index[order(Dab.genome.index$V2,decreasing = T),]


sum(Tcas.busco.complete$Busco.id %in% Pcer.busco.complete$Busco.id)




# read diaprepes genome index
Dab.genome.index <- read.delim("../analysis/Xchromosome/Diaprepes-nuclear.fa.fai", 
                               as.is = T,
                               header = F)
Dab.genome.index <- Dab.genome.index[order(Dab.genome.index$V2,decreasing = T),]


# make karyotype table for Dab genome
Dab.genome.index.pcer <- Dab.genome.index[Dab.genome.index$V1 %in% Dab.Per.busco.complete$Sequence,]
Dab.genome.index.pcer <- Dab.genome.index.pcer[,c(1,2)]
colnames(Dab.genome.index.pcer) <- c("Chr","End")
Dab.genome.index.pcer$Start <- rep(1, nrow(Dab.genome.index.pcer))
Dab.genome.index.pcer <- Dab.genome.index.pcer[,c(1,3,2)]
Dab.genome.index.pcer$fill <- rep(969696, nrow(Dab.genome.index.pcer))
Dab.genome.index.pcer$species <- rep("D. abbreviatus", nrow(Dab.genome.index.pcer))
Dab.genome.index.pcer$size <- rep(12, nrow(Dab.genome.index.pcer))
Dab.genome.index.pcer$color <- rep(252525, nrow(Dab.genome.index.pcer))
# make karyotype table for Tcas genome
Pcer.genome.index <- Pcer.genome.index[,c(1,2)]
Pcer.genome.index <- Pcer.genome.index[which(Pcer.genome.index$V1 == "OW284520.1"),]
colnames(Pcer.genome.index) <- c("Chr","End")
Pcer.genome.index$Start <- rep(1, nrow(Pcer.genome.index))
Pcer.genome.index <- Pcer.genome.index[,c(1,3,2)]
Pcer.genome.index$fill <- rep(gsub("#","",(viridis::viridis(3)))[1], nrow(Pcer.genome.index))
Pcer.genome.index$species <- rep("T. castaneum", nrow(Pcer.genome.index))
Pcer.genome.index$size <- rep(12, nrow(Pcer.genome.index))
Pcer.genome.index$color <- rep(252525, nrow(Pcer.genome.index))
# combine both karyotype table
karyotype <- rbind(Dab.genome.index.pcer,Pcer.genome.index)
rownames(karyotype) <- 1:nrow(karyotype)
# sort busco tables based on busco ID
Pcer.busco.complete <- Pcer.busco.complete[order(Pcer.busco.complete$Busco.id),]
Dab.Per.busco.complete <- Dab.Per.busco.complete[order(Dab.Per.busco.complete$Busco.id),]
# get the start and end possitions
Pcer.busco.match <- Pcer.busco.complete[,c(3,4,5)]
Dab.busco.match <- Dab.Per.busco.complete[,c(3,4,5)]
for(i in 1:nrow(Dab.busco.match)){
  Dab.busco.match$Sequence[i] <- which(karyotype$Chr %in% Dab.busco.match$Sequence[i])
}
colnames(Dab.busco.match) <- c("Species_1", "Start_1", "End_1")
Pcer.busco.match$Sequence <- rep(1, nrow(Pcer.busco.match))
colnames(Pcer.busco.match) <- c("Species_2", "Start_2", "End_2")
# make the synteny table
synteny <- cbind(Dab.busco.match,Pcer.busco.match)
synteny$fill <- rep("cccccc",nrow(synteny))
synteny$Species_1 <- as.numeric(synteny$Species_1)
# change colours accordingly
karyotype$fill[which(table(synteny$Species_1) >= 2)] <- gsub("#","",(viridis::viridis(3)))[2]
karyotype$fill[which(table(synteny$Species_1) < 2)] <- gsub("#","",(viridis::viridis(3)))[3]
#karyotype$fill[c(3,4,10,19)] <- "31688EFF"
#synteny$fill[synteny$Species_1 == 6] <- "440154FF"
synteny$fill[synteny$Species_1 %in% which(table(synteny$Species_1) >= 2) ] <- gsub("#","",(viridis::viridis(3)))[2]
synteny$fill[synteny$Species_1 %in% which(table(synteny$Species_1) < 2) ] <- gsub("#","",(viridis::viridis(3)))[3]

karyotype$Chr <- paste("chr -",karyotype$Chr,sep = "")

print(karyotype[,c(1,2,3)],row.names = F)


synteny$Species_1 <- paste("Da", synteny$Species_1, sep = "")
synteny$Species_2 <- paste("PcX", sep = "")

synteny <- synteny[,c(1,2,3,4,5,6)]
print(synteny, row.names = F)


# write contignames
conts <- karyotype$Chr[-9]
write(conts, "BUSCO-hits-Pcer-Dab.txt")
karyotype$Chr <- c(letters[1:(nrow(karyotype)-1)],"LGX")
#karyotype$Chr <- c(rep(NA,21),"LGX")
karyotype$size <- rep(12, nrow(karyotype))
#karyotype <- karyotype[c(order(table(synteny$Species_1),decreasing = T),22),]
ideogram(karyotype = karyotype,
         synteny = synteny)
convertSVG("chromosome.svg", device = "png")


