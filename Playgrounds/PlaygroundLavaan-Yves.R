rm(list=ls(all=TRUE))
#install.packages("NlsyLinks", repos="http://R-Forge.R-project.org")
library(NlsyLinks)
library(lavaan)

ds <- Links79PairExpanded
ds$Group <- NA
ds$Group[ds$R==1] <- 1
ds$Group[ds$R==.5] <- 2
ds$Group[ds$R==.375] <- 3
ds$Group[ds$R==.25] <- 4
ds$Group <- factor(ds$Group)
ds$M1 <- ds$MathStandardized_1 #Stands for Manifest1
ds$M2 <- ds$MathStandardized_2 #Stands for Manifest2
# ds$M1 <- ds$WeightStandardizedForAge19To25_1 #Stands for Manifest1
# ds$M2 <- ds$WeightStandardizedForAge19To25_2 #Stands for Manifest2

ds <- subset(ds,  !is.na(Group) & !is.na(M1) & !is.na(M2)) #It's necessary to drop the missing Groups, but not M1 & M2

model <- '
  # latents
  A1 =~ c(a,a,a,a)*M1
  A2 =~ c(a,a,a,a)*M2
  C1 =~ c(c,c,c,c)*M1
  C2 =~ c(c,c,c,c)*M2
  E1 =~ c(e,e,e,e)*M1
  E2 =~ c(e,e,e,e)*M2

  # means
  M1 + M2 ~ c(int,int,int,int)*1

  # variances
  A1 ~~ 1*A1
  C1 ~~ 1*C1
  E1 ~~ 1*E1

  A2 ~~ 1*A2
  C2 ~~ 1*C2
  E2 ~~ 1*E2

  # fixed covariances (all groups)
  C1 ~~ 1*C2

  # fixed covariances per group -- in the order as they appear in the data!!!
  A1 ~~ c(.5, .25, 1, .375)*A2
  #A1 ~~ c( 1, .5, .375, .25)*A2

  # defined variables
  a2 := a*a
  c2 := c*c
  e2 := e*e

'

# FIML
#fit <- lavaan(model, data=ds, group="Group", missing="ml")

# listwise deletion
fit <- lavaan(model, data=ds, group="Group", missing="listwise", information="observed")
summary(fit)

#Will Beasley added this:
#Extract the UNSCALED ACE components.
est <- parameterEstimates(fit)
a2 <- est[est$label=="a2", "est"]
c2 <- est[est$label=="c2", "est"]
e2 <- est[est$label=="e2", "est"]
print(cbind(a2, c2, e2)[1,] / (a2 + c2 + e2)) #Print the unity-SCALED ace components.
