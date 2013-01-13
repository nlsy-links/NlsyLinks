
RGroupSummary <- function( ds, oName_1, oName_2, rName="R", determinantThreshold=1e-5) {
#     ds <- Links79PairExpanded #Start with the built-in data.frame in NlsyLinks
#     oName_1 <- "MathStandardized_1" #Stands for Manifest1
#     oName_2 <- "MathStandardized_2" #Stands for Manifest2
#   
  #   ds <-dsFull
  #   rName <- "RRR"
  
  #ds <- subset(ds, R==.75)
  rLevelsFirstPass <- sort(unique(ds[,rName])) #Enumerate the values of R existing in the current data.frame.
  #determinantThreshold <- 0 #The value the determinent should exceed to qualify as positive definite. TODO: Consider allowing the user to increase this value a little above zero, for extra stability.
#   determinantThreshold <- 1e-5 #The value the determinent should exceed to qualify as positive definite. TODO: Consider allowing the user to increase this value a little above zero, for extra stability.
  dsGroupSummary <- data.frame(R=rLevelsFirstPass, Included=F, PairCount=NA, O1Variance=NA, O2Variance=NA, O1O2Covariance=NA, Correlation=NA, Determinant=NA, PosDefinite=FALSE)
  
  
  index <- VerifyColumnExists(dataFrame=dsGroupSummary, columnName="R")
  colnames(dsGroupSummary)[index] <- rName
  
  #The primary goal of this loop is to identify the R groups whose covariance matrix isn't positive definite.
  for( rLevel in rLevelsFirstPass ) {
    #print(rLevel)
    dsGroupSlice <- ds[!is.na(ds[,rName]) & ds[,rName]==rLevel & !is.na(ds[, oName_1]) & !is.na(ds[, oName_2]), c(oName_1, oName_2)]
    
    if( nrow(dsGroupSlice) > 0 ) {
      groupCovarianceMatrix <- cov(dsGroupSlice)#, use="complete.obs") 
      determinant <- det(groupCovarianceMatrix)
      isPositiveDefinite <- (determinant > determinantThreshold)
      correlation <- cor(dsGroupSlice[, oName_1], dsGroupSlice[, oName_2])
    }
    else {
      groupCovarianceMatrix <- matrix(NA, ncol=2, nrow=2)
      determinant <- NA
      isPositiveDefinite <- F
      correlation <- NA
    }
    
    dsGroupSummary[dsGroupSummary[,rName]==rLevel, c("PairCount", "O1Variance", "O2Variance", "O1O2Covariance", "Correlation", "Determinant", "PosDefinite")] <- c(
      nrow(dsGroupSlice),
      groupCovarianceMatrix[1, 1],
      groupCovarianceMatrix[2, 2],
      groupCovarianceMatrix[1, 2],
      correlation,
      determinant,
      isPositiveDefinite
      )    
    #dsGroupSummary[dsGroupSummary[,rName]==rLevel, "Included"] <- isPositiveDefinite  
  }
  dsGroupSummary$PosDefinite <- as.logical(dsGroupSummary$PosDefinite) #I do not know how this variable was ever coerced from logical to numeric.
  dsGroupSummary[, "Included"] <- dsGroupSummary$PosDefinite #Maybe later there will be another criterion to include/exclude a group.
  
  return( dsGroupSummary )
}

CleanSemAceDataset <- function( dsDirty, dsGroupSummary, oName_1, oName_2, rName="R" ) {
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