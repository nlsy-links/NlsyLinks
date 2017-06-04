#' @name CleanSemAceDataset
#' @export
#'
#' @title Produces a cleaned dataset that works well with when using SEM to estimate a univariate ACE model.
#'
#' @description This function takes a 'GroupSummary' [base::data.frame] (which is created by the [RGroupSummary()] function) and returns a [base::data.frame] that is used by the [Ace()] function.
#' @usage CleanSemAceDataset(dsDirty, dsGroupSummary, oName_S1, oName_S2, rName = "R")
#'
#' @param dsDirty This is the [base::data.frame] to be cleaned.
#' @param dsGroupSummary The [base::data.frame] containing information about which groups should be included in the analyses.  It should be created by the [RGroupSummary()] function.
#' @param oName_S1 The name of the manifest variable (in `dsDirty`) for the first subject in each pair.
#' @param oName_S2 The name of the manifest variable (in `dsDirty`) for the second subject in each pair.
#' @param rName The name of the variable (in `dsDirty`) indicating the pair's relatedness coefficient.
#'
#' @details The function takes `dsDirty` and produces a new [base::data.frame] with the following features:
#'
#' 1. Only three existing columns are retained: `O1`, `O2`, and `R`.  They are assigned these names.
#'
#' 1. A new column called `GroupID` is created to reflect their group membership (which is based on the `R` value).  These valuesa re sequential integers, starting at 1.  The group with the weakest `R` is 1.  The group with the strongest `R` has the largest `GroupID` (this is typically the MZ tiwns).
#'
#' 1. Any row is excluded if it has a missing data point for `O1`, `O2`, or `R`.
#'
#' 1. The [base::data.frame] is sorted by the `R` value.  This helps program against the multiple-group SEM API sometimes.
#'
#'@return A [base::data.frame] with one row per subject pair.  The [base::data.frame] contains the following variables (which can NOT be changed by the user through optional parameters):
#' * **R** The pair's `R` value.
#' * **O1** The outcome variable for the first subject in each pair.
#' * **O2** The outcome variable for the second subject in each pair.
#' * **GroupID** Indicates the pair's group membership.
#'
#' @author Will Beasley
#'
#' @examples
#' library(NlsyLinks) #Load the package into the current R session.
#' dsLinks <- Links79PairExpanded #Start with the built-in data.frame in NlsyLinks
#' dsLinks <- dsLinks[dsLinks$RelationshipPath=='Gen2Siblings', ] #Use only NLSY79-C siblings
#'
#' oName_S1 <- "MathStandardized_S1" #Stands for Outcome1
#' oName_S2 <- "MathStandardized_S2" #Stands for Outcome2
#' dsGroupSummary <- RGroupSummary(dsLinks, oName_S1, oName_S2)
#'
#' dsClean <- CleanSemAceDataset( dsDirty=dsLinks, dsGroupSummary, oName_S1, oName_S2, rName="R" )
#' summary(dsClean)
#'
#' dsClean$AbsDifference <- abs(dsClean$O1 - dsClean$O2)
#' plot(jitter(dsClean$R), dsClean$AbsDifference, col="gray70")
#' @keywords ACE


CleanSemAceDataset <- function( dsDirty, dsGroupSummary, oName_S1, oName_S2, rName="R" ) {
  rLevelsToInclude <- dsGroupSummary[dsGroupSummary$Included, rName]

  #It's necessary to drop the missing Groups & unnecessary columns.  Missing O1s & O2s are dropped for the sake of memory space.
  oldColumnNames <- c(rName, oName_S1, oName_S2)
  newColumnNames <- c("R", "O1", "O2")
  selectedRows <- (
    (!base::is.na(dsDirty[, rName])) &
    (dsDirty[, rName] %in% rLevelsToInclude) &
    (!base::is.na(dsDirty[, oName_S1])) &
    (!base::is.na(dsDirty[, oName_S2]))
  )

  dsClean <- dsDirty[selectedRows, oldColumnNames]

  colnames(dsClean) <- newColumnNames

  dsClean <- dsClean[base::order(dsClean$R), ] #TODO: Rewrite overall code so this statement is not longer necessary anyomre.

  #This helper function allows for slight imprecision from floating-point arithmetic.
  EqualApprox <- function( target, current, toleranceAbsolute=1e-8) {
    return( abs(target-current) < toleranceAbsolute )
  }

  #rLevelsToExclude <- dsGroupSummary[!dsGroupSummary$Included, 'R']

  #This loop assigns a GroupID, depending on their R value. TODO: possibly rewrite and vectorize with plyr.
  dsClean$GroupID <- NA
  for( groupIndex in seq_along(rLevelsToInclude) ) {
    r <- rLevelsToInclude[groupIndex]
    memberIndices <- base::sapply(dsClean$R, EqualApprox, r)
    dsClean$GroupID[memberIndices] <- groupIndex
  }

  return( dsClean )
}
