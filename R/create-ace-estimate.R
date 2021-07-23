#' @name CreateAceEstimate
#' @export
#' @importFrom methods new
#'
#' @title Instantiate an [AceEstimate-class] object.
#' @description Creates an instance of the `S4` class, [AceEstimate-class] instantiating arguments set the parameter values estimated by the ACE model.
#'
#' @param aSquared The proportion of variability due to a shared genetic influence (typically represented as a^2, or sometimes h^2).
#' @param cSquared The proportion of variability due to shared common environmental influence.
#' @param eSquared The proportion of variability due to unexplained/residual/error influence.
#' @param caseCount The number of cases used to estimate the model.
#' @param unityTolerance Specifies how close the the sum of the ACE components should be to one, to be considered properly scaled to one.
#' @param details A `list` that contains the modeling output and details.
#'
#' @details The contents of the `details` list depends on the underlying estimation routine.  For example, when the ACE model is estimated with a DF analysis, the output is a [stats::lm] object, because the [stats::lm] function was used (ie, the basic general linear model).  Alternatively, if the user specified the `lavaan` package should estimate that ACE model, the output is a [lavaan::lavaan] object.
#'
#' @return An S4 object of [AceEstimate-class].
#' @author Will Beasley
#' @keywords ACE

CreateAceEstimate <- function( aSquared, cSquared, eSquared, caseCount, details=list(), unityTolerance=1e-11 ) {
  componentSum <- aSquared + cSquared + eSquared
  #print(class(caseCount))
  if( base::missing(caseCount) )
    base::stop("The argument 'caseCount' is missing.")

  #else if( class(caseCount) != "numeric" ) stop(paste0("The argument 'caseCount' should be class 'numeric', but was '", class(caseCount), "'."))

  unity <- ( base::abs(componentSum - 1.0) < unityTolerance )
  withinBounds <- (0 <= base::min(aSquared, cSquared, eSquared)) && (base::max( aSquared, cSquared, eSquared) <= 1)
  return( new("AceEstimate", aSquared, cSquared, eSquared, caseCount, unity, withinBounds, details) )
}
