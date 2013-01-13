#This isn't part of the build process.  They should be executed infrequently, not for every build.
require(RODBC)
require(foreign)
rm(list=ls(all=TRUE))

directory <- "F:/Projects/RDev/NlsyLinksStaging/"
directoryDatasets <- paste(directory, "Datasets/", sep="")

Links79PairWithoutOutcomes <- read.csv( file.path(directoryDatasets, "Links2011V52.csv"))
pairVariablesToDrop <- c("MultipleBirthIfSameSex", "RImplicitSubject", "RImplicitMother")
Links79PairWithoutOutcomes <- Links79PairWithoutOutcomes[, !(colnames(Links79PairWithoutOutcomes) %in% pairVariablesToDrop)]


dsOutcomes <- read.csv(file.path(directoryDatasets, "ExtraOutcomes79.csv"))
#CreatePairLinks

require(NlsyLinks)
#data(Links79PairExpanded)
# data(ExtraOutcomes79)
dsOutcomes$SubjectTag <- NlsyLinks::CreateSubjectTag(subjectID=dsOutcomes$SubjectID, generation=dsOutcomes$Generation)
colnames(Links79PairWithoutOutcomes)
firstTwoNames <- c("Subject1Tag", "Subject2Tag")
remaining <- setdiff(colnames(Links79PairWithoutOutcomes), firstTwoNames)
dsPairsWithOutcomes <- NlsyLinks::CreatePairLinksSingleEntered(outcomeNames=c("MathStandardized", "HeightZGenderAge"), outcomeDataset=dsOutcomes, linksPairDataset=Links79PairWithoutOutcomes, linksNames=remaining)
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