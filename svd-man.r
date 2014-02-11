#-----------------------------------------------------------
#   FILE: HOTEL.R
#
#   Author(s): Bipul Islam 
#              Ritankar Mandal
#
#   Date of Test Initiation: 25 July 2012
#   Date of Test Completion: 25 July 2012
#
#   Description
#   This code implements PCA with Singular value decomposition
#   Scores and loadings of the Data are obtained after the svd
#
#------------------------------------------------------------

data <- read.table("data/filter_data.txt",sep="|",header=F)
sc.data <-scale(my.data, center = TRUE, scale = TRUE)
s <-svd(sc.data)
s
D <-diag(s$d)
SQD<-sqrt(D)

G<-s$u %*% SQD
H<-s$v %*% SQD

#--- biplot with the scores and loadings through-------------
biplot(G,H,expand=1)

