CreateSubjectTag <-
function( subjectID, generation ) {
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
