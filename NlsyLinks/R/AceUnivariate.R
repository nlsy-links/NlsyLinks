AceUnivariate <-
function( method=c("DeFriesFulkerMethod1","DeFriesFulkerMethod3"), dataSet, oName_1, oName_2, rName="R", manifestScale="Continuous" ) {
  #print( length(method) )
  if( length(method) != 1 )
    stop(paste("The method argument must contain exactly one element when calling the AceUnivariate function.  It contained ", length(method), " elements.", sep=""))
  else if( method == ""  )
    stop(paste("The method argument must contain exactly one element when calling the AceUnivariate function.  It was blank.", sep=""))
  else if( method == 'DeFriesFulkerMethod1' )
    #return( DeFriesFulkerMethod1(outcomeForSubject1, outcomeForSubject2, relatedness) )
    return( DeFriesFulkerMethod1(dataSet, oName_1, oName_2, rName) )
  else if( method == 'DeFriesFulkerMethod3' )
    #return( DeFriesFulkerMethod3(outcomeForSubject1, outcomeForSubject2, relatedness) )
    return( DeFriesFulkerMethod3(dataSet, oName_1, oName_2, rName) )
  else
    stop(paste("The method argument, '", method ,"' was not recognized as a valid option to the AceUnivariate function.", sep=""))
}
