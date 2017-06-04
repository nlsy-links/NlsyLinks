#' @name ValidateOutcomeDataset
#'
#' @export
#'
#' @title Validates the schema of datasets containing outcome variables.
#'
#' @description The \pkg{NlsyLinks} handles a lot of the plumbing code needed to transform extracted NLSY datasets into a format that statistical routines can interpret.  In some cases, a dataset of measured variables is needed, with one row per subject.  This function validates the measured/outcome dataset, to ensure it posses an interpretable schema.  For a specific list of the requirements, see `Details` below.
#'
#' @param dsOutcome A [base::data.frame] with the measured variables
#' @param outcomeNames The column names of the measure variables that eventually will be used by a statistical procedure.
#'
#' @details The `dsOutcome` parameter must:
#' 1. Have a non-missing value.
#' 1. Contain at least one row.
#' 1. Contain a column called 'SubjectTag' (case sensitive).
#' 1. Have the SubjectTag column containing only positive numbers.
#' 1. Have the SubjectTag column where all values are unique (ie, two rows/subjects cannot have the same value).
#'
#' The `outcomeNames` parameter must:
#' 1. Have a non-missing value
#' 1. Contain only column names that are present in the `dsOutcome` data frame.
#'
#' @return
#' Returns `TRUE` if the validation passes.
#' Returns an error (and associated descriptive message) if it false.
#'
#' @author Will Beasley
#'
#' @examples
#' library(NlsyLinks) #Load the package into the current R session.
#' ds <- ExtraOutcomes79
#' outcomeNames <- c("MathStandardized", "WeightZGenderAge")
#' ValidateOutcomeDataset(dsOutcome=ds, outcomeNames=outcomeNames) #Returns TRUE.
#' outcomeNamesBad <- c("MathMisspelled", "WeightZGenderAge")
#' #ValidateOutcomeDataset(dsOutcome=ds, outcomeNames=outcomeNamesBad) #Throws error.
#'
#' @keywords validation

ValidateOutcomeDataset <- function( dsOutcome, outcomeNames ) {
  if( base::missing(dsOutcome) ) stop("The parameter for 'dsOutcome' should be passed, but was not.")
  if( base::missing(outcomeNames) ) stop("The parameter for 'outcomeNames' should be passed, but was not.")

  if( !base::nrow(dsOutcome) > 0 ) stop("The dsOutcome data frame should have at least one row, but does not.")

  columnNames <- base::colnames(dsOutcome)
  if( !base::any(columnNames=="SubjectTag") )               stop("The column 'SubjectTag' should exist in the data frame, but does not. See the documentation for the 'CreateSubjectTag' function.")
  if( base::mode(dsOutcome$SubjectTag) != 'numeric' )       stop("The column 'SubjectTag' should have a 'numeric' mode, but does not.")
  if( base::any(base::is.na(dsOutcome$SubjectTag)) )        stop("The column 'SubjectTag' should not contain any NA values, but it does.")
  if( !(base::all(dsOutcome$SubjectTag > 0)) )              stop("The column 'SubjectTag' should contain only positive values, but does not.")
  if( base::anyDuplicated(dsOutcome$SubjectTag) > 0 )       stop("The column 'SubjectTag' should not contain duplicated, but it does.")
  #
  # dsOutcome[is.na(dsOutcome$SubjectTag),]

  if( base::length(outcomeNames) <= 0 ) stop("There should be at least one element in 'outcomeNames', but there were zero.")
  #if( !any(outcomeNames %in% colnames(dsOutcome)) ) stop("All 'outcomeNames' should be columns in 'dsOutcome', but at least one was missing.")
  for( i in base::seq(outcomeNames) ) {
    if( !(outcomeNames[i] %in% base::colnames(dsOutcome)) )
      base::stop(base::paste("The outcomeName '", outcomeNames[i], "' should be found in 'dsOutcome', but was missing."))
  }

  return( TRUE )
}
