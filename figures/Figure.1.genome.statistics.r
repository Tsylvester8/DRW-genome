# Terrence Sylvester
# pradakshanas@gmail.com
# April 4th 2023

#load libraries
library(png)
library(jpeg)
# read genomescope plot
img1 <- readPNG('../analysis/HPC/Assembly/nuclear-genome/kmer/33mer/linear_plot.png')
# read diaprepes plot
img2 <- readJPEG("Diaprepes figures/1322083-LGPT.jpg")
# read genome assembly index
faidx <- read.delim("../data/genome/Diaprepes-nuclear.fa.fai",
                    as.is = T,header = F)
# sort by read size
faidx <- faidx[,c(1,2)][order(faidx$V2,decreasing = T),]
# lable columns
colnames(faidx) <- c("contig","length")
faidx$cumsum <- cumsum((faidx$length / sum(faidx$length)) * 100)

faidx$length <- faidx$length / 1000000

mar <- par()$mar

# plot
pdf("Figure.1.genome.statistics.pdf",width = 8,height = 4)

par(mfcol = c(1,2))
#par(mar = c(0,0,0,0))

plot(as.raster(img2))
mtext("A",side = 3,outer = F,adj = 0)

par(mar = mar)

plot(x = NA,
     y = NA,
     xlim = c(0,100),
     ylim = c(0,62),
     xlab = "Cumulative percentage",
     ylab = "Contig length (Mbp)")

for(i in 1:nrow(faidx)){
  if(i == 1){
    segments(x0 = 0,
             y0 = faidx$length[1],
             x1 = faidx$cumsum[1],
             y1 = faidx$length[1])
    
    segments(x0 = faidx$cumsum[1],
             y0 = faidx$length[1],
             x1 = faidx$cumsum[1],
             y1 = faidx$length[2])
    
  }
  if(i > 1 & i < nrow(faidx)){
    segments(x0 = faidx$cumsum[i-1],
             y0 = faidx$length[i],
             x1 = faidx$cumsum[i],
             y1 = faidx$length[i])
    
    segments(x0 = faidx$cumsum[i],
             y0 = faidx$length[i],
             x1 = faidx$cumsum[i],
             y1 = faidx$length[i+1])
    
  }
  if(i == nrow(faidx)){
    segments(x0 = faidx$cumsum[i-1],
             y0 = faidx$length[i],
             x1 = 100,
             y1 = faidx$length[i])
  }
}
mtext("B",side = 3,outer = F,adj = 0)

# plot N50
abline(v = 50, col = "red", lty = 2)
text(x = 50, y = 62, "N50 = 7.8Mb", pos = 4, cex = 0.5)

# add busco information
text(x = rep(55,6), 
     y = c(22,18,16,14,12,10),
     labels = c(expression(paste(bold("BUSCO statistics"))),
                "Complete: 99.5%",
                "Complete and single-copy: 98%",
                "Complete and duplicated: 1.5%",
                "Fragmented: 0%",
                "Missing: 0.5%"),
     adj = 0,
     pos = 4,
     cex = 0.4)

dev.off()
