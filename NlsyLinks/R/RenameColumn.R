RenameColumn <-
function( dataFrame, oldColumnName, newColumnName ) {
  index <- VerifyColumnExists(dataFrame=dataFrame, columnName=oldColumnName)
  colnames(dataFrame)[index] <- newColumnName
  return( dataFrame )
}
