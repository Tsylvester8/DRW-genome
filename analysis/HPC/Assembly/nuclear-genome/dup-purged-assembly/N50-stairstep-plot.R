# read fasta index
faidx <- read.delim("diaprepes.purged.fa.fai", header = F)
# sort by read size
faidx <- faidx[,c(1,2)][order(faidx$V2,decreasing = T),]
# lable columns
colnames(faidx) <- c("contig","length")
faidx$cumsum <- cumsum((faidx$length / sum(faidx$length)) * 100)

faidx$length <- faidx$length / 1000000

plot(x = NA,
     y = NA,
     xlim = c(0,100),
     ylim = c(0,62),
     xlab = "Cumilative percentage",
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

# plot N50
abline(v = 50, col = "red", lty = 2)

text(x = 50, y = 62, "N50 = 7.8Mb", pos = 4)
