#roxygen2 documentation in CreatePairLinksDoubleEntered.R
CreatePairLinksDoubleEnteredWithNoOutcomes <-
function( linksPairDataset, linksNames=c("ExtendedID", "R", "RelationshipPath") ) {
  ValidatePairLinks(linksPairDataset)
  
  dsLinksLeftHand <- subset(linksPairDataset, select=c("SubjectTag_S1","SubjectTag_S2", linksNames)) #'Lefthand' is my slang for Subjec1Tag is less than the SubjectTag_S2
  dsLinksRightHand <- subset(linksPairDataset, select=c("SubjectTag_S2", "SubjectTag_S1", linksNames))
  
  colnames(dsLinksRightHand)[colnames(dsLinksRightHand)=="SubjectTag_S1"] <- "SubjectTempTag"
  colnames(dsLinksRightHand)[colnames(dsLinksRightHand)=="SubjectTag_S2"] <- "SubjectTag_S1"
  colnames(dsLinksRightHand)[colnames(dsLinksRightHand)=="SubjectTempTag"] <- "SubjectTag_S2"
  
  ds <- rbind(dsLinksLeftHand, dsLinksRightHand) #'RowBind' the two datasets
  ds <- ds[, c("SubjectTag_S1", "SubjectTag_S2", linksNames)]
  rm(dsLinksLeftHand, dsLinksRightHand)
  return( ds )
}
