rm(list=ls(all=TRUE))
###
### Ace
###
library(NlsyLinks) #Load the package into the current R session.
dsOutcomes <- ExtraOutcomes79
dsOutcomes$SubjectTag <- CreateSubjectTag(subjectID=dsOutcomes$SubjectID,
  generation=dsOutcomes$Generation)
dsLinks <- Links79Pair
dsLinks <- dsLinks[dsLinks$RelationshipPath=='Gen2Siblings', ] #Use only the Gen2 Siblings (ie, NLSY79-C subjects)
dsDF <- CreatePairLinksDoubleEntered(outcomeDataset=dsOutcomes, linksPairDataset=dsLinks, 
  outcomeNames=c("MathStandardized", "HeightZGenderAge", "WeightZGenderAge"))

estimatedAdultHeight <- DeFriesFulkerMethod3(
  dataSet=dsDF,    
  oName_1="HeightZGenderAge_1", 
  oName_2="HeightZGenderAge_2")  
estimatedAdultHeight #ASquared and CSquared should be 0.606 and 0.105 for this rough analysis.

estimatedMath <- DeFriesFulkerMethod3(
  dataSet=dsDF,    
  oName_1="MathStandardized_1", 
  oName_2="MathStandardized_2")
estimatedMath #ASquared and CSquared should be 0.878 and 0.048.

class(GetDetails(estimatedMath))
summary(GetDetails(estimatedMath))

###
### AceLavaanGroup
###
library(NlsyLinks) #Load the package into the current R session.
dsLinks <- Links79PairExpanded #Start with the built-in data.frame in NlsyLinks
dsLinks <- dsLinks[dsLinks$RelationshipPath=='Gen2Siblings', ] #Use only the Gen2 Siblings (ie, NLSY79-C subjects)

oName_1 <- "MathStandardized_1" #Stands for Outcome1
oName_2 <- "MathStandardized_2" #Stands for Outcome2

dsGroupSummary <- RGroupSummary(dsLinks, oName_1, oName_2)
dsClean <- CleanSemAceDataset(dsDirty=dsLinks, dsGroupSummary, oName_1, oName_2)

ace <- AceLavaanGroup(dsClean)
ace

#Should produce:
# [1] "Results of ACE estimation: [show]"
#     ASquared     CSquared     ESquared    CaseCount 
#    0.6681874    0.1181227    0.2136900 8390.0000000 

library(lavaan) #Load the package to access methods of the lavaan class.
GetDetails(ace)

#Exmaine fit stats like Chi-Squared, RMSEA, CFI, etc.
fitMeasures(GetDetails(ace)) #The function 'fitMeasures' is defined in the lavaan package.

#Examine low-level details like each group's individual parameter estimates and standard errors.
summary(GetDetails(ace))

#Extract low-level details. This may be useful when programming simulations.
inspect(GetDetails(ace), what="converged") #The lavaan package defines 'inspect'.
inspect(GetDetails(ace), what="coef")

###
### CleanSemAceDataset
###
library(NlsyLinks) #Load the package into the current R session.
dsLinks <- Links79PairExpanded #Start with the built-in data.frame in NlsyLinks
dsLinks <- dsLinks[dsLinks$RelationshipPath=='Gen2Siblings', ] #Use only NLSY79-C siblings

oName_1 <- "MathStandardized_1" #Stands for Outcome1
oName_2 <- "MathStandardized_2" #Stands for Outcome2
dsGroupSummary <- RGroupSummary(dsLinks, oName_1, oName_2)

dsClean <- CleanSemAceDataset( dsDirty=dsLinks, dsGroupSummary, oName_1, oName_2, rName="R" )
summary(dsClean)

dsClean$AbsDifference <- abs(dsClean$O1 - dsClean$O2)
plot(jitter(dsClean$R), dsClean$AbsDifference, col="gray70")

###
### CreateAceEstimate
###
library(NlsyLinks) #Load the package into the current R session.

showClass("AceEstimate")
est <- CreateAceEstimate(.5, .2, .3, 40)
est 
print(est)

###
### CreateSubjectTag
###
library(NlsyLinks) #Load the package into the current R session.
data(ExtraOutcomes79)  #Load the dataset from the NlsyLinks package.

#Typically these two vectors will come from a data frame.
subjectIDs <- c(71:82, 10001:10012)
generation <- c(rep(1, 12), rep(2, 12))

CreateSubjectTag(subjectIDs, generation)
#Returns 7100, ..., 8200, 10001, ..., 10012

#Use the ExtraOutcomes79 dataset, with numeric variables 'SubjectID' and 'Generation'.
ExtraOutcomes79$SubjectTag <- CreateSubjectTag(
  subjectID=ExtraOutcomes79$SubjectID, 
  generation=ExtraOutcomes79$Generation
)
###
### Column Utilities
###
filePathGen2 <- file.path(path.package("NlsyLinks"), "extdata", "Gen2Birth.csv") #"F:/Projects/RDev/NlsyLinksStaging/Datasets/Gen2Birth.csv"
ds <- read.csv(filePathGen2)

originalColuoNames <- c("C0000100", "C0000200", "C0005300", "C0005400", 
  "C0005700", "C0328000", "C0328600", "C0328800")

newColumnNames <- c("SubjectID", "MotherID", "Race", "Gender", "Yob", 
  "GestationWeeks", "BirthWeightInOunces", "BirthLengthInInches")

for( columnIndex in seq_along(originalColuoNames) ) {
  ds <- RenameNlsyColumn(ds, originalColuoNames[columnIndex], newColumnNames[columnIndex])
}


###
### ExtraOutcomes79
###
library(NlsyLinks) #Load the package into the current R session.
data(ExtraOutcomes79)  #Load the dataset from the NlsyLinks package.
gen2Outcomes <- subset(ExtraOutcomes79, Generation==2) #Create a dataset of only Gen2 subjects.

plot(ExtraOutcomes79)
summary(ExtraOutcomes79)

oldPar <- par(mfrow=c(3,2))
hist(ExtraOutcomes79$Generation)
hist(ExtraOutcomes79$MathStandardized)
hist(ExtraOutcomes79$HeightZGenderAge)
hist(ExtraOutcomes79$WeightZGenderAge)
hist(ExtraOutcomes79$Afi)
hist(ExtraOutcomes79$Afm)
par(oldPar)

###
### LinksPair
###
library(NlsyLinks) #Load the package into the current R session.
data(Links79Pair)  #Load the dataset from the NlsyLinks package.
summary(Links79Pair)  #Summarize the five variables.
hist(Links79Pair$R)  #Display a histogram of the Relatedness values.
table(Links79Pair$R)  #Create a table of the Relatedness values for the whole sample.

#Create a dataset of only Gen2 sibs, and display the distribution of R.
gen2Siblings <- subset(Links79Pair, RelationshipPath=='Gen2Siblings')
table(gen2Siblings$R)  #Create a table of the Relatedness values for the Gen2 sibs.


###
### LinksPairExpanded
###
library(NlsyLinks) #Load the package into the current R session.
data(Links79PairExpanded)  #Load the dataset from the NlsyLinks package.
olderR <- Links79PairExpanded$RExplicitOlderSibVersion  #Declare a variable with a concise name.
youngerR <- Links79PairExpanded$RExplicitYoungerSibVersion  #Declare a variable with a concise name.

plot(jitter(olderR), jitter(youngerR))  #Scatterplot the relationship between the siblings' responses.
table(youngerR, olderR)  #Create a table of the relationship between the siblings' responses.
ftable(youngerR, olderR, dnn=c("Younger's Version", "Older's Version")) #Create a formatted table.

#write.csv(Links79PairExpanded, file='F:/Projects/RDev/NlsyLinksStaging/Links79PairExpanded.csv', row.names=FALSE)

###
### RGroupSummary
###
library(NlsyLinks) #Load the package into the current R session.
dsLinks <- Links79PairExpanded  #Load the dataset from the NlsyLinks package.
dsLinks <- dsLinks[dsLinks$RelationshipPath=='Gen2Siblings', ]
oName_1 <- "MathStandardized_1" #Stands for Outcome1
oName_2 <- "MathStandardized_2" #Stands for Outcome2
dsGroupSummary <- RGroupSummary(dsLinks, oName_1, oName_2)
dsGroupSummary

#Should return: 
# R Included PairCount O1Variance O2Variance O1O2Covariance Correlation Determinant PosDefinite
# 1 0.250     TRUE      2719   169.1291   207.0233       40.66048   0.2172970    33360.38        TRUE
# 2 0.375     TRUE       141   167.9943   181.8788       40.67609   0.2327024    28900.07        TRUE
# 3 0.500     TRUE      5508   230.9663   233.3492      107.59822   0.4634764    42318.42        TRUE
# 4 0.750    FALSE         2   220.5000    18.0000       63.00000   1.0000000        0.00       FALSE
# 5 1.000     TRUE        22   319.1948   343.1169      277.58874   0.8387893    32465.62        TRUE

#To get summary stats for the whole sample, create one large inclusive group.
dsLinks$Dummy <- 1
(dsSampleSummary <- RGroupSummary(dsLinks, oName_1, oName_2, rName="Dummy"))

#Should return:
# Dummy Included PairCount M1Variance M2Variance M1M2Covariance Correlation Determinant PosDefinite
#1    1     TRUE      8392    216.466   229.2988       90.90266   0.4080195     41372.1        TRUE
###
### ReadCsvNlsy79
###
## Not run:
#filePathGen2 <- "F:/Projects/RDev/NlsyLinksStaging/Datasets/Gen2Birth.csv"
#ds <- ReadCsvNlsy79Gen2(filePath=filePathGen2)
## End(Not run)

###
### CreatePairLinks
### ValidatePairLinks
###
dsSingleLinks <- data.frame(
  ExtendedID=c(1, 1, 1, 2), 
  Subject1Tag=c(101, 101, 102, 201), 
  Subject2Tag=c(102, 103, 103, 202), 
  R=c(.5, .25, .25, .5), 
  RelationshipPath=rep("Gen2Siblings", 4)
)
dsSingleOutcomes <- data.frame(
  SubjectTag=c(101, 102, 103, 201, 202), 
  DV1=c(11, 12, 13, 41, 42), 
  DV2=c(21, 22, 23, 51, 52))
dsDouble <- CreatePairLinksDoubleEntered(
  outcomeDataset=dsSingleOutcomes, 
  linksPairDataset=dsSingleLinks, 
  outcomeNames=c("DV1", "DV2"), 
  validateOutcomeDataset=TRUE)
dsDouble #Show the 8 rows in the double-entered pair links
summary(dsDouble) #Summarize the variables

ValidatePairLinksAreSymmetric(dsDouble) #Should return TRUE.

###
### SubjectDetails
###
library(NlsyLinks) #Load the package into the current R session.
data(SubjectDetails79)  #Load the dataset from the NlsyLinks package.

summary(SubjectDetails79)

oldPar <- par(mfrow=c(3,2), mar=c(2,2,1,.5), tcl=0, mgp=c(1,0,0))
hist(SubjectDetails79$SiblingCountInNls, main="",
     breaks=seq(from=0, to=max(SubjectDetails79$SiblingCountInNls, na.rm=TRUE), by=1)
)
hist(SubjectDetails79$BirthOrderInNls, main="",
     breaks=seq(from=0, to=max(SubjectDetails79$BirthOrderInNls, na.rm=TRUE), by=1)
)
hist(SubjectDetails79$SimilarAgeCount, main="",
     breaks=seq(from=0, to=max(SubjectDetails79$SimilarAgeCount, na.rm=TRUE), by=1)
)
hist(SubjectDetails79$KidCountBio, main="",
     breaks=seq(from=0, to=max(SubjectDetails79$KidCountBio, na.rm=TRUE), by=1)
)
hist(SubjectDetails79$KidCountInNls, main="",
     breaks=seq(from=0, to=max(SubjectDetails79$KidCountInNls, na.rm=TRUE), by=1)
)
# hist(SubjectDetails79$Mob, main="", 
#      breaks=seq.Date(
#        from=min(SubjectDetails79$Mob, na.rm=TRUE), 
#        to=max(SubjectDetails79$Mob, na.rm=TRUE), 
#        by="year")
# )
# hist(SubjectDetails79$Mob, main="", 
#      breaks=seq.Date(
#        from=min(SubjectDetails79$Mob, na.rm=TRUE), 
#        to=max(SubjectDetails79$Mob, na.rm=TRUE), 
#        by=difftime(as.Date("2012-1-1"), as.Date("2010-1-1")))
# )
range(SubjectDetails79$Mob, na.rm=T)
par(oldPar)


###
### ValidateOutcomeDataset
###
library(NlsyLinks) #Load the package into the current R session.
ds <- ExtraOutcomes79
outcomeNames <- c("MathStandardized", "WeightZGenderAge")
ValidateOutcomeDataset(dsOutcome=ds, outcomeNames=outcomeNames) #Returns TRUE.

outcomeNamesBad <- c("MathMisspelled", "WeightZGenderAge")
#ValidateOutcomeDataset(dsOutcome=ds, outcomeNames=outcomeNamesBad) #Throws error.
