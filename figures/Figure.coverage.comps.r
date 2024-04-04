# Terrence Sylvester
# pradakshanas@gmail.com
# 2/28/2023

# load coverage comparisons
load("../scripts/RData.assess.coverage.RData")

# remove NAs
comps <- comps[!(is.na(comps$comparison)),]

pdf(file = "Figure.coverage.comps.hist.pdf",width = 8,height = 4,)
# make histogram
par(mfcol = c(1,2))
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
dev.off()

pdf(file = "Figure.coverage.comps.dens.pdf",width = 8,height = 4,)
# plot densities
par(mfcol = c(1,2))
plot(density(cov_dat$meandepth[cov_dat$meandepth < 30]),
     zero.line = F,
     xlab = "Read depth",
     main = "",
     xlim = c(0,30))
polygon(density(cov_dat$meandepth[cov_dat$meandepth < 30]),
        col = rgb(0,0,1,0.3),
        border = rgb(0,0,1,1),)
mtext(text = "A",side = 3,adj = 0)
plot(density(comps$ratio),
     zero.line = F,
     xlab = "Read depth ratio",
     main = "")
polygon(density(comps$ratio),
        col = rgb(0,0,1,0.3),
        border = rgb(0,0,1,1),)
mtext(text = "B",side = 3,adj = 0)
dev.off()
