CreatePairLinksSingleEntered <-
function( outcomeDataset, linksPairDataset, outcomeNames, 
  linksNames=c("ExtendedID", "R", "RelationshipPath"), validateOutcomeDataset=TRUE ) {
  
  ValidatePairLinks(linksPairDataset)
  if(validateOutcomeDataset) ValidateOutcomeDataset(dsOutcome=outcomeDataset, outcomeNames=outcomeNames)
  
  dsLinksLeftHand <- subset(linksPairDataset, select=c("Subject1Tag","Subject2Tag", linksNames)) #'Lefthand' is my slang for Subjec1Tag is less than the Subject2Tag
  
  dsOutcomeSubject1 <- subset(outcomeDataset, select=c("SubjectTag", outcomeNames))
  dsOutcomeSubject2 <- subset(outcomeDataset, select=c("SubjectTag", outcomeNames))
  
  for( j in 1:ncol(dsOutcomeSubject1) ) {
    columnName <- colnames(dsOutcomeSubject1)[j]
    if( columnName %in% outcomeNames ) {
      colnames(dsOutcomeSubject1)[colnames(dsOutcomeSubject1) == columnName] <- paste(columnName, "_1", sep="")
      colnames(dsOutcomeSubject2)[colnames(dsOutcomeSubject2) == columnName] <- paste(columnName, "_2", sep="")      
    }
  }
 
  ds <- merge(x=dsLinksLeftHand, y=dsOutcomeSubject1, by.x="Subject1Tag", by.y="SubjectTag", all.x=TRUE)
  ds <- merge(x=ds, y=dsOutcomeSubject2, by.x="Subject2Tag", by.y="SubjectTag", all.x=TRUE)
 
  rm(dsLinksLeftHand, dsOutcomeSubject1, dsOutcomeSubject2)
  
  firstTwoNames <- c("Subject1Tag", "Subject2Tag")
  remaining <- setdiff(colnames(ds), firstTwoNames)
  ds <- ds[, c(firstTwoNames, remaining)]
    
  return( ds )
}
