#' @name Ace
#' @aliases AceUnivariate DeFriesFulkerMethod1 DeFriesFulkerMethod3
#' @export AceUnivariate DeFriesFulkerMethod1 DeFriesFulkerMethod3
#' 
#' @title Estimates the heritability of additive traits using a single variable.
#' 
#' @usage AceUnivariate(method=c("DeFriesFulkerMethod1","DeFriesFulkerMethod3"), dataSet, oName_1, oName_2, rName="R", manifestScale="Continuous")
#' 
#' DeFriesFulkerMethod1(dataSet, oName_1, oName_2, rName="R")
#' 
#' DeFriesFulkerMethod3(dataSet, oName_1, oName_2, rName="R")
#' 
#' @description An ACE model is the foundation of most behavior genetic research.  It
#' estimates the additive heritability (with \emph{a}), common environment
#' (with \emph{c}) and unshared heritability/environment (with \emph{e}).
#' 
#' @param method The specific estimation technique.
#' @param dataSet The \code{data.frame} that contains the two outcome
#' variables and the relatedness coefficient (corresponding to \code{oName_1},
#' \code{oName_2}, and \code{rName})
#' @param oName_1 The name of the outcome variable corresponding to the first
#' subject in the pair. This should be a \code{character} value.
#' @param oName_2 The name of theoutcome variable corresponding to the second
#' subject in the pair. This should be a \code{character} value.
#' @param rName The name of the relatedness coefficient for the pair (this is
#' typically abbreviated as \code{R}). This should be a \code{character}
#' value.
#' @param manifestScale Currently, only \emph{continuous} manifest/outcome variables
#' are supported.
#' @return Currently, a list is returned with the arguments \code{ASquared},
#' \code{CSquared}, \code{ESquared}, and \code{RowCount}.  In the future, this
#' may be changed to an \code{S4} class.
#' 
#' @details 
#' The \code{AceUnivariate} function is a wrapper that calls
#' \code{DeFriesFulkerMethod1} or \code{DeFriesFulkerMethod3}.  Future
#' versions will incorporate methods that use latent variable models.
#' 
#' @author Will Beasley
#' @references Rodgers, Joseph Lee, & Kohler, Hans-Peter (2005).
#' \href{http://www.springerlink.com/content/n3x1v1q282583366/}{Reformulating and simplifying the DF analysis model.}
#' \emph{Behavior Genetics, 35} (2), 211-217.
#' @examples 
#' library(NlsyLinks) #Load the package into the current R session.
#' dsOutcomes <- ExtraOutcomes79
#' dsOutcomes$SubjectTag <- CreateSubjectTag(subjectID=dsOutcomes$SubjectID,
#'   generation=dsOutcomes$Generation)
#' dsLinks <- Links79Pair
#' dsLinks <- dsLinks[dsLinks$RelationshipPath=='Gen2Siblings', ] #Use only Gen2 Siblings (ie, NLSY79-C)
#' dsDF <- CreatePairLinksDoubleEntered(outcomeDataset=dsOutcomes, linksPairDataset=dsLinks, 
#'   outcomeNames=c("MathStandardized", "HeightZGenderAge", "WeightZGenderAge"))
#' 
#' estimatedAdultHeight <- DeFriesFulkerMethod3(
#'   dataSet=dsDF,    
#'   oName_1="HeightZGenderAge_1", 
#'   oName_2="HeightZGenderAge_2")  
#' estimatedAdultHeight #ASquared and CSquared should be 0.60 and 0.10 for this rough analysis.
#' 
#' estimatedMath <- DeFriesFulkerMethod3(
#'   dataSet=dsDF,    
#'   oName_1="MathStandardized_1", 
#'   oName_2="MathStandardized_2")
#' estimatedMath #ASquared and CSquared should be 0.85 and 0.045.
#' 
#' class(GetDetails(estimatedMath))
#' summary(GetDetails(estimatedMath))
#' 
#' 
AceUnivariate <-
function( method=c("DeFriesFulkerMethod1","DeFriesFulkerMethod3"), dataSet, oName_1, oName_2, rName="R", manifestScale="Continuous" ) {
  #print( length(method) )
  if( length(method) != 1 )
    stop(paste0("The method argument must contain exactly one element when calling the AceUnivariate function.  It contained ", length(method), " elements."))
  else if( method == ""  )
    stop(paste0("The method argument must contain exactly one element when calling the AceUnivariate function.  It was blank."))
  else if( method == 'DeFriesFulkerMethod1' )
    #return( DeFriesFulkerMethod1(outcomeForSubject1, outcomeForSubject2, relatedness) )
    return( DeFriesFulkerMethod1(dataSet, oName_1, oName_2, rName) )
  else if( method == 'DeFriesFulkerMethod3' )
    #return( DeFriesFulkerMethod3(outcomeForSubject1, outcomeForSubject2, relatedness) )
    return( DeFriesFulkerMethod3(dataSet, oName_1, oName_2, rName) )
  else
    stop(paste0("The method argument, '", method ,"' was not recognized as a valid option to the AceUnivariate function."))
}
