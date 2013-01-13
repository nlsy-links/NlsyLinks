
CreateSpatialNeighbours <- function( linksPairsDoubleEntered )  {
  ValidatePairLinks(linksPairsDoubleEntered)
  
  ds <- subset(linksPairsDoubleEntered, select=c("Subject1Tag", "Subject2Tag", "R"))
  colnames(ds)[colnames(ds) == "Subject1Tag"] <- "from"
  colnames(ds)[colnames(ds) == "Subject2Tag"] <- "to"
  colnames(ds)[colnames(ds) == "R"] <- "weight"
  summary(ds)
  
  class(ds) <- c("spatial.neighbour", class(ds))
  attr(ds, "region.id") <- unique(ds$from)
  attr(ds, "n") <- length(unique(ds$from)) 
  return( ds )
}

CreateSpatialNeighbours79Gen2 <- function(  )  {
  #data(Links79Pair)
  return( CreateSpatialNeighbours(Links79Pair) )
}




# #The variable 'directoryDatasets' is defined in 'FillSkeleton.R'
# 
# pathLinksPair <- paste(directoryDatasets, "Links79PairsWithOucomes.csv", sep="")
# Links79PairExpanded <- read.csv(pathLinksPair)
# 
# relationshipLabels <- c("Gen1Housemates","Gen2Siblings","Gen2Cousins","ParentChild", "AuntNiece")
# multipleBirthLabels <- c("No", "Twin", "Triplet", "DoNotKnow")
# isMzLabels <- c("No", "Yes", "DoNotKnow")
# Links79PairExpanded$RelationshipPath <- factor(Links79PairExpanded$RelationshipPath, levels=2, labels=relationshipLabels[2])
# Links79PairExpanded$MultipleBirth <- factor(Links79PairExpanded$MultipleBirth, levels=c(0, 2, 3, 255), labels=multipleBirthLabels)
# Links79PairExpanded$IsMz <- factor(Links79PairExpanded$IsMz, levels=c(0, 1, 255), labels=isMzLabels)
# Links79PairExpanded <- subset(Links79PairExpanded, select=-RImplicitDifference) #Drop RImplicitDifference
# 
# Links79Pair <- subset(Links79PairExpanded, select=c("ExtendedID","Subject1Tag","Subject2Tag", "R", "RelationshipPath"))
# 
# ExtraOutcomes79 <- read.csv(paste(directoryDatasets, "ExtraOutcomes79", sep=""))
# ExtraOutcomes79 <- subset(ExtraOutcomes79, select=-c(HeightForAge19To25, HeightStandarizedFor19to25))
# ExtraOutcomes79$Weight <- round(ExtraOutcomes79$Weight / 16)
# ExtraOutcomes79$WeightForAge19To25 <- round(ExtraOutcomes79$WeightForAge19To25 / 16)