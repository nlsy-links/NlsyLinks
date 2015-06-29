rm(list=ls(all=TRUE))
library(NlsyLinks)
library(lavaan)

ds <- Links79PairExpanded
#ds$M1 <- ds$MathStandardized_1 #Stands for Manifest1
#ds$M2 <- ds$MathStandardized_2 #Stands for Manifest2
ds$M1 <- ds$WeightStandardizedForAge19To25_1 #Stands for Manifest1
ds$M2 <- ds$WeightStandardizedForAge19To25_2 #Stands for Manifest2

DeFriesFulkerMethod3(ds$M2, ds$M1, ds$R)


ds <- subset(ds,  !is.na(Group) & !is.na(M1) & !is.na(M2)) #It's necessary to drop the missing Groups, but not M1 & M2
