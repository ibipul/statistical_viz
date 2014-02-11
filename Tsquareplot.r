#-----------------------------------------------------------
#   FILE: TSQUAREPLOT.R
#
#   Author(s): Bipul Islam 
#              Ritankar Mandal
#
#   Date of Test Initiation: 24 July 2012
#   Date of Test Completion: 24 July 2012
#
#   Description
#   Generate Tsquare and Hotelling Plot
#

#------------------------------------------------------------

#-- Calculating & Saving the Fvals for 5 % confidence & 1% confidence intervals
# (Note: In actual software F distribution will be otained from txt file corresponding
#  Fvals will be calculated next.)
five=6.0005931
one=9.22091172
#-- Obtain Data frame from file
DF <- read.table("data/filter_data.txt",sep=" ",header=F)
#-- Centre & scale data frame
SDF <-scale(DF, center = TRUE, scale = TRUE)
#-- Transpose of data frame is stored
SDFT <- t(SDF)
#-- Dimensions of DF are calculated
D<-dim(DF)

#-- numeric matrices obtained from data frame
data <-data.matrix(SDF, rownames.force = NA)
dataT <-data.matrix(SDFT,rownames.force = NA)

#-- Generation of Covariance matrix by (1/n-1)*X'X 
Z<-dataT%*%data
Z<-Z/(D[1] - 1)

#-- Eigen values of Z calculated
EV <-eigen(Z)

#-- 2D Score obtained by dimension resizing of the Eigen vector matrix
score <- data %*% EV$vectors[,1:2]
#-- Score transpose stored
scoreT <- t(score)

############################################################################################
# Creating the row vectors whose sum of squares will give the TSQ array for TSquare plot
############################################################################################

ss =sqrt(EV$values) # Square roots of eigen values

#-- Generating the two rows seperately & ignoring dimensions >=3
Zt1 <- scoreT[1,]/ss[1] # Row 1 generated
Zt2 <- scoreT[2,]/ss[2] # Row 2 generated

#-- Elementwise Squares of the two rows
Z1 <- Zt1 * Zt1  # Row 1 generated
Z2 <- Zt2 * Zt2  # Row 2 generated

#-- Final TSQ matrix obtained
TSQ <- Z1 +Z2 

########################################################
# Generating the Confidence ellipse for Hotelling plot
########################################################

#-- vertex of ellipse
x0 <- 0 
y0 <- 0

#-- theta range for parametric plot of ellipse
theta <- seq(0, 2 * 22 / 7 , 0.01)

#--Major Axis for 1% confidence interval
a1 <- ss[1]*sqrt(one)
b1 <- ss[2]*sqrt(one)
#-- Generation of ellipse data for 1% confidence
x1 <- x0 + a1 * cos(theta)
y1 <- y0 + b1 * sin(theta)

#--Major Axis for 5% confidence interval
a2 <- ss[1]*sqrt(five)
b2 <- ss[2]*sqrt(five)
#-- Generation of ellipse data for 5% confidence
x2 <- x0 + a2 * cos(theta)
y2 <- y0 + b2 * sin(theta)


#Following commands can be used to generate the COnfidence ellipseplot
#>plot(score,col='red',pch=20,main="Confidence ellipse for 1% and 5%",xlab="PC1 component",ylab="PC2 component")
#>points(x1,y1,col='black',type='l')
#>points(x2,y2,col='blue',type='l')
#>text(4,2.5,"1% limit")
#>text(-2.5,0,"5% limit")

#Following commands can be used to generate the TSquare plot
#> plot(TSQ,col='red',pch=20,main="T square plot with confidence intervals 1% & 5%",xlab= "Dimension Index",ylab="T square value")
#> abline(h=five,col='blue')
#> abline(h=one,col='black')
#> text(1000,1,"5% confidence limit")
#> text(1000,20,"1% confidence limit")


