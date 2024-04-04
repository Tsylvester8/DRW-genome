# Terrence Sylvester
# pradakshanas@gmail.com
# 3/22/2023

# load coverage comparisons
load("../scripts/RData.assess.coverage.RData")

# get potential sex chromosome contigs
pot_conts <- comps[comps$ratio < 0.6,]
pot_conts <- pot_conts[!(pot_conts$contig_1_cov > 22 | pot_conts$contig_2_cov > 22),]
pot_conts <- pot_conts[!(pot_conts$contig_1_cov < 5 | pot_conts$contig_2_cov < 5),]
conts <- unique(pot_conts$contig_2[pot_conts$contig_2_cov < 11])
ctg <- pot_conts[pot_conts$contig_2_cov < 11,]
ctg <- ctg[!(duplicated(ctg$contig_2_cov)),]

# get busco hits
TcasHits <- read.delim("../data/sex.chromosome.id/BUSCO-hits-Tcas-Dab.txt", header = F)
PcerHits <- read.delim("../data/sex.chromosome.id/BUSCO-hits-Pcer-Dab.txt", header = F)
# get coverage of busco hits
TcasHitsCov <- cov_dat$meandepth[cov_dat$X.rname %in% TcasHits$V1]
PcerHitsCov <- cov_dat$meandepth[cov_dat$X.rname %in% PcerHits$V1]


pdf(file = "Figure.coverage.overlap.pdf",width = 6,height = 6)
# plot
plot(x = NULL,
     y = NULL,
     xlim = c(0,2),
     ylim = c(0,25),
     ylab = "Mean depth per contig",
     xaxt = "n",
     xlab = "")

axis(side = 1,at = c(0,1,2),labels = c("Coverage \ncomparison",
                                       "Single copy \northolog overlap \nTribolium",
                                       "Single copy \northolog overlap \nPolydrusus"),hadj = 0.5,padj = 0.5)

jFactor <- 1


points(x = jitter(rep(0,nrow(ctg)),factor = jFactor),
       y = ctg$contig_2_cov,
       pch = 16,
       col = viridis::viridis(3,alpha = 0.7,end = 0.5)[1])

points(x = jitter(rep(1,length(TcasHitsCov)), factor = jFactor),
       y = TcasHitsCov,
       pch = 16,
       col = viridis::viridis(3,alpha = 0.7,end = 0.5)[1])

points(x = jitter(rep(2,length(PcerHitsCov)),factor = jFactor),
       y = PcerHitsCov,
       pch = 16,
       col = viridis::viridis(3,alpha = 0.7,end = 0.5)[1])


legend("bottomright",
       legend = c("Unique","Overlap"),
       col = viridis::viridis(3,alpha = 0.7,end = 0.5)[1:2],
       pch = 16,inset = 0.01,bty = "n")

dev.off()

