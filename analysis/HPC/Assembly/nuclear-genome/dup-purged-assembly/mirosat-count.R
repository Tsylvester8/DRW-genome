# load library
library(micRocounter)

# load saved environment
load("mirosat-count.RData")

# Find all repetitive sequences
twomer <- ReadFasta2("diaprepes.purged.fa",2,minrep = 6,tolfac = 0)
threemer <- ReadFasta2("diaprepes.purged.fa",3,minrep = 4,tolfac = 0)
fourmer <- ReadFasta2("diaprepes.purged.fa",4,minrep = 3,tolfac = 0)
fivemer <- ReadFasta2("diaprepes.purged.fa",5,minrep = 3,tolfac = 0)
sixmer <- ReadFasta2("diaprepes.purged.fa",6,minrep = 3,tolfac = 0)

# get total amount of bases
totRepcont <-  sum(twomer$`Total Microsat Content`, 
                   threemer$`Total Microsat Content`,
                   fourmer$`Total Microsat Content`,
                   fivemer$`Total Microsat Content`,
                   sixmer$`Total Microsat Content`)

# calculate the microsatellite percentage
Dab_genome_size <- 1527008157
(totRepcont/Dab_genome_size)*100

# save environment
save.image("mirosat-count.RData")