#' Class AceEstimate
#'
#' @description A class containing information about a single univariate ACE model.
#'
#' @name AceEstimate-class
#'
#' @docType class
#'
#' @note The contents of the `Details` list depends on the underlying
#' estimation routine.  For example, when the ACE model is estimated with a DF
#' analysis, the output is an [stats::lm()] object, because the [stats::lm()] function
#' was used (i.e., the basic general linear model).  Alternatively, if the
#' user specified the [lavaan::lavaan()] package should estimate that ACE model,
#' the output is a [lavaan::lavaan()] object.
#'
#' @section Objects from the Class: Objects can be created by calls of the
#' form:
#' `new("AceEstimate", aSquared, cSquared, eSquared, caseCount, unity, withinBounds, details, ...)`
#'
#' @keywords classes ACE
#'
#' @examples
#' library(NlsyLinks) # Load the package into the current R session.
#'
#' showClass("AceEstimate")
#' est <- CreateAceEstimate(.5, .2, .3, 40)
#' est
#' print(est)
#'
methods::setClass(
  Class = "AceEstimate",
  representation = representation(
    ASquared = "numeric",
    CSquared = "numeric",
    ESquared = "numeric", # , CategoryStats="matrix"
    CaseCount = "numeric",
    # CaseCount="integer",
    Unity = "logical",
    WithinBounds = "logical",
    Details = "list"
  ),
  validity = function(object) {
    # print( object@ASquared )
    return(TRUE)
  }
)

methods::setMethod(
  f = "initialize",
  signature = signature(.Object = "AceEstimate"), # signature="AceEstimate",
  definition = function(.Object, aSquared, cSquared, eSquared, caseCount, unity, withinBounds, details, ...) {
    if (missing(eSquared)) eSquared <- 1 - (aSquared + cSquared)
    # print(missing(caseCount))
    # if( is.na(caseCount) ) caseCount <- 444
    # print(caseCount)
    .Object@ASquared <- aSquared
    .Object@CSquared <- cSquared
    .Object@ESquared <- eSquared
    .Object@CaseCount <- caseCount
    .Object@Unity <- unity
    .Object@WithinBounds <- withinBounds
    .Object@Details <- details
    return(.Object)
    # callNextMethod(.Object, ASquared=aSquared, CSquared=cSquared, ESquared=eSquared, CaseCount=caseCount, Unity=unity, WithinBounds=withinBounds,...)
  }
)

CreateAceEstimate <- function(aSquared, cSquared, eSquared, caseCount, details = list(), unityTolerance = 1e-11) {
  componentSum <- aSquared + cSquared + eSquared
  # print(class(caseCount))
  if (missing(caseCount)) stop("The argument 'caseCount' is missing.")
  # else if( class(caseCount) != "numeric" ) stop(paste0("The argument 'caseCount' should be class 'numeric', but was '", class(caseCount), "'."))

  unity <- (abs(componentSum - 1.0) < unityTolerance)
  withinBounds <- (0 <= min(aSquared, cSquared, eSquared)) && (max(aSquared, cSquared, eSquared) <= 1)
  #   withinBounds <- (0 <= min(aSquared, cSquared, eSquared)) & (max( aSquared, cSquared, eSquared) <= 1)
  return(new("AceEstimate", aSquared, cSquared, eSquared, caseCount, unity, withinBounds, details))
}

methods::setMethod(f = "print", "AceEstimate", function(x, ...) {
  # print("ACE Estimates: [print]")#\n")
  # aceDisplay <- matrix(c("ASquared", "CSquared", "ESquared", methods::slot(x, "ASquared"), methods::slot(x, "CSquared"), methods::slot(x, "ESquared")), byrow=T, nrow=2)
  # cat(aceDisplay, "\n")
  # print(aceDisplay)
  # print(c(ASquared=methods::slot(x, "ASquared"), CSquared=methods::slot(x, "CSquared"), ESquared=methods::slot(x, "ESquared"), CaseCount=methods::slot(x,"CaseCount")))
  # print(c(a=33, d=43))
  cat(
    "Results of ACE estimation: [print]\n",
    c(
      ASquared = methods::slot(x, "ASquared"),
      CSquared = methods::slot(x, "CSquared"),
      ESquared = methods::slot(x, "ESquared"),
      CaseCount = methods::slot(x, "CaseCount")
    )
  )
})

methods::setMethod(f = "show", "AceEstimate", function(object) {
  print("Results of ACE estimation: [show]") # \n")
  # print(c(GetEstimate(object), CaseCount=methods::slot(object, "CaseCount")))
  print(c(
    ASquared = methods::slot(object, "ASquared"),
    CSquared = methods::slot(object, "CSquared"),
    ESquared = methods::slot(object, "ESquared"),
    CaseCount = base::round(methods::slot(object, "CaseCount"))
  ))
  # cat(c(ASquared=methods::slot(object, "ASquared"), CSquared=methods::slot(object, "CSquared"), ESquared=methods::slot(object, "ESquared"), CaseCount=round(methods::slot(object,"CaseCount"))))
})

#' @name GetDetails-methods
#' @title GetDetails-methods
#' @aliases GetDetails-methods GetDetails AceEstimate-method
#' @param object ACE object
methods::setGeneric("GetDetails", function(object) {
  standardGeneric("GetDetails")
})

#' @exportMethod GetDetails
#' @docType methods
#' @title A generic function for extracting the `Details` slot of an object.
#' @rdname AceEstimate-class
#'
#' @description A generic function for extracting the `Details` slot of an AceEstimation object.
# '
# For examples see https://r-forge.r-project.org/scm/viewvc.php/pkg/lme4/man/lmList-class.Rd?view=markup&revision=2&root=lme4&pathrev=452
# ' @section Methods
# '  \describe{
# '   \item{GetDetails}{`signature(object="AceEstimate")`: Extracts the `Details` slot of an [AceEstimation] object.}
# '  }
#' @param object ACE object
#' @author Will Beasley
#' @keywords methods
methods::setMethod(
  f = "GetDetails", "AceEstimate",
  definition = function(object) {
    # print(str(object))
    return(methods::slot(object, "Details")[[1]])
  }
)
