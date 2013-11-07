#This isn't part of the build process.  They should be executed infrequently, not for every build.  
#   Run it when there's a chance the extract data is different, or there's been a new version frrom NlsyLinksDetermination
rm(list=ls(all=TRUE))
if( any(search()=="package:NlsyLinks") ) detach("package:NlsyLinks") #So the lazy-loaded datasets aren't available
# if( any(.packages(all.available=TRUE) == "NlsyLinks") ) remove.packages("NlsyLinks") #system("R CMD REMOVE NlsyLinks") #This shouldn't be necesary.
require(RODBC)
# require(NlsyLinks) #Don't load' the lazy-loaded datasets shouldn't be accessible

###############################################################
###  Declare Paths
###############################################################
directoryDatasetsCsv <- "./OutsideData" #These CSVs are in the repository, but not in the build.
directoryDatasetsRda <- "./data" #These RDAs are derived from the CSV, and included in the build as compressed binaries.

pathInputLinks <- file.path(directoryDatasetsCsv, "Links2011V83.csv")

pathOutputLinkTrim <- file.path(directoryDatasetsRda, "Links79Pair.rda")
pathOutputLinkExpanded <- file.path(directoryDatasetsRda, "Links79PairExpanded.rda")

pathOutputSubjectDetailsCsv <- file.path(directoryDatasetsCsv, "SubjectDetails79.csv")
pathOutputSubjectDetailsRda <- file.path(directoryDatasetsRda, "SubjectDetails79.rda")

###############################################################
###  ExtraOutcomes79
###############################################################
ExtraOutcomes79 <- read.csv(file.path(directoryDatasetsCsv, "ExtraOutcomes79.csv"))
# ExtraOutcomes79$SubjectTag <- round(ExtraOutcomes79$SubjectTag)

sapply(ExtraOutcomes79, class)
###############################################################
###  Links79PairExpanded and Links79Pair 
###############################################################
Links79PairWithoutOutcomes <- read.csv(pathInputLinks, stringsAsFactors=FALSE)
pairVariablesToDrop <- c("MultipleBirthIfSameSex", "RImplicitSubject", "RImplicitMother")
Links79PairWithoutOutcomes <- Links79PairWithoutOutcomes[, !(colnames(Links79PairWithoutOutcomes) %in% pairVariablesToDrop)]

sapply(Links79PairWithoutOutcomes, class)

ExtraOutcomes79$SubjectTag <- NlsyLinks::CreateSubjectTag(subjectID=ExtraOutcomes79$SubjectID, generation=ExtraOutcomes79$Generation)
# colnames(Links79PairWithoutOutcomes)
firstNames <- c("Subject1Tag", "Subject2Tag")
remaining <- setdiff(colnames(Links79PairWithoutOutcomes), firstNames)
Links79PairExpanded <- NlsyLinks::CreatePairLinksSingleEntered(
  outcomeNames=c("MathStandardized", "HeightZGenderAge"), 
  outcomeDataset=ExtraOutcomes79, 
  linksPairDataset=Links79PairWithoutOutcomes, 
  linksNames=remaining)
Links79PairExpanded <- Links79PairExpanded[Links79PairExpanded$Subject1Tag < Links79PairExpanded$Subject2Tag, ]

### Prepare for rda
Links79PairExpanded <- Links79PairExpanded[order(Links79PairExpanded$ExtendedID, Links79PairExpanded$Subject1Tag, Links79PairExpanded$Subject2Tag), ]
relationshipLabels <- c("Gen1Housemates","Gen2Siblings","Gen2Cousins","ParentChild", "AuntNiece")
# multipleBirthLabels <- c("No", "Twin", "Triplet", "DoNotKnow")
isMzLabels <- c("No", "Yes", "DoNotKnow")

Links79PairExpanded$RelationshipPath <- factor(Links79PairExpanded$RelationshipPath, levels=seq_along(relationshipLabels), labels=relationshipLabels)
# Links79PairExpanded$MultipleBirth <- factor(Links79PairExpanded$MultipleBirth, levels=c(0, 2, 3, 255), labels=multipleBirthLabels)
Links79PairExpanded$IsMz <- factor(Links79PairExpanded$IsMz, levels=c(0, 1, 255), labels=isMzLabels)
Links79PairExpanded <- subset(Links79PairExpanded, select=-RImplicitDifference) #Drop RImplicitDifference

Links79Pair <- Links79PairExpanded[, c("ExtendedID", "Subject1Tag", "Subject2Tag", "R", "RelationshipPath")]

save(Links79Pair, file=pathOutputLinkTrim, compress="xz")
save(Links79PairExpanded, file=pathOutputLinkExpanded, compress="xz")

###############################################################
###  SubjectDetails
###############################################################


##TODO:  This section shouldn't pull from a specific database.  This code should be moved to a sister file, like "D:\Projects\BG\Links2011\NlsyLinksDetermination\CodingUtilities\QueryRelatedValues.R"

channel <- RODBC::odbcDriverConnect("driver={SQL Server}; Server=Bee\\Bass; Database=NlsLinks; Uid=NlsyReadWrite; Pwd=nophi")
SubjectDetails79 <- sqlQuery(channel, "SELECT * FROM NlsLinks.dbo.vewSubjectDetails79")
odbcClose(channel)
summary(SubjectDetails79)
save(SubjectDetails79, file=pathOutputSubjectDetailsRda, compress="xz")
# saveRDS(dsSubjectDetails, file=file.path(directoryDatasetsRda, "SubjectDetails79.rds"), compress="xz")
