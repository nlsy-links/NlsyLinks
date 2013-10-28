rm(list=ls(all=TRUE))
library(NlsyLinks) #Load the package into the current R session.

#Start with the built-in data.frame in NlsyLinks, select only the Gen2 Siblings (ie, NLSY79-C subjects)
dsLinks <- Links79PairExpanded 
dsLinks <- dsLinks[dsLinks$RelationshipPath=='Gen2Siblings', ]

#Define the names of the manifest/outcome/phenotype variable
oName_1 <- "MathStandardized_1" #Stands for Outcome1 -for the first subject in the pair
oName_2 <- "MathStandardized_2" #Stands for Outcome2 -for the second subject in the pair


#Compare against the whoe sample together
dsGroupSummary <- RGroupSummary(dsLinks, oName_1, oName_2)
dsClean <- CleanSemAceDataset(dsDirty=dsLinks, dsGroupSummary, oName_1, oName_2)

(ace <- AceLavaanGroup(dsClean))
AceLavaanGroup(dsClean, printOutput=TRUE)

#Display the all estimates of lavaan.  The first way is formatted output, 
#   which is good for humans to read.  The second way is a data.frame, 
#   which is useful for using the output as input to a downstream function. 
lavaan::summary(ace@Details$lavaan) 
lavaan::parameterestimates(ace@Details$lavaan)

#Example the estimates and error

