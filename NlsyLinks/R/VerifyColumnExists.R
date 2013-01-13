VerifyColumnExists <-
function( dataFrame, columnName ) {
  #columnName <- 'C0000200'
  #dataFrame <- ds
  indices <- match(columnName, colnames(dataFrame))
  if( length(indices) != 1 ) stop(paste("Exactly 1 matching column name should be found, but", length(indices), "were found."))
  return( indices )
}
