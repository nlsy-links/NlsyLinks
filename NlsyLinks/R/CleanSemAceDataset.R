CleanSemAceDataset <-
function( dsDirty, dsGroupSummary, oName_1, oName_2, rName="R" ) {
  rLevelsToInclude <- dsGroupSummary[dsGroupSummary$Included, rName]
  
  #It's necessary to drop the missing Groups & unnecessary columns.  Missing O1s & O2s are dropped for the sake of memory space.
  oldColumnNames <- c(rName, oName_1, oName_2)
  newColumnNames <- c("R", "O1", "O2")
  selectedRows <- (!is.na(dsDirty[, rName])) & (dsDirty[, rName] %in%  rLevelsToInclude) & (!is.na(dsDirty[, oName_1])) & (!is.na(dsDirty[, oName_2]))
  dsClean <- dsDirty[selectedRows, oldColumnNames] 
  
  colnames(dsClean) <- newColumnNames
  
  dsClean <- dsClean[order(dsClean$R), ] #TODO: Rewrite overall code so this statement is not longer necessary anyomre.
  
  #This helper function allows for slight imprecision from floating-point arithmetic.
  EqualApprox <- function( target, current, toleranceAbsolute=1e-8) {  
    return( abs(target-current) < toleranceAbsolute ) 
  }
  
  #rLevelsToExclude <- dsGroupSummary[!dsGroupSummary$Included, 'R']
  
  #This loop assigns a GroupID, depending on their R value. TODO: possibly rewrite and vectorize with plyr.
  dsClean$GroupID <- NA
  for( groupIndex in seq_along(rLevelsToInclude) ) {
    r <- rLevelsToInclude[groupIndex]
    memberIndices <- sapply(dsClean$R, EqualApprox, r)
    dsClean$GroupID[memberIndices] <- groupIndex
  }
  
  return( dsClean )
}
