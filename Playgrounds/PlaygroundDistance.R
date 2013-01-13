rm(list=ls(all=TRUE))
require(NlsyLinks)  #?NlsyLinks
library(Matrix)

dsSingleEntered <- subset(Links79Pair, RelationshipPath=='Gen2Siblings')
dsSingleEntered$MotherID <- floor(dsSingleEntered$Subject1Tag/100)
motherIDs <- sort(unique(dsSingleEntered$MotherID))
if( length(motherIDs) != 3749 ) stop("The number of mothers of Gen2 siblings should be correct.") #Implied is that she has to have MORE than one kid.
matReducedFamilies <- list() 
dsIndicesForMatrix <- list() 
  
familiesToExcludeBecauseMzSingleton <- c(3922, 6854, 9536)
dsSingleEntered <- subset(dsSingleEntered, !(ExtendedID %in% familiesToExcludeBecauseMzSingleton))

ExtractFullFamily <- function( dsFamilyPairs ) {
  subjectTags <- sort(unique(c(dsFamilyPairs$Subject1Tag, dsFamilyPairs$Subject2Tag)))
  subjectCount <- length(subjectTags)
  if( subjectCount <= 1 ) stop("Only families with at least two siblings should get here.")
  
  dsMZs <- subset(dsFamilyPairs, R==1) #If double entered: & Subject1Tag < Subject2Tag)
  subjectTagsOfYoungerMZs <- sort(unique(dsMZs$Subject2)) #This might include two kids in a triplet.
  dsFamilyWithoutYoungerMZs <- subset(dsFamilyPairs, !(Subject1Tag %in% subjectTagsOfYoungerMZs | Subject2Tag %in% subjectTagsOfYoungerMZs))
  
  subjectTagsWithoutYoungerMZs <- sort(unique(c(dsFamilyWithoutYoungerMZs$Subject1Tag, dsFamilyWithoutYoungerMZs$Subject2Tag)))
  subjectCountWithoutYoungerMZs <- length(subjectTagsWithoutYoungerMZs)
    
  matReduced <- matrix(NA, nrow=subjectCountWithoutYoungerMZs, ncol=subjectCountWithoutYoungerMZs)
  diag(matReduced) <- 1
  for( index1 in 1:(subjectCountWithoutYoungerMZs-1) ) {
    for( index2 in (index1+1):subjectCountWithoutYoungerMZs ) {
      subject1Tag <- subjectTagsWithoutYoungerMZs[index1]
      subject2Tag <- subjectTagsWithoutYoungerMZs[index2]      
      dsPair <- subset(dsFamilyPairs, Subject1Tag==subject1Tag & Subject2Tag==subject2Tag)
      if( nrow(dsPair)!=1 ) stop("The subset should contain exactly one row.")
      matReduced[index1, index2] <- dsPair$R
      matReduced[index2, index1] <- dsPair$R
      if( !is.na(dsPair$R) && dsPair$R == 1 ) stop("MZ reached.  None should have gotten here.")      
    }
  }

  dsIndex <- data.frame(SubjectTag=subjectTags, RowID=NA)
  runningIndex <- 1
  for( rowIndex in seq_len(nrow(dsIndex)) ) {
    subjectTag <- dsIndex$SubjectTag[rowIndex]
    if( subjectTag %in% subjectTagsWithoutYoungerMZs ) { #They're not in an MZ pair, or they're the oldest MZ
      dsIndex$RowID[rowIndex] <- runningIndex
      runningIndex <- runningIndex + 1
    }
    else {
      oldestSubjectTag <- max(subset(dsFamilyPairs, Subject2Tag==subjectTag)$Subject1Tag)
      indexOfOldest <- subset(dsIndex, SubjectTag==oldestSubjectTag)$RowID
      dsIndex$RowID[rowIndex] <- indexOfOldest
    }
  }
  if( length(unique(dsIndex$RowID)) != nrow(matReduced) ) stop("The number of uniqueAComponents should be consistent across matReduced and dsIndex")
  
  #if( max(dsFamilyPairs$R) >= .8 ) stop("MZ reached")
  return( list(MatReduced=matReduced, DsIndex=dsIndex) )
}

multipleSibFamilyCount <- 1
for( motherID in motherIDs ) {
  dsFamilyPairs <- subset(dsSingleEntered, MotherID==motherID)
  pairCount <- nrow(dsFamilyPairs)
  if( pairCount > 0 ) {
    extract <- ExtractFullFamily(dsFamilyPairs)
    matReducedFamilies[[multipleSibFamilyCount]] <- extract$MatReduced
    dsIndicesForMatrix[[multipleSibFamilyCount]] <- extract$DsIndex
    multipleSibFamilyCount <- multipleSibFamilyCount + 1 
  }  
}
if( length(matReducedFamilies) != 3745 ) stop("The number of nuculear families with multiple siblings should be correct.")

#Drop any nuclear families with any missingness
#   TODO: revise this so it drops only the minimum number of members in a family.  
#   Families will be dropped only if it contains zero nonmissing pairs
runningCompleteCount <- 0
matNonmissingFamilies <- list()
dsIndicesForMatrixForNonmissingFamilies <- list()
for( familyIndex in seq_along(matReducedFamilies) ) {
  #Check for NAs
  if( sum(is.na(matReducedFamilies[[familyIndex]])) <= 0 ) {
    runningCompleteCount <- runningCompleteCount + 1
    matNonmissingFamilies[[runningCompleteCount]] <- matReducedFamilies[[familyIndex]]
    dsIndicesForMatrixForNonmissingFamilies[[runningCompleteCount]] <- dsIndicesForMatrix[[familyIndex]]
  }  
}
if( length(matNonmissingFamilies) != 3489 ) stop("The number of nuculear families with NO missing pairs should be correct.")

#Check that there aren't any families left with only an MZ birth, and no other siblings.  
#   (This may change when the families with missingness aren't entirely chunked out the window.)
for( familyIndex in seq_along(matNonmissingFamilies) ) {
  if( all(matNonmissingFamilies[[familyIndex]]==1) ) stop("MZ singleton family")
}

#If there are any non positive definite matrices, then force them to the nearest positive definite matrix
#   Apparently, there are none. (This may change when the families with missingness aren't entirely chunked out the window.)
nudgedNonPositiveDefiniteCount <- 0
for( familyIndex in seq_along(matNonmissingFamilies) ) {
  if( any(eigen(matNonmissingFamilies[[familyIndex]])$values<=0) ) {
    matNonmissingFamilies[[familyIndex]] <- as.matrix(nearPD(matNonmissingFamilies[[familyIndex]], corr=T)$mat)
    nudgedNonPositiveDefiniteCount <- nudgedNonPositiveDefiniteCount + 1
  }
}
if( nudgedNonPositiveDefiniteCount !=0 ) stop("The number of nudgedNonPositiveDefiniteCount should be correct.")

#Now create proper GMRF weights to be used in GMRF BG analysis
matBetaFamilies <- list()
matDogmaFamilies <- list() #What does 'D' stand for in 'Dmat'?
for( familyIndex in seq_along(matNonmissingFamilies) ) {
  Rmat <- matNonmissingFamilies[[familyIndex]]
  Bmat <- matrix(0,nrow(Rmat),ncol(Rmat)) #stores conditional beta weights
  Dmat <- matrix(0,nrow(Rmat),ncol(Rmat))#stores conditional residual variances
  Imat <- diag(1,nrow(Rmat),ncol(Rmat))#create Identity matrix for later back translation to original Rmat (an error check method to be used in later unit testing)
  for(i in 1:nrow(Rmat)){
    mymat <- Rmat[-i,-i] #create the matrix w/o the row/col for the individual
    invmat <- solve(mymat) #Inverse matrix of what's left over
    colCorr <- Rmat[-i,i] #Correlations of that guy with his family members
    betas <- invmat %*% colCorr #The OLS solution
    vare <- 1 - t(betas) %*% mymat %*% betas #What's left over.  We're working with standardized variables, so everything should add to one.
    Bmat[i,-i] <- betas #Using other family members to predict his A effect.
    Dmat[i,i] <- vare #What's left over
  }
  sigMVN <- solve(Imat - Bmat) %*% Dmat #sigMVN Should equal Rmat!!! will later use this for unit testing
  if( sum(abs(sigMVN - Rmat)) > 1e-12 ) stop("The recovered/checked matrix was not within the specified allowed error.")
  #if( sum(Bmat) != ???? ) stop("The elements of beta matrix should equal ????.")
  #if( sum(Dmat) != ???? ) stop("The elements of dogma matrix should equal ????.")
  #print(sum(Bmat))
  
  #cov2cor(sigMVN)
  matBetaFamilies[[familyIndex]] <- Bmat
  matDogmaFamilies[[familyIndex]] <- Dmat  
}

#Transfer the beta weights back into the sparse matrix
dsDoubleEntered <- CreatePairLinksDoubleEnteredWithNoOutcomes(Links79Pair)
dsDoubleEntered$weight <- NA
for( familyIndex in seq_along(matBetaFamilies) ) {
#for( familyIndex in 1 ) {
  #print(familyIndex)
  matBeta <- matBetaFamilies[[familyIndex]]
  dsFamilyIndices <- dsIndicesForMatrixForNonmissingFamilies[[familyIndex]]
  if( length(unique(dsFamilyIndices$RowID)) != nrow(matBeta) ) stop("The number of uniqueAComponents should be consistent across matReduced and dsIndex")
  
  kidCount <- nrow(dsFamilyIndices)
  for( subject1Index in 1:kidCount ) {
    rowID1 <- dsFamilyIndices$RowID[subject1Index]
    subject1Tag <- dsFamilyIndices$SubjectTag[subject1Index]
    for( subject2Index in 1:kidCount ) {
      rowID2 <- dsFamilyIndices$RowID[subject2Index]
      subject2Tag <- dsFamilyIndices$SubjectTag[subject2Index]
      
      if( subject1Index != subject2Index ) {
        weight <- matBeta[rowID1, rowID2]
        selectedIndex <- which(dsDoubleEntered$Subject1Tag==subject1Tag & dsDoubleEntered$Subject2Tag==subject2Tag)
        if( length(selectedIndex) != 1 ) stop("Exactly one row should be retrieved to add the spatial weight.")
        
        dsDoubleEntered[selectedIndex , 'weight'] <- weight        
        if( is.na(dsDoubleEntered[selectedIndex , 'weight']) ) stop("The assigned weight should not be NA.")
      }      
    }    
  }
}

#Inspect the sparse matrix and the relationship between R & weight
hist(dsDoubleEntered$weight)
summary(dsDoubleEntered)
plot(jitter(dsDoubleEntered$R), dsDoubleEntered$weight)
abline(a=0, b=1)
if( sum(!is.na(dsDoubleEntered$weight)) != 19846 ) stop("The count of nonmissing neighbor weights should be correct.")

#Create a spatial.neighbors object from the sparse matrix
dsNeighbors <- dsDoubleEntered

#head(cbind(dsNeighbors$Subject1Tag, order(dsNeighbors$Subject1Tag)), 100)

dsNeighbors$from <- as.integer(ordered(dsNeighbors$Subject1Tag))
dsNeighbors$to <- as.integer(ordered(dsNeighbors$Subject2Tag))
summary(dsNeighbors)
 
class(dsNeighbors) <- c("spatial.neighbour", class(dsNeighbors))
attr(dsNeighbors, "region.id") <- unique(dsNeighbors$from)
attr(dsNeighbors, "n") <- length(unique(dsNeighbors$from))

head(dsNeighbors, 20)