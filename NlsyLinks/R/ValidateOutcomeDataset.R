ValidateOutcomeDataset <-
function( dsOutcome, outcomeNames ) {
  if( missing(dsOutcome) ) stop("The parameter for 'dsOutcome' should be passed, but was not.")
  if( missing(outcomeNames) ) stop("The parameter for 'outcomeNames' should be passed, but was not.")
  
  if(!nrow(dsOutcome) > 0 ) stop("The dsOutcome data frame should have at least one row, but does not.")
  
  columnNames <- colnames(dsOutcome)
  if( !any(columnNames=="SubjectTag") ) stop("The column 'SubjectTag' should exist in the data frame, but does not. See the documentation for the 'CreateSubjectTag' function.")
  if( mode(dsOutcome$SubjectTag) != 'numeric' ) stop("The column 'SubjectTag' should have a 'numeric' mode, but does not.")   
  if( !(all(dsOutcome$SubjectTag > 0)) ) stop("The column 'SubjectTag' should contain only positive values, but does not.")
  if( anyDuplicated(dsOutcome$SubjectTag) > 0 ) stop("The column 'SubjectTag' should not contain duplicated, but it does.")
  
  if( length(outcomeNames) <= 0 ) stop("There should be at least one element in 'outcomeNames', but there were zero.")  
  #if( !any(outcomeNames %in% colnames(dsOutcome)) ) stop("All 'outcomeNames' should be columns in 'dsOutcome', but at least one was missing.")
  for( i in seq(outcomeNames) ) {
    if( !(outcomeNames[i] %in% colnames(dsOutcome)) ) stop(paste("The outcomeName '", outcomeNames[i], "' should be found in 'dsOutcome', but was missing."))
  }

  return( TRUE )
}
