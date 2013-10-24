
CreateSubjectTag <- function( subjectID, generation ) {
  if( length(subjectID) != length(generation) ) stop("The length of the 'subjectID' vector did not match the length of the 'generation' vector.")
  tag <- rep(NA, length(subjectID))
   for( i in seq(length(subjectID)) ) {
    if( is.na(subjectID[i]) || is.na(generation[i]) )
      tag[i] <- NA
    else if( generation[i] == 1 ) 
      tag[i] <- subjectID[i] * 100
    else if( generation[i] == 2 )
      tag[i] <- subjectID[i]
    else
      stop(paste("The generation value of '", generation[i], "' at element '", i, "' is not valid.  It must be either 1 or 2."))
   }
   return( tag )
}
VerifyColumnExists <- function( dataFrame, columnName ) {
  #columnName <- 'C0000200'
  #dataFrame <- ds
  indices <- match(columnName, colnames(dataFrame))
  if( length(indices) != 1 ) stop(paste("Exactly 1 matching column name should be found, but", length(indices), "were found."))
  return( indices )
}
RenameColumn <- function( dataFrame, oldColumnName, newColumnName ) {
  index <- VerifyColumnExists(dataFrame=dataFrame, columnName=oldColumnName)
  colnames(dataFrame)[index] <- newColumnName
  return( dataFrame )
}
RenameNlsyColumn <- function( dataFrame, nlsyRNumber, newColumnName ) {
  return( RenameColumn(dataFrame=dataFrame,  oldColumnName=nlsyRNumber, newColumnName=newColumnName) )
}

# IncludeSubjectTag <- function( ds ) {
#   if( !("SubjectID" %in% colnames(ds)) ) stop("The data frame must contain a column named 'SubjectID' (case-sensitive).")
#   if( !("Generation" %in% colnames(ds)) ) stop("The data frame must contain a column named 'Generation' (case-sensitive).")  
#   ds$SubjectTag <<- CreateSubjectTag(subjectID=ds[, "SubjectID"], generation=ds[, "Generation"])
# }
