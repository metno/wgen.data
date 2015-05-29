rm(list=ls())

###########################################################################
###########################################################################
##                                                                       ##
##   LIBRARIES AND DATA                                                  ##
##                                                                       ##
###########################################################################
###########################################################################

#install_github("jeanmarielepioufle/graph")
#install_github("jeanmarielepioufle/basic")
library(graph)
library(basic)
library(kohonen)
library(wgen)   

data(eraInterimD0_totprec)
eraInterimD0_totprec=geoW

############################################################################
############################################################################
## CLASSIFICATION: 6*6 classes, toroidal                                  ##
##                                                                        ##
############################################################################
############################################################################

tmp<-classification(geoW=eraInterimD0_totprec,method="som",TEMPORAL=TRUE,nbclass=c(n1=6,n2=6),omit=NULL,FIGURE=FALSE)
classifTS.eraInterimD0_totprec<-list(value=tmp$classif,
                date=eraInterimD0_totprec$date)
#save(classifTS.eraInterimD0_totprec,file="P:/github/wgen/data/classifTS.eraInterimD0_totprec.rda")


