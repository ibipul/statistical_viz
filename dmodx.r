#-----------------------------------------------------------
#   FILE: DMODX.R
#
#   Author(s): Bipul Islam 
#              Ritankar Mandal
#
#   Date of Test Initiation: 24 July 2012
#   Date of Test Completion: 24 July 2012
#------------------------------------------------------------

#   
#    DMODX Solution Scheme Validation Routine
#   ===================================================       
#   (Output is the matrix required to make a DmodX plot)
#   NOTE: Here the operations are performed on all-entities which can easily be tweaked for all-data


#   DF <-- Data.Frame obtained from the 20227x6 Data-Set available in Genespring Demo  
#   SDF <-- Mean-centred & Scaled DF using scale(data, center=bool, scale =bool) function
#   SDFT <-- Transpose of SDF
#   data <-- transformation of Data.frame object DF to numeric-matrix
#   dataT <-- transformation of Data.frame object SDFT to numeric-matirx
#   s <-- Object that holds the returns of SVD on data
#   D <-- Holds the diagonal entries of the SVD returned matrix 's$d'
#   SQD <-- Holds square root of the elements of D
#   G <-- Holds the score matrix of a PCA operation on data matrix achieved using SVD
#   H <-- Holds the Loading matrix of the PCA on the same matrix

#   RES <-- Residual matrix obtained by subtracting GH' from data matrix 
#   (according to our scheme the array dimensions has been resized)
#   Rsq <-- Holds the per-element squaring of the RES matrix
#   S <-- Hold the sum of squares of all elements of the RES
#   (s1,s2,s3,s4,s5,s6) hold the partial colum sums of teh 6 columns
#   NF <-- NOrmalization factor

#   rowsquared <--(dim(1x20227) holds the sum of squares of each row of RES
#   Plot of rowsquared array is the desired DmodX plot

# -------------------------------------------------------------------------------

#-- Saving the Fvals for 5 % confidence & 1% confidence intervals
five=6.0005931
one=9.22091172
#-- Obtain Data frame from file
DF <- read.table("data/filter_data.txt",sep=" ",header=F)
#-- Centre & scale data frame
SDF <-scale(DF, center = TRUE, scale = TRUE)
#-- Transpose of data frame is stored
SDFT <- t(SDF)

#-- numeric matrices obtained from data frame
data <-data.matrix(SDF, rownames.force = NA)
dataT <-data.matrix(SDFT,rownames.force = NA)

#-- SVD performed on data matrix to generate PCA scores & loadings
s <-svd(data)
D <-diag(s$d)
SQD<-sqrt(D)

#-- Score & loading generation
G<-s$u %*% SQD #Score matrix
H<-s$v %*% SQD #loading matrix

#-- Generation of residual matrix upon dimesion-loss on Score & loading to 2D
RES = data - G[,1:2] %*% t(H)[1:2,]

#-- Elementwise square of Residual matrix
Rsq =RES * RES

#-- Generation of Sum of squares of al elements of RES
s1= sum(Rsq[,1:1]) #partial sum 1
s2= sum(Rsq[,2:2]) #partial sum 2
s3= sum(Rsq[,3:3]) #partial sum 3
s4= sum(Rsq[,4:4]) #partial sum 4
s5= sum(Rsq[,5:5]) #partial sum 5
s6= sum(Rsq[,6:6]) #partial sum 6

#-- Complete Sum
S= s1+s2+s3+s4+s5+s6

#-- Normalization Factor
NF = sqrt(S/(20224*4))

#-- Generation of rowsquared matrix that stores the sum or squares of each row of RES
rowsquared <- array(0,20227)
row_sq_sum=0
for ( i in 1:20227) {
        rowsquared[i]<-sum(Rsq[i,])
        row_sq_sum = row_sq_sum + rowsquared[i]
}
rowsquared= sqrt(rowsquared/(4*NF))

# R Plot of rowsquared matrix & an overlay of abline at the critical point can point out 
# the required moderate outliers. Following commands will do.
#   > plot(rowsquared, col='red',pch=20,main="DmodX Chart showing both 1% & 5% critical limit", xlab= "Row Index", ylab="Dmodx value")
#   > abline(h=sqrt(6.0005931),col="blue")
#   > abline(h=sqrt(9.22091172),col="black")
#   > text(1000,2," 5% critical limit")
#   > text(1000,3.7," 1% critical limit")
#

