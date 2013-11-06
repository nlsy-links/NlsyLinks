#The variable 'directoryDatasets' is defined in 'FillSkeleton.R'
# directory <- "F:/Projects/RDev/NlsyLinksStaging"
# directoryDatasets <- file.path(directory, "Datasets")
require(plyr)

Links79PairExpanded <- read.csv("./Datasets/Links79PairsWithOutcomes.csv", stringsAsFactors=F)

relationshipLabels <- c("Gen1Housemates","Gen2Siblings","Gen2Cousins","ParentChild", "AuntNiece")
# multipleBirthLabels <- c("No", "Twin", "Triplet", "DoNotKnow")
isMzLabels <- c("No", "Yes", "DoNotKnow")

# ambiguousSibsR <- .375
# Links79PairExpanded$R[is.na(Links79PairExpanded$R)] <- ambiguousSibsR

#Links79PairExpanded$RelationshipPath <- factor(Links79PairExpanded$RelationshipPath, levels=2, labels=relationshipLabels[2])
Links79PairExpanded$RelationshipPath <- factor(Links79PairExpanded$RelationshipPath, levels=1:5, labels=relationshipLabels)
# Links79PairExpanded$MultipleBirth <- factor(Links79PairExpanded$MultipleBirth, levels=c(0, 2, 3, 255), labels=multipleBirthLabels)
Links79PairExpanded$IsMz <- factor(Links79PairExpanded$IsMz, levels=c(0, 1, 255), labels=isMzLabels)
Links79PairExpanded <- subset(Links79PairExpanded, select=-RImplicitDifference) #Drop RImplicitDifference

Links79Pair <- subset(Links79PairExpanded, select=c("ExtendedID", "Subject1Tag", "Subject2Tag", "R", "RelationshipPath"))

ExtraOutcomes79 <- read.csv("./Datasets/ExtraOutcomes79.csv", stringsAsFactors=F)
#ExtraOutcomes79$SubjectTag <- CreateSubjectTag(ExtraOutcomes79$SubjectID, ExtraOutcomes79$Generation)
# ExtraOutcomes79 <- subset(ExtraOutcomes79, select=-c(HeightForAge19To25, HeightStandarizedFor19to25))
# ExtraOutcomes79$Weight <- round(ExtraOutcomes79$Weight / 16)
# ExtraOutcomes79$WeightForAge19To25 <- round(ExtraOutcomes79$WeightForAge19To25 / 16)

# dsHeightGen2 <- read.csv(file.path(directoryDatasets, "Gen2Height.csv"))
# dsHeightGen2 <- dsHeightGen2[, c("SubjectTag", "HeightZAgeGender")]
# summary(dsHeightGen2)
# 
# ExtraOutcomes79 <- plyr::join(x=ExtraOutcomes79, y=dsHeightGen2, by="SubjectTag", type="left")

firstColumns <- c("SubjectTag", "SubjectID", "Generation")
remaining <- setdiff(colnames(ExtraOutcomes79), firstColumns)
ExtraOutcomes79 <- ExtraOutcomes79[, c(firstColumns, remaining)]
rm(firstColumns, remaining)

SubjectDetails79 <- read.csv(file.path(directoryDatasets, "SubjectDetails79.csv"), 
  colClasses=c("integer", "integer", "integer","integer", "integer", "integer", "integer", "integer", "Date" , "integer", "double", "integer", "Date"))                             
  #colClasses=c("integer", "integer", "integer","integer", "integer", "integer", "integer", "integer", "Date" , "integer", "integer", "integer", "Date"))
                             
SubjectDetails79$IsDead <- NA
#summary(SubjectDetails79)
#mode(SubjectDetails79$Mob)
