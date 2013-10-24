
ValidatePairLinks <- function( linksPair ) {
  if(!nrow(linksPair) > 0 ) stop("The linksPair data frame should have at least one row, but does not.")
  
  columnNames <- colnames(linksPair)
  if( !any(columnNames=="Subject1Tag") ) stop("The column 'Subject1Tag' should exist in the linksPair file, but does not.")
  if( !any(columnNames=="Subject2Tag") ) stop("The column 'Subject2Tag' should exist in the linksPair file, but does not.")
  if( !any(columnNames=="R") ) stop("The column 'R' should exist in the linksPair file, but does not.")
#   if( !any(columnNames=="MultipleBirth") ) stop("The column 'MultipleBirth' should exist in the linksPair file, but does not.")
  
  if( mode(linksPair$Subject1Tag) != 'numeric' ) stop("The column 'Subject1Tag' should have a 'numeric' mode, but does not.")
  if( mode(linksPair$Subject2Tag) != 'numeric' ) stop("The column 'Subject2Tag' should have a 'numeric' mode, but does not.")
  if( mode(linksPair$R) != 'numeric' ) stop("The column 'R' should have a 'numeric' mode, but does not.")
#   if( mode(linksPair$MultipleBirth) != 'numeric' ) stop("The column 'MultipleBirth' should have a 'numeric' mode, but does not.")
  
  return( TRUE )
}
ValidatePairLinksAreSymmetric <- function( linksPair ) {
  ValidatePairLinks(linksPair)
  for( rowIndex in seq_along(nrow(linksPair)) ) {
#     tag1 <- linksPair$Subject1Tag[rowIndex]
#     tag2 <- linksPair$Subject2Tag[rowIndex]    
#     r <- linksPair$R[rowIndex]    
#     path <- linksPair$RelationshipPath[rowIndex]
    tag1 <- linksPair[rowIndex, 'Subject1Tag']
    tag2 <- linksPair[rowIndex, 'Subject2Tag']    
    r <- linksPair[rowIndex, 'R']    
    path <- linksPair[rowIndex, 'RelationshipPath']    
    #oppositeCount <- nrow(subset(linksPair, Subject1Tag==tag2 & Subject2Tag==tag1 & R==r & RelationshipPath==path))
    oppositeCount <- nrow(linksPair[linksPair$Subject1Tag==tag2 & linksPair$Subject2Tag==tag1 & linksPair$R==r & linksPair$RelationshipPath==path, ])
    if( oppositeCount != 1 ) {
      stop(paste("The 'linksPair' dataset doesn't appear to be double-entered & symmetric.  The reciprocal of (Subject1Tag, Subject2Tag, R)=(",
                 tag1, ", ", tag2, ", ", r, ") was found ", oppositeCount, " time(s).", sep=""))
    }
  }  
  return( TRUE )
}
CreatePairLinksDoubleEntered <- function( outcomeDataset, linksPairDataset, outcomeNames, 
  linksNames=c("ExtendedID", "R", "RelationshipPath"), validateOutcomeDataset=TRUE ) {
  
  ValidatePairLinks(linksPairDataset)
  if(validateOutcomeDataset) ValidateOutcomeDataset(dsOutcome=outcomeDataset, outcomeNames=outcomeNames)
  
  dsLinksLeftHand <- subset(linksPairDataset, select=c("Subject1Tag","Subject2Tag", linksNames)) #'Lefthand' is my slang for Subjec1Tag is less than the Subject2Tag
  dsLinksRightHand <- subset(linksPairDataset, select=c("Subject1Tag", "Subject2Tag", linksNames))

  colnames(dsLinksRightHand)[colnames(dsLinksRightHand)=="Subject1Tag"] <- "SubjectTempTag"
  colnames(dsLinksRightHand)[colnames(dsLinksRightHand)=="Subject2Tag"] <- "Subject1Tag"
  colnames(dsLinksRightHand)[colnames(dsLinksRightHand)=="SubjectTempTag"] <- "Subject2Tag"
  
  dsOutcomeSubject1 <- subset(outcomeDataset, select=c("SubjectTag", outcomeNames))
  dsOutcomeSubject2 <- subset(outcomeDataset, select=c("SubjectTag", outcomeNames))
  
  for( j in 1:ncol(dsOutcomeSubject1) ) {
    columnName <- colnames(dsOutcomeSubject1)[j]
    if( columnName %in% outcomeNames ) {
      colnames(dsOutcomeSubject1)[colnames(dsOutcomeSubject1) == columnName] <- paste(columnName, "_1", sep="")
      colnames(dsOutcomeSubject2)[colnames(dsOutcomeSubject2) == columnName] <- paste(columnName, "_2", sep="")      
    }
  }
 
  dsLeftHand <- merge(x=dsLinksLeftHand, y=dsOutcomeSubject1, by.x="Subject1Tag", by.y="SubjectTag", all.x=TRUE)
  dsLeftHand <- merge(x=dsLeftHand, y=dsOutcomeSubject2, by.x="Subject2Tag", by.y="SubjectTag", all.x=TRUE)
    
  dsRightHand <- merge(x=dsLinksRightHand, y=dsOutcomeSubject2, by.x="Subject2Tag", by.y="SubjectTag", all.x=TRUE)
  dsRightHand <- merge(x=dsRightHand, y=dsOutcomeSubject1, by.x="Subject1Tag", by.y="SubjectTag", all.x=TRUE)
 
  rm(dsLinksLeftHand, dsLinksRightHand, dsOutcomeSubject1, dsOutcomeSubject2)
  
  ds <- rbind(dsLeftHand, dsRightHand) #'RowBind' the two datasets
  
  firstTwoNames <- c("Subject1Tag", "Subject2Tag")
  remaining <- setdiff(colnames(ds), firstTwoNames)
  ds <- ds[, c(firstTwoNames, remaining)]
    
  return( ds )
}
CreatePairLinksDoubleEnteredWithNoOutcomes <- function( linksPairDataset, linksNames=c("ExtendedID", "R", "RelationshipPath") ) {
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
CreatePairLinksSingleEntered <- function( outcomeDataset, linksPairDataset, outcomeNames, 
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
