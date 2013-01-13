#roxygen2 documentation in CreatePairLinksDoubleEntered.R
CreatePairLinksDoubleEnteredWithNoOutcomes <-
function( linksPairDataset, linksNames=c("ExtendedID", "R", "RelationshipPath") ) {
  ValidatePairLinks(linksPairDataset)
  
  dsLinksLeftHand <- subset(linksPairDataset, select=c("Subject1Tag","Subject2Tag", linksNames)) #'Lefthand' is my slang for Subjec1Tag is less than the Subject2Tag
  dsLinksRightHand <- subset(linksPairDataset, select=c("Subject2Tag", "Subject1Tag", linksNames))
  
  colnames(dsLinksRightHand)[colnames(dsLinksRightHand)=="Subject1Tag"] <- "SubjectTempTag"
  colnames(dsLinksRightHand)[colnames(dsLinksRightHand)=="Subject2Tag"] <- "Subject1Tag"
  colnames(dsLinksRightHand)[colnames(dsLinksRightHand)=="SubjectTempTag"] <- "Subject2Tag"
  
  ds <- rbind(dsLinksLeftHand, dsLinksRightHand) #'RowBind' the two datasets
  ds <- ds[, c("Subject1Tag", "Subject2Tag", linksNames)]
  rm(dsLinksLeftHand, dsLinksRightHand)
  return( ds )
}
