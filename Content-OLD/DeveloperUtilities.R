
PrintVector <- function( scores ) {
  str <- "c("
  for( i in seq(length(scores)) ) {
    if( i > 1 ) str <- paste(str, ",", sep="")
    if( (i %% 100) == 0 ) str <- paste(str, "\n", sep="") #start a new line every 100 elements
    str <- paste(str, scores[i], sep="")
  }
  str <- paste(str, ")", sep="")
  return( str )
}
