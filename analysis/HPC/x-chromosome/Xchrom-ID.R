# load libraries
library(RIdeogram)

# read Dab busco result
Dab.busco <- read.delim("full_table.tsv",
                        as.is = T,
                        header = T)
Tcas.busco <- read.delim("TcasLGX_full_table.tsv",
                         as.is = T, 
                         header = T)
Tcas.busco <- Tcas.busco[Tcas.busco$Sequence == "NC_007416.3_LGX",]

# retain only complete single copy BUSCOs
Tcas.busco.complete <- Tcas.busco[Tcas.busco$Status == "Complete",]
# parse Dab busco based on Tcas busco gene ids
Dab.busco.overlap <- Dab.busco[Dab.busco$Busco.id %in% Tcas.busco.complete$Busco.id,]
# keep only complete buscos
Dab.busco.complete <- Dab.busco.overlap[Dab.busco.overlap$Status == "Complete",]
# remove missing buscos from Tcas gene set
Tcas.busco.complete <- Tcas.busco.complete[Tcas.busco.complete$Busco.id %in% Dab.busco.complete$Busco.id,]

# remove other variales from environment
rm(list = c("Dab.busco","Dab.busco.overlap","Tcas.busco"))

# read diaprepes genome index
Dab.genome.index <- read.delim("Diaprepes-nuclear.fa.fai", 
                               as.is = T,
                               header = F)
Dab.genome.index <- Dab.genome.index[order(Dab.genome.index$V2,decreasing = T),]

# read Tcas genome index
Tcas.genome.index <- read.delim("Tcas-LGX.fasta.fai", 
                               as.is = T,
                               header = F)

# make karyotype table for Dab genome
Dab.genome.index <- Dab.genome.index[Dab.genome.index$V1 %in% Dab.busco.complete$Sequence,]
Dab.genome.index <- Dab.genome.index[,c(1,2)]
colnames(Dab.genome.index) <- c("Chr","End")
Dab.genome.index$Start <- rep(1, nrow(Dab.genome.index))
Dab.genome.index <- Dab.genome.index[,c(1,3,2)]
Dab.genome.index$fill <- rep(969696, nrow(Dab.genome.index))
Dab.genome.index$species <- rep("D. abbreviatus", nrow(Dab.genome.index))
Dab.genome.index$size <- rep(12, nrow(Dab.genome.index))
Dab.genome.index$color <- rep(252525, nrow(Dab.genome.index))

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
karyotype <- rbind(Dab.genome.index,Tcas.genome.index)
rownames(karyotype) <- 1:nrow(karyotype)

# sort busco tables based on busco ID
Tcas.busco.complete <- Tcas.busco.complete[order(Tcas.busco.complete$Busco.id),]
Dab.busco.complete <- Dab.busco.complete[order(Dab.busco.complete$Busco.id),]

# get the start and end possitions
Tcas.busco.match <- Tcas.busco.complete[,c(3,4,5)]
Dab.busco.match <- Dab.busco.complete[,c(3,4,5)]
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

karyotype$Chr <- c(letters[1:24],"LGX")
#karyotype$Chr <- c(rep(NA,21),"LGX")
karyotype$size <- rep(12, nrow(karyotype))





#karyotype <- karyotype[c(order(table(synteny$Species_1),decreasing = T),22),]
ideogram(karyotype = karyotype,
         synteny = synteny)
convertSVG("chromosome.svg", device = "png")

