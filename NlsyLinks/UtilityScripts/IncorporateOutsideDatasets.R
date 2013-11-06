#This isn't part of the build process.  They should be executed infrequently, not for every build.  
#   Run it when there's a chance the extract data is different, or there's been a new version frrom NlsyLinksDetermination
rm(list=ls(all=TRUE))
require(RODBC)
require(foreign)

directoryDatasets <- "./OutsideData"

Links79PairWithoutOutcomes <- read.csv( file.path(directoryDatasets, "Links2011V83.csv"))
pairVariablesToDrop <- c("MultipleBirthIfSameSex", "RImplicitSubject", "RImplicitMother")
Links79PairWithoutOutcomes <- Links79PairWithoutOutcomes[, !(colnames(Links79PairWithoutOutcomes) %in% pairVariablesToDrop)]

dsOutcomes <- read.csv(file.path(directoryDatasets, "ExtraOutcomes79.csv"))

require(NlsyLinks)
dsOutcomes$SubjectTag <- NlsyLinks::CreateSubjectTag(subjectID=dsOutcomes$SubjectID, generation=dsOutcomes$Generation)
colnames(Links79PairWithoutOutcomes)
firstTwoNames <- c("Subject1Tag", "Subject2Tag")
remaining <- setdiff(colnames(Links79PairWithoutOutcomes), firstTwoNames)
dsPairsWithOutcomes <- NlsyLinks::CreatePairLinksSingleEntered(outcomeNames=c("MathStandardized", "HeightZGenderAge"), outcomeDataset=dsOutcomes, linksPairDataset=Links79PairWithoutOutcomes, linksNames=remaining)
dsPairsWithOutcomes <- subset(dsPairsWithOutcomes, Subject1Tag < Subject2Tag)
write.csv(dsPairsWithOutcomes, file.path(directoryDatasets, "Links79PairsWithOutcomes.csv"), row.names=F)

###
#  Get SubjectDetails from the database and 
###

##TODO:  This section shouldn't pull from a specific database.  This code should be moved to a sister file, like "D:\Projects\BG\Links2011\NlsyLinksDetermination\CodingUtilities\QueryRelatedValues.R"

channel <- RODBC::odbcDriverConnect("driver={SQL Server}; Server=Bee\\Bass; Database=NlsLinks; Uid=NlsyReadWrite; Pwd=nophi")
dsSubjectDetails <- sqlQuery(channel, "SELECT * FROM NlsLinks.dbo.vewSubjectDetails79")
odbcClose(channel)
summary(dsSubjectDetails)
write.csv(dsSubjectDetails, file=file.path(directoryDatasets, "SubjectDetails79.csv"), row.names=F)
