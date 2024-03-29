##########################################
# Coliphage analysis - 6 beaches
# v1 by Jade 7/13/15

# This file makes a table with regression output
# For a table with the combined and interaction
# results for body immersion

# Single indicators
##########################################


rm(list=ls())

setwd("~/Dropbox/Coliphage/")  

load("results/rawoutput/regress-10day-body.Rdata")
load("results/rawoutput/regress-10day-body-entero.Rdata")


# ------------------------------------------------
# combine output
# ------------------------------------------------

# n's --------------------------------------------
gici10.n.body.pool=c(all.n10.fmc1601,all.n10.fmc1602,
                     all.n10.fpc1601,all.n10.fpc1602)

gici10.n.body.high=c(all.n10.fmc1602.high,
                     all.n10.fpc1601.high,all.n10.fpc1602.high)
  
gici10.n.body.low=c(all.n10.fmc1602.low,
                  all.n10.fpc1601.low,all.n10.fpc1602.low)

# add comma
gici10.n.body.pool=format(gici10.n.body.pool,scientific=FALSE,big.mark=",")
gici10.n.body.high=format(gici10.n.body.high,scientific=FALSE,big.mark=",")
gici10.n.body.low=format(gici10.n.body.low,scientific=FALSE,big.mark=",")

# entero n's 

entero.n.body.pool=c(n10.entero35.fmc1601,n10.entero35.fmc1602,
                     n10.entero35.fpc1601,n10.entero35.fpc1602)

entero.n.body.high=c(n10.entero35.fmc1602.high,n10.entero35.fpc1601.high,
                     n10.entero35.fpc1602.high)

entero.n.body.low=c(n10.entero35.fmc1602.low,n10.entero35.fpc1601.low,
                     n10.entero35.fpc1602.low)

# add comma
entero.n.body.pool=format(entero.n.body.pool,scientific=FALSE,big.mark=",")
entero.n.body.high=format(entero.n.body.high,scientific=FALSE,big.mark=",")
entero.n.body.low=format(entero.n.body.low,scientific=FALSE,big.mark=",")



# estimates pooled across beach  --------------------------------------------
gici10.body.pool=list(overall.fit10.fmc1601, overall.fit10.fmc1602,
                      overall.fit10.fpc1601, overall.fit10.fpc1602)

gici10.body.pool.high=list(overall.fit10.fmc1602.high,
                      overall.fit10.fpc1601.high, overall.fit10.fpc1602.high)

gici10.body.pool.low=list(overall.fit10.fmc1602.low,
                      overall.fit10.fpc1601.low, overall.fit10.fpc1602.low)

gici10.entero.pool=list(overall.fit10.entero.fmc1601,overall.fit10.entero.fmc1602,
                        overall.fit10.entero.fpc1601,overall.fit10.entero.fpc1602)
gici10.entero.high=list(overall.fit10.entero.high.fmc1602,overall.fit10.entero.high.fpc1601,
                        overall.fit10.entero.high.fpc1602)
gici10.entero.low=list(overall.fit10.entero.low.fmc1602,overall.fit10.entero.low.fpc1601,
                       overall.fit10.entero.low.fpc1602)


# ------------------------------------------------
# function to make table row with exponentiated point estimate
# and 95% ci in parentheses
# ------------------------------------------------
mkrow.pool=function(out){
  pt.est=out[2,1]
  lb=pt.est-qnorm(.975)*out[2,2]
  ub=pt.est+qnorm(.975)*out[2,2]
  paste(sprintf("%0.2f",exp(pt.est))," (",
        sprintf("%0.2f",exp(lb)),",",
        sprintf("%0.2f",exp(ub)), ")",sep="")
}

# ------------------------------------------------
# convert results into table format
# pooled results
# ------------------------------------------------
# results pooled across beach
gici10.tab.body.pool=data.frame(combined=unlist(lapply(gici10.body.pool,mkrow.pool)))
gici10.tab.body.pool.high=data.frame(combined=unlist(lapply(gici10.body.pool.high,mkrow.pool)))
gici10.tab.body.pool.low=data.frame(combined=unlist(lapply(gici10.body.pool.low,mkrow.pool)))

gici10.tab.body.pool.high$combined=as.character(gici10.tab.body.pool.high$combined)
gici10.tab.body.pool.high=rbind("",gici10.tab.body.pool.high)
gici10.tab.body.pool.low$combined=as.character(gici10.tab.body.pool.low$combined)
gici10.tab.body.pool.low=rbind("",gici10.tab.body.pool.low)

gici10.tab=data.frame(cbind(gici10.n.body.pool,gici10.tab.body.pool,
                      c("",gici10.n.body.low),gici10.tab.body.pool.low,
                      c("",gici10.n.body.high),gici10.tab.body.pool.high))
colnames(gici10.tab)=NULL
gici10.tab[,1]=as.character(gici10.tab[,1])
gici10.tab[,2]=as.character(gici10.tab[,2])
gici10.tab[,3]=as.character(gici10.tab[,3])
gici10.tab[,4]=as.character(gici10.tab[,4])
gici10.tab[,5]=as.character(gici10.tab[,5])
gici10.tab[,6]=as.character(gici10.tab[,6])

entero.tab.pool=data.frame(combined=unlist(lapply(gici10.entero.pool,mkrow.pool)))
entero.tab.high=data.frame(combined=unlist(lapply(gici10.entero.high,mkrow.pool)))
entero.tab.high$combined=as.character(entero.tab.high$combined)
entero.tab.high=rbind("",entero.tab.high)
entero.tab.low=data.frame(combined=unlist(lapply(gici10.entero.low,mkrow.pool)))
entero.tab.low$combined=as.character(entero.tab.low$combined)
entero.tab.low=rbind("",entero.tab.low)

entero.tab=data.frame(cbind(entero.n.body.pool,entero.tab.pool,
                            c("",entero.n.body.low),entero.tab.low,
                            c("",entero.n.body.high),entero.tab.high))
colnames(entero.tab)=NULL
entero.tab[,1]=as.character(entero.tab[,1])
entero.tab[,2]=as.character(entero.tab[,2])
entero.tab[,3]=as.character(entero.tab[,3])
entero.tab[,4]=as.character(entero.tab[,4])
entero.tab[,5]=as.character(entero.tab[,5])
entero.tab[,6]=as.character(entero.tab[,6])

colnames(gici10.tab)=c("npool","pool","nlow","low","nhigh","high")
colnames(entero.tab)=c("npool","pool","nlow","low","nhigh","high")

gici10.tab.out=rbind(gici10.tab[1,],entero.tab[1,],
                     gici10.tab[2,],entero.tab[2,],
                     gici10.tab[3,],entero.tab[3,],
                     gici10.tab[4,],entero.tab[4,])

lab=c("Coliphage","Enterococcus ","F- Coliphage (EPA 1602)",
      "Enterococcus ","F+ Coliphage (EPA 1601)","Enterococcus ",
      "F+ Coliphage (EPA 1602)","Enterococcus ")
gici10.tab.out=cbind(lab,gici10.tab.out)
save(gici10.tab.out,file="~/Dropbox/Coliphage/Results/Tables/CIR-pool-10.RData")






