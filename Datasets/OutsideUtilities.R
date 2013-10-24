#This isn't part of the build process.  They should be executed infrequently -not for every build.
require(RODBC)
rm(list=ls(all=TRUE))

directory <- "F:/Projects/RDev/NlsyLinksStaging/"
directoryDatasets <- paste(directory, "Datasets/", sep="")

Links79PairWithoutOutcomes <- read.csv( paste(directoryDatasets, "Links2011V50.csv", sep=""))
#CreatePairLinks

require(NlsyLinks)
#data(Links79PairExpanded)
data(ExtraOutcomes79)
dsOutcomes <- ExtraOutcomes79
dsOutcomes$SubjectTag <- CreateSubjectTag(subjectID=dsOutcomes$SubjectID, generation=dsOutcomes$Generation)
colnames(Links79PairWithoutOutcomes)
firstTwoNames <- c("Subject1Tag", "Subject2Tag")
remaining <- setdiff(colnames(Links79PairWithoutOutcomes), firstTwoNames)
dsPairsWithOutcomes <- CreatePairLinksSingleEntered(
  outcomeDataset=dsOutcomes, 
  linksPairDataset=Links79PairWithoutOutcomes, 
  outcomeNames=c("MathStandardized", "WeightStandardizedForAge19To25"),     
  linksNames=remaining
)
columnsToDrop <- c("MultipleBirthIfSameSex", "RImplicitMother", "RImplicitSubject")
dsPairsWithOutcomes <- dsPairsWithOutcomes[, !(colnames(dsPairsWithOutcomes) %in% columnsToDrop)]

summary(dsPairsWithOutcomes)
table(Links79PairWithoutOutcomes$RelationshipPath)
table(dsPairsWithOutcomes$RelationshipPath)
  
  
dsPairsWithOutcomes <- subset(dsPairsWithOutcomes, Subject1Tag < Subject2Tag)
write.csv(dsPairsWithOutcomes, paste(directoryDatasets, "Links79PairsWithOutcomes.csv", sep=""), row.names=F)

###
#  Get SubjectDetails
###
channel <- odbcConnect("BeeUser")
dsSubjectDetails <- sqlQuery(channel, paste("SELECT * FROM NlsLinks.dbo.vewSubjectDetails79", sep=""))
odbcClose(channel)
summary(dsSubjectDetails)
write.csv(dsSubjectDetails, file=paste(directoryDatasets, "SubjectDetails79.csv", sep=""), row.names=F)
