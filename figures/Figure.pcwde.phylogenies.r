# Terrence Sylvester
# pradakshanas@gmail.com
# 3/17/2023

cgroup <- c("#e41a1c",
            "#377eb8",
            "#4daf4a",
            "#984ea3",
            "#ff7f00",
            "#ffff33",
            "#a65628",
            "#f781bf")

library(phytools)
# read in trees
trees_2023 <- dir("../data/pcwde.phylogeny/trees/")
for(j in 1:length(trees_2023)){
  tree <- NULL
  # read tree
  tree <- read.newick(paste("../data/pcwde.phylogeny/trees/", trees_2023[j], sep = ""))
  #tree <- read.newick("../data/pcwde.phylogeny/deprecated/mckenna.2019.trees/PL4_ML.tree")
  # set tip colours
  col <- vector(mode = "numeric",length = length(tree$tip.label))
  col <- col + 1
  pch <- rep(NA,length = length(tree$tip.label))
  
  # set the phytophaga families
  curculionoidea <- c("Cimberididae",
                      "Nemonychidae",
                      "Anthribidae",
                      "Belidae",
                      "Attelabidae",
                      "Caridae",
                      "Brentidae",
                      "Curculionidae")
  
  chrysomeloidea <- c("Megalopodidae",
                      "Oxypeltidae",
                      "Orsodacnidae",
                      "Vesperidae",
                      "Disteniidae",
                      "Cerambycidae",
                      "Chrysomelidae")
  
  Arthropoda <- c("Crustacea",
                  "Phasmatodea",
                  "Megaloptera",
                  "Raphidioptera",
                  "Blattodea")
  
  # Chordata
  # Lophotrochozoa
  # Echinodermata
  
  for(i in 1:length(tree$tip.label)){
    if(sum(unlist(strsplit(tree$tip.label[i],split = "_")) %in% c("Coleoptera")) >= 1) {
      col[i]<- viridis::viridis(9,begin = 0, end = 0.9,option = "H")[1]
      pch[i] <- 15
      col[i] <- "black"
    }
    if(sum(unlist(strsplit(tree$tip.label[i],split = "_")) %in% chrysomeloidea) >= 1){
      col[i]<- viridis::viridis(9,begin = 0, end = 0.9,option = "H")[1]
      pch[i] <- 16
      col[i] <- "black"
    }
    if(sum(unlist(strsplit(tree$tip.label[i],split = "_")) %in% curculionoidea) >= 1){
      col[i]<- viridis::viridis(9,begin = 0, end = 0.9,option = "H")[1]
      pch[i] <- 17
      col[i] <- "black"
    }
    if(sum(unlist(strsplit(tree$tip.label[i],split = ".",fixed = T)) %in% c("anno1","anno2")) >= 1){
      col[i]<- viridis::viridis(9,begin = 0, end = 0.9,option = "H")[1]
      pch[i] <- 8
      col[i] <- "black"
    }
    if(sum(unlist(strsplit(tree$tip.label[i],split = "_")) %in% c("Diaprepes")) >= 1){
      col[i]<- viridis::viridis(9,begin = 0, end = 0.9,option = "H")[1]
      pch[i] <- 1
      col[i] <- "black"
    }
    if(sum(unlist(strsplit(tree$tip.label[i],split = "_")) %in% c(Arthropoda)) >= 1) {
      col[i]<- viridis::viridis(9,begin = 0, end = 0.9,option = "H")[2]
      col[i] <- cgroup[1]
    }
    if(sum(unlist(strsplit(tree$tip.label[i],split = "_")) %in% c("Bacteria")) >= 1) {
      col[i] <- viridis::viridis(9,begin = 0, end = 0.9,option = "H")[3]
      col[i] <- cgroup[2]
    }
    if(sum(unlist(strsplit(tree$tip.label[i],split = "_")) %in% c("Fungi","Oomycota")) >= 1) {
      col[i]<- viridis::viridis(9,begin = 0, end = 0.9,option = "H")[4]
      col[i] <- cgroup[3]
    }
    if(sum(unlist(strsplit(tree$tip.label[i],split = "_")) %in% c("Alviolata")) >= 1) {
      col[i]<- viridis::viridis(9,begin = 0, end = 0.9,option = "H")[5]
      col[i] <- cgroup[4]
    }
    if(sum(unlist(strsplit(tree$tip.label[i],split = "_")) %in% c("Archaea")) >= 1) {
      col[i]<- viridis::viridis(9,begin = 0, end = 0.9,option = "H")[6]
      col[i] <- cgroup[5]
    }
    if(sum(unlist(strsplit(tree$tip.label[i],split = "_")) %in% c("Mollusca")) >= 1) {
      col[i]<- viridis::viridis(9,begin = 0, end = 0.9,option = "H")[7]
      col[i] <- cgroup[6]
    }
    if(sum(unlist(strsplit(tree$tip.label[i],split = "_")) %in% c("Nematoda")) >= 1) {
      col[i]<- viridis::viridis(9,begin = 0, end = 0.9,option = "H")[8]
      col[i] <- cgroup[7]
    }
    if(sum(unlist(strsplit(tree$tip.label[i],split = "_")) %in% c("Plantae")) >= 1) {
      col[i]<- viridis::viridis(9,begin = 0, end = 0.9,option = "H")[9]
      col[i] <- cgroup[8]
    }
  }
  
  #col[col == "1"] <- viridis::viridis(15,begin = 0, end = 0.9,,option = "H")[15]
  pdf(file = paste("2023-", gsub(".treefile",".pdf",trees_2023[j]),sep = ""))
  par(mar = c(0,0,0,0))
  ecol <- tree$edge[,2]
  
  for(i in 1:length(col)){
    ecol[which(ecol == i)] <- col[i]
  }
  ecol[!(ecol %in% col)] <- "grey"
  plot(tree, show.tip.label = F,type = "unrooted",edge.width = 1,edge.color = ecol)
  tiplabels(pch = pch, cex = 0.8, col = col)
  # add legend
  legend("topleft",
         legend = c("Coleoptera",
                    "Coleoptera: Chrysomeloidea",
                    "Coleoptera: Curculionoidea",
                    "Coleoptera: Curculionoidea: Diaprepes - Current work",
                    "Coleoptera: Curculionoidea: Diaprepes - McKenna et.al., 2019",
                    "Arthropoda (excluding Coleoptera)",
                    "Bacteria",
                    "Fungi, Oomycota",
                    "Alviolata",
                    "Archaea",
                    "Mollusca",
                    "Nematoda",
                    "Viridiplante"),
         bty = "n",
         cex = 0.7,
         pch = c(15,16,17,8,1,NA,NA,NA,NA,NA,NA,NA,NA),
         lty = c(NA,NA,NA,NA,NA,1,1,1,1,1,1,1,1),
         lwd = 2,
         col = c("black",cgroup)[c(1,1,1,1,1,2,3,4,5,6,7,8,9)],
         inset = 0.000001)
  dev.off()
}



# for(j in 1:length(trees_2019)){
#   tree <- NULL
#   # read tree
#   tree <- read.newick(paste("../data/pcwde.phylogeny/deprecated/mckenna.2019.trees/", trees_2019[j], sep = ""))
#   # set tip colours
#   col <- vector(mode = "numeric",length = length(tree$tip.label))
#   col <- col + 1
#   ecol <- rep("black", nrow(tree$edge))
#   
#   # set the phytophaga families
#   curculionoidea <- c("Cimberididae",
#                       "Nemonychidae",
#                       "Anthribidae",
#                       "Belidae",
#                       "Attelabidae",
#                       "Caridae",
#                       "Brentidae",
#                       "Curculionidae")
#   
#   chrysomeloidea <- c("Megalopodidae",
#                       "Oxypeltidae",
#                       "Orsodacnidae",
#                       "Vesperidae",
#                       "Disteniidae",
#                       "Cerambycidae",
#                       "Chrysomelidae")
#   
#   
#   ecol[which(tree$edge[,2] %in% 1:Ntip(tree))] <- viridis::viridis(7,begin = 0.1,option = "H")[1]
#   
#   for(i in 1:length(tree$tip.label)){
#     # bacteria and fungi
#     if(sum(unlist(strsplit(tree$tip.label[i],split = "_")) %in% c("Bacteria")) >= 1) col[i] <- ecol[which(tree$edge[,2] %in% i)] <- viridis::viridis(7,begin = 0.1,option = "H")[2] ; 
#     if(sum(unlist(strsplit(tree$tip.label[i],split = "_")) %in% c("Fungi")) >= 1) col[i] <- ecol[which(tree$edge[,2] %in% i)] <- viridis::viridis(7,begin = 0.1,option = "H")[2] 
#     # coleoptera 
#     if(sum(unlist(strsplit(tree$tip.label[i],split = "_")) %in% c("Coleoptera")) >= 1) col[i] <- ecol[which(tree$edge[,2] %in% i)] <- viridis::viridis(7,begin = 0.1,option = "H")[3] 
#     if(sum(unlist(strsplit(tree$tip.label[i],split = "_")) %in% chrysomeloidea) >= 1) col[i] <- ecol[which(tree$edge[,2] %in% i)] <- viridis::viridis(7,begin = 0.1,option = "H")[4] 
#     if(sum(unlist(strsplit(tree$tip.label[i],split = "_")) %in% curculionoidea) >= 1) col[i] <- ecol[which(tree$edge[,2] %in% i)] <- viridis::viridis(7,begin = 0.1,option = "H")[5] 
#     
#     # diaprepes
#     if(sum(unlist(strsplit(tree$tip.label[i],split = ".",fixed = T)) %in% c("anno1","anno2")) >= 1) col[i] <- ecol[which(tree$edge[,2] %in% i)] <- viridis::viridis(7,begin = 0.1,option = "H")[6] 
#     if(sum(unlist(strsplit(tree$tip.label[i],split = "_")) %in% c("Diaprepes")) >= 1) col[i] <- ecol[which(tree$edge[,2] %in% i)] <- viridis::viridis(7,begin = 0.1,option = "H")[7] 
#   }
#   
#   col[col == "1"] <- viridis::viridis(7,begin = 0.1,option = "H")[1]
#   
#   
#   # plot tree
#   #plot(tree, show.tip.label = F,type = "unrooted",edge.color = ecol,edge.width = 1)
#   
#   pdf(file = paste("2019-", gsub("_ML.tree",".pdf",trees_2019[j]),sep = ""))
#   plot(tree, show.tip.label = F,type = "unrooted",edge.width = 1)
#   tiplabels(pch = 16, cex = 0.4, col = col)
#   # add legend
#   legend("topleft",
#          legend = c("Bacteria and fungi","Coleoptera",
#                     "Chrysomeloidea",
#                     "Curculionoidea",
#                     "Diaprepes - This work",
#                     "Diaprepes - Mckenna 2019",
#                     "Other"),
#          bty = "n",
#          cex = 0.7,
#          pch = 16,
#          col = viridis::viridis(7,begin = 0.1,option = "H")[c(2,3,4,5,6,7,1)],
#          inset = 0.000001)
#   dev.off()
# }




# 
# # read tree
# tree <- read.newick("../data/pcwde.phylogeny/trees/GH1.treefile")
# #tree <- read.newick("../data/pcwde.phylogeny/deprecated/mckenna.2019.trees/PL4_ML.tree")
# # set tip colours
# col <- vector(mode = "numeric",length = length(tree$tip.label))
# col <- col + 1
# ecol <- rep("black", nrow(tree$edge))
# 
# # set the phytophaga families
# curculionoidea <- c("Cimberididae",
#                     "Nemonychidae",
#                     "Anthribidae",
#                     "Belidae",
#                     "Attelabidae",
#                     "Caridae",
#                     "Brentidae",
#                     "Curculionidae")
# 
# chrysomeloidea <- c("Megalopodidae",
#                     "Oxypeltidae",
#                     "Orsodacnidae",
#                     "Vesperidae",
#                     "Disteniidae",
#                     "Cerambycidae",
#                     "Chrysomelidae")
# 
# 
# ecol[which(tree$edge[,2] %in% 1:Ntip(tree))] <- viridis::viridis(7,begin = 0.1,option = "H")[1]
# 
# for(i in 1:length(tree$tip.label)){
#   # bacteria and fungi
#   if(sum(unlist(strsplit(tree$tip.label[i],split = "_")) %in% c("Bacteria")) >= 1) col[i] <- ecol[which(tree$edge[,2] %in% i)] <- viridis::viridis(7,begin = 0.1,option = "H")[2] ; 
#   if(sum(unlist(strsplit(tree$tip.label[i],split = "_")) %in% c("Fungi")) >= 1) col[i] <- ecol[which(tree$edge[,2] %in% i)] <- viridis::viridis(7,begin = 0.1,option = "H")[2] 
#   # coleoptera 
#   if(sum(unlist(strsplit(tree$tip.label[i],split = "_")) %in% c("Coleoptera")) >= 1) col[i] <- ecol[which(tree$edge[,2] %in% i)] <- viridis::viridis(7,begin = 0.1,option = "H")[3] 
#   if(sum(unlist(strsplit(tree$tip.label[i],split = "_")) %in% chrysomeloidea) >= 1) col[i] <- ecol[which(tree$edge[,2] %in% i)] <- viridis::viridis(7,begin = 0.1,option = "H")[4] 
#   if(sum(unlist(strsplit(tree$tip.label[i],split = "_")) %in% curculionoidea) >= 1) col[i] <- ecol[which(tree$edge[,2] %in% i)] <- viridis::viridis(7,begin = 0.1,option = "H")[5] 
#   
#   # diaprepes
#   if(sum(unlist(strsplit(tree$tip.label[i],split = ".",fixed = T)) %in% c("anno1","anno2")) >= 1) col[i] <- ecol[which(tree$edge[,2] %in% i)] <- viridis::viridis(7,begin = 0.1,option = "H")[6] 
#   if(sum(unlist(strsplit(tree$tip.label[i],split = "_")) %in% c("Diaprepes")) >= 1) col[i] <- ecol[which(tree$edge[,2] %in% i)] <- viridis::viridis(7,begin = 0.1,option = "H")[7] 
# }
# 
# 
# 
# # plot tree
# #plot(tree, show.tip.label = F,type = "unrooted",edge.color = ecol,edge.width = 1)
# 
# pdf()
# plot(tree, show.tip.label = F,type = "unrooted",edge.width = 1)
# tiplabels(pch = 16, cex = 0.4, col = col)
# # add legend
# legend("topleft",
#        legend = c("Bacteria and fungi","Coleoptera",
#                   "Chrysomeloidea",
#                   "Curculionoidea",
#                   "Diaprepes - This work",
#                   "Diaprepes - Mckenna 2019",
#                   "Other"),
#        bty = "n",
#        cex = 0.7,
#        pch = 16,
#        col = viridis::viridis(7,begin = 0.1,option = "H")[c(2,3,4,5,6,7,1)],
#        inset = 0.000001)
# dev.off()




# pdf(file = "Figure.pcwde.philogenies.2023.pdf",width = 7,height = 7)
# layout(matrix(c(1,1,1,8,
#                 1,1,1,7,
#                 1,1,1,6,
#                 2,3,4,5), 4, 4, byrow = TRUE))
# 
# par(mar = c(0,0,0,0))
# 
# for(j in 1:length(trees_2023)){
#   tree <- NULL
#   # read tree
#   tree <- read.newick(paste("../data/pcwde.phylogeny/trees/", trees_2023[j], sep = ""))
#   #tree <- read.newick("../data/pcwde.phylogeny/deprecated/mckenna.2019.trees/PL4_ML.tree")
#   # set tip colours
#   col <- vector(mode = "numeric",length = length(tree$tip.label))
#   col <- col + 1
#   ecol <- rep("black", nrow(tree$edge))
#   
#   # set the phytophaga families
#   curculionoidea <- c("Cimberididae",
#                       "Nemonychidae",
#                       "Anthribidae",
#                       "Belidae",
#                       "Attelabidae",
#                       "Caridae",
#                       "Brentidae",
#                       "Curculionidae")
#   
#   chrysomeloidea <- c("Megalopodidae",
#                       "Oxypeltidae",
#                       "Orsodacnidae",
#                       "Vesperidae",
#                       "Disteniidae",
#                       "Cerambycidae",
#                       "Chrysomelidae")
#   
#   
#   ecol[which(tree$edge[,2] %in% 1:Ntip(tree))] <- viridis::viridis(7,begin = 0.1,option = "H")[1]
#   
#   for(i in 1:length(tree$tip.label)){
#     # bacteria and fungi
#     if(sum(unlist(strsplit(tree$tip.label[i],split = "_")) %in% c("Bacteria")) >= 1) col[i] <- ecol[which(tree$edge[,2] %in% i)] <- viridis::viridis(7,begin = 0.1,option = "H")[2] ; 
#     if(sum(unlist(strsplit(tree$tip.label[i],split = "_")) %in% c("Fungi")) >= 1) col[i] <- ecol[which(tree$edge[,2] %in% i)] <- viridis::viridis(7,begin = 0.1,option = "H")[2] 
#     # coleoptera 
#     if(sum(unlist(strsplit(tree$tip.label[i],split = "_")) %in% c("Coleoptera")) >= 1) col[i] <- ecol[which(tree$edge[,2] %in% i)] <- viridis::viridis(7,begin = 0.1,option = "H")[3] 
#     if(sum(unlist(strsplit(tree$tip.label[i],split = "_")) %in% chrysomeloidea) >= 1) col[i] <- ecol[which(tree$edge[,2] %in% i)] <- viridis::viridis(7,begin = 0.1,option = "H")[4] 
#     if(sum(unlist(strsplit(tree$tip.label[i],split = "_")) %in% curculionoidea) >= 1) col[i] <- ecol[which(tree$edge[,2] %in% i)] <- viridis::viridis(7,begin = 0.1,option = "H")[5] 
#     
#     # diaprepes
#     if(sum(unlist(strsplit(tree$tip.label[i],split = ".",fixed = T)) %in% c("anno1","anno2")) >= 1) col[i] <- ecol[which(tree$edge[,2] %in% i)] <- viridis::viridis(7,begin = 0.1,option = "H")[6] 
#     if(sum(unlist(strsplit(tree$tip.label[i],split = "_")) %in% c("Diaprepes")) >= 1) col[i] <- ecol[which(tree$edge[,2] %in% i)] <- viridis::viridis(7,begin = 0.1,option = "H")[7] 
#   }
#   
#   col[col == "1"] <- viridis::viridis(7,begin = 0.1,option = "H")[1]
#   
#   
#   # plot tree
#   #plot(tree, show.tip.label = F,type = "unrooted",edge.color = ecol,edge.width = 1)
#   
#   #pdf(file = paste("2023-", gsub(".treefile",".pdf",trees_2023[j]),sep = ""))
#   plot(tree, show.tip.label = F,type = "unrooted",edge.width = 1,tip.color = col,rotate.tree = 90)
#   tiplabels(pch = 16, cex = 0.4, col = col)
#   # dev.off()
#   mtext(text = LETTERS[j],side = 3,line = -2,adj = 0)
# }
# plot(NULL ,xaxt='n',yaxt='n',bty='n',ylab='',xlab='', xlim=0:1, ylim=0:1)
# # add legend
# legend("center",
#        legend = c("Bacteria and fungi","Coleoptera",
#                   "Chrysomeloidea",
#                   "Curculionoidea",
#                   "Diaprepes - This work",
#                   "Diaprepes - McKenna 2019",
#                   "Other"),
#        bty = "n",
#        cex = 0.9,
#        pt.cex = 1.8,
#        pch = 16,
#        col = viridis::viridis(7,begin = 0.1,option = "H")[c(2,3,4,5,6,7,1)],
#        inset = 0.000001)
# 
# dev.off()

# reorder trees
#trees_2023 <- trees_2023[c(1,6,2,3,4,5,7)]
# trees_2019 <- dir("../data/pcwde.phylogeny/deprecated/mckenna.2019.trees/")

# trees_2019 <- trees_2019[gsub("_ML.tree","",trees_2019) %in% gsub(".treefile","",trees_2023)]

