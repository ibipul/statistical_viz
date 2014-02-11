#-----------------------------------------------------------
#   FILE: BIPLOT.R
#
#   Author(s): Bipul Islam 
#              Ritankar Mandal
#
#   Date of Test Initiation: 24 July 2012
#   Date of Test Completion: 24 July 2012
#------------------------------------------------------------

#    BIPLOT Solution Scheme Routine & Validation
#   ===================================================       
#   (Output are the matrices viz. Score & Loadings which are passed to the biplot plotting module)
#   (The correctness is ensured by doing a R internal PCA & a subsequent biplot
#   NOTE: Here the operations are performed on all-entities which can easily be tweaked for all-data


#   DF <-- Data.Frame obtained from the 20227x6 Data-Set available in Genespring Demo  
#   SDF <-- Mean-centred & Scaled DF using scale(data, center=bool, scale =bool) function
#   data <-- transformation of Data.frame object DF to numeric-matrix

#   s <-- svd object returned by SVD on data
#   s$d <-- vector with singular values of data
#   s$u <-- Left singular vectors of data
#   s$v <-- Right singular vectors of data
#   D <-- stores eigen values OR square roots of singular values 

#   G <- stores the Score matrix
#   H <-- stores the Loading matrix
#-------------------------------------------------------------------------------------------


#-- Obtain Data frame from file
DF <- read.table("data/filter_data.txt",sep=" ",header=F)
#-- Centre & scale data frame
SDF <-scale(DF, center = TRUE, scale = TRUE)

#-- numeric matrices obtained from data frame
data <-data.matrix(SDF, rownames.force = NA)

#-- SVD operation on scaled data
s <-svd(data) # svd object

D <-diag(s$d) #Array containing the eigen values
SQD<-sqrt(D)  #Array containing the square root of Eigen values 

#--generation of score matrix
G<-s$u %*% SQD 
#--generation of loading matrix
H<-s$v %*% SQD

#Following command will generate a biplot of the given data
#>biplot(G,H,expand=1,main="Bi-Plot",xlab="PC1",ylab="PC2")

#The Correctness of the method can be validated by the following commands
#> pc <- prcomp(data)
#> biplot(pc,main="Biplot by PRCOMP")
# The relative orientation of loadings & the scatter of scores will validate the fact

