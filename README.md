Authors:

 - Bipul Islam
 - Ritankar Mandal

----------------
## Statistical Visualization Tools

The R scripts here implement statistical visualization of Multivariate data.
 * Singular Value Decomposition,
 * Principle Component Analysis, 
 * Score plot, Loading plot, Biplot,
 * Hotelling plot and Tsquare plots 

have been oplemented here. The included scripts need to be parsed with R, then either the following commands could be used to visualize the data with plot commands of R, or, any other plotting devices of user's choice.

*Note: These codes are written as a part of verification of algorithms which had be written in C++ during an internship @**strand Life Sciencs** *

####File: SVD-MAN.R

--------------

Creates the PCA of the mvariate data with **S**ingular **V**alue **D**ecomposition method.

####File: BIPLOT.R

-------------------------

Following command will generate a biplot of the given data
```
biplot(G,H,expand=1,main="Bi-Plot",xlab="PC1",ylab="PC2")
```
The Correctness of the method can be validated by the following commands that utilizes PCA routine inbuilt in R:
```
pc <- prcmop(data)
biplot(pc,main="Biplot by PRCOMP")
```
The relative orientation of loadings & the scatter of scores will validate the correctness of SVD method.


####File: DMODX.R

-------------------------

R Plot of rowsquared matrix & an overlay of abline at the critical point can point out the required moderate outliers. Following commands will do.
```
plot(rowsquared, col='red',pch=20,main="DmodX Chart showing both 1% & 5% critical limit", xlab= "Row Index", ylab="Dmodx value")

abline(h=sqrt(6.0005931),col="blue")
abline(h=sqrt(9.22091172),col="black")
text(1000,2," 5% critical limit")
text(1000,3.7," 1% critical limit")
```

####File: TSQUAREPLOT.R

-------------------------

Following commands can be used to generate the COnfidence ellipseplot,
```
plot(score,col='red',pch=20,main="Confidence ellipse for 1% and 5%",xlab="PC1 component",ylab="PC2 component")

points(x1,y1,col='black',type='l')
points(x2,y2,col='blue',type='l')
text(4,2.5,"1% limit")
text(-2.5,0,"5% limit")
```
Following commands can be used to generate the TSquare plot
```
plot(TSQ,col='red',pch=20,main="T square plot with confidence intervals 1% & 5%",xlab= "Dimension Index",ylab="T square value")

abline(h=five,col='blue')
abline(h=one,col='black')
text(1000,1,"5% confidence limit")
text(1000,20,"1% confidence limit")
```
