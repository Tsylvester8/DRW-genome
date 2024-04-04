# Terrence Sylvester
# pradakshanas@gmail.com
# 3/31/2023

# load library
library(png)

# load coverage comparisons
load("../scripts/RData.assess.coverage.RData")

setwd("C:/PostDoc-UofM/Projects/Diaprepes/figures")
# read circos plots
img1 <- readPNG('Sex-chromosome-ID/Dab-tcas/circos.png')
img2 <- readPNG('Sex-chromosome-ID/Dab-Pcer/circos.png')

# remove NAs
comps <- comps[!(is.na(comps$comparison)),]

# plot
{
  pdf(file = "Figure.2.sexchrom.ID.pdf",width = 8,height = 8)
# set canvas
# layout(matrix(c(1,1,2,2,
                # 1,1,2,2,
                # 3,3,4,4,
                # 3,3,4,4), 4, 4, byrow = TRUE))
mar <- par()$mar
par(mfrow = c(2,2))
# make histogram
hist(cov_dat$meandepth, breaks = 100,
     xlim = c(0,30),
     main = "",
     xlab = "Read depth",
     col = "lightblue")
mtext(text = "A",side = 3,adj = 0)
hist(comps$ratio,breaks = 100,
     col = "lightblue",
     main = "",
     xlab = "Coverage ratio")
mtext(text = "B",side = 3,adj = 0)
#par(mar = c(1,1,1,1))
par(mar=c(1, 1, 1, 1), xpd=TRUE)
plot(as.raster(img1))
par(mar = mar)
mtext("C",side = 3,outer = F,line = 0,adj = 0)
par(mar=c(1, 1, 1, 1), xpd=TRUE)
plot(as.raster(img2))
par(mar = mar)
mtext("D",side = 3,outer = F,line = 0,adj = 0)
# add legend
par(xpd = NA,
    bg = "transparent")
legend("bottomleft",legend = c("Shared contigs",
                               "Unique contigs",
                               "Reference X",
                               "Contig with most overlap"),
       bty = "n",
       pch = 16,
       col = c("#fdb863",
               "#b2abd2",
               "#6baed6",
               "#e66101"),
       inset=c(-0.2, 0),y.intersp = 0.7)

dev.off()
}



# 
# 
# 
# 
# 
# 
# 
# 
# 
# 
# 
# 
# pdf(file = "Figure.coverage.comps.dens.pdf",width = 8,height = 4,)
# # plot densities
# par(mfcol = c(1,2))
# plot(density(cov_dat$meandepth[cov_dat$meandepth < 30]),
#      zero.line = F,
#      xlab = "Read depth",
#      main = "",
#      xlim = c(0,30))
# polygon(density(cov_dat$meandepth[cov_dat$meandepth < 30]),
#         col = rgb(0,0,1,0.3),
#         border = rgb(0,0,1,1),)
# mtext(text = "A",side = 3,adj = 0)
# plot(density(comps$ratio),
#      zero.line = F,
#      xlab = "Read depth ratio",
#      main = "")
# polygon(density(comps$ratio),
#         col = rgb(0,0,1,0.3),
#         border = rgb(0,0,1,1),)
# mtext(text = "B",side = 3,adj = 0)
# dev.off()