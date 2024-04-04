# Terrence Sylvester
# pradakshanas@gmail.com
# April 18th 2023

# get GH genes numbers from annotation
dat <-  matrix(data = c("GH-1",62,
                        "GH-2",10,
                        "GH-9",1,
                        "GH-15",2,
                        "GH-16",9,
                        "GH-18",22,
                        "GH-20",11,
                        "GH-28",18,
                        "GH-30",9,
                        "GH-31",9,
                        "GH-32",2,
                        "GH-35",16,
                        "GH-38",9,
                        "GH-45",13,
                        "GH-47",6,
                        "GH-48",11,
                        "GH-63",2,
                        "GH-79",3,
                        "GH-85",1),
               ncol = 2,
               nrow = 19, byrow = T)
dat <- as.data.frame(dat)
colnames(dat) <- c("enzyme","number")
dat$number <- as.numeric(dat$number)
# make a bar plot
barplot(height = dat$number,
        names.arg = dat$enzyme,
        xlab = "Glycosyl hydrolases (GH) family", 
        las = 2, 
        col='steelblue',
        cex.axis = 0.8,cex.names = 0.7)

