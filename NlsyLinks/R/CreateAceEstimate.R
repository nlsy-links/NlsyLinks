CreateAceEstimate <-
function( aSquared, cSquared, eSquared, caseCount, details=list(), unityTolerance=1e-11 ) {
  componentSum <- aSquared + cSquared + eSquared
  #print(class(caseCount))
  if( missing(caseCount) ) stop("The argument 'caseCount' is missing.")
  #else if( class(caseCount) != "numeric" ) stop(paste("The argument 'caseCount' should be class 'numeric', but was '", class(caseCount), "'.", sep=""))
  
  unity <- ( abs(componentSum - 1.0) < unityTolerance )
  withinBounds <- (0 <= min(aSquared, cSquared, eSquared)) && (max( aSquared, cSquared, eSquared) <= 1)
  return( new("AceEstimate", aSquared, cSquared, eSquared, caseCount, unity, withinBounds, details) )  
}
