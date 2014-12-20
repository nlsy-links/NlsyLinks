#roxygen2 documentation in CreatePairLinksDoubleEntered.R

CreatePairLinksSingleEntered <- 
  function( outcomeDataset, linksPairDataset, outcomeNames, 
  linksNames=c("ExtendedID", "R", "RelationshipPath"), validateOutcomeDataset=TRUE,
  subject1Qualifier="_S1", subject2Qualifier="_S2") {
  
  ValidatePairLinks(linksPairDataset)
  if(validateOutcomeDataset) ValidateOutcomeDataset(dsOutcome=outcomeDataset, outcomeNames=outcomeNames)
  
  dsLinksLeftHand <- subset(linksPairDataset, select=c("SubjectTag_S1","SubjectTag_S2", linksNames)) #'Lefthand' is my slang for Subjec1Tag is less than the SubjectTag_S2
  
  dsOutcomeSubject1 <- subset(outcomeDataset, select=c("SubjectTag", outcomeNames))
  dsOutcomeSubject2 <- subset(outcomeDataset, select=c("SubjectTag", outcomeNames))
  
  for( j in 1:ncol(dsOutcomeSubject1) ) {
    columnName <- colnames(dsOutcomeSubject1)[j]
    if( columnName %in% outcomeNames ) {
      colnames(dsOutcomeSubject1)[colnames(dsOutcomeSubject1) == columnName] <- paste0(columnName, subject1Qualifier)
      colnames(dsOutcomeSubject2)[colnames(dsOutcomeSubject2) == columnName] <- paste0(columnName, subject2Qualifier)      
    }
  }
 
  ds <- merge(x=dsLinksLeftHand, y=dsOutcomeSubject1, by.x="SubjectTag_S1", by.y="SubjectTag", all.x=TRUE)
  ds <- merge(x=ds, y=dsOutcomeSubject2, by.x="SubjectTag_S2", by.y="SubjectTag", all.x=TRUE)
 
  rm(dsLinksLeftHand, dsOutcomeSubject1, dsOutcomeSubject2)
  
  firstTwoNames <- c("SubjectTag_S1", "SubjectTag_S2")
  remaining <- setdiff(colnames(ds), firstTwoNames)
  ds <- ds[, c(firstTwoNames, remaining)]
    
  return( ds )
}
