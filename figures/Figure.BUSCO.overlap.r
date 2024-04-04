library(png)
setwd("C:/PostDoc-UofM/Projects/Diaprepes/figures")
# read circos plots
img1 <- readPNG('Sex-chromosome-ID/Dab-tcas/circos.png')
img2 <- readPNG('Sex-chromosome-ID/Dab-Pcer/circos.png')

# plot
pdf("Figure.BUSCO.overlap.pdf",width = 8,height = 4)

par(mfcol = c(1,2),mar = c(0,0,0,0))
plot(as.raster(img1))
mtext("A",side = 3,outer = F,line = -5,adj = 0)
plot(as.raster(img2))
mtext("B",side = 3,outer = F,line = -5,adj = 0)
# add legend
legend("topright",legend = c("Shared contigs",
                            "Unique contigs",
                            "Reference X",
                            "Contig with most overlap"),
       bty = "n",
       pch = 16,
       col = c("#fdb863",
               "#b2abd2",
               "#6baed6",
               "#e66101"))
dev.off()
