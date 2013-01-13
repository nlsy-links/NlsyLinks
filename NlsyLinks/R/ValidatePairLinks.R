ValidatePairLinks <-
function( linksPair ) {
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
