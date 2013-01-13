
methods::setClass(Class="AceEstimate", 
  representation=representation(
    ASquared ="numeric",
    CSquared ="numeric",
    ESquared ="numeric", #, CategoryStats="matrix"
    CaseCount="numeric",
    #CaseCount="integer",
    Unity="logical", 
    WithinBounds="logical",
    Details="list"
  ),
  validity=function( object ) { 
    #print( object@ASquared )
    return( TRUE ) 
  }
)

methods::setMethod( f="initialize", 
  signature=signature(.Object = "AceEstimate"), # signature="AceEstimate",
  definition=function(.Object, aSquared, cSquared, eSquared, caseCount, unity, withinBounds, details, ...) {
    if( missing(eSquared) ) eSquared <- 1 - (aSquared + cSquared)    
    #print(missing(caseCount))
    #if( is.na(caseCount) ) caseCount <- 444
    #print(caseCount)
    .Object@ASquared <- aSquared
    .Object@CSquared <- cSquared
    .Object@ESquared <- eSquared
    .Object@CaseCount <- caseCount
    .Object@Unity <- unity
    .Object@WithinBounds <- withinBounds
    .Object@Details <- details
    return( .Object )
    #callNextMethod(.Object, ASquared=aSquared, CSquared=cSquared, ESquared=eSquared, CaseCount=caseCount, Unity=unity, WithinBounds=withinBounds,...)
  }
)




CreateAceEstimate <- function( aSquared, cSquared, eSquared, caseCount, details=list(), unityTolerance=1e-11 ) {
  componentSum <- aSquared + cSquared + eSquared
  #print(class(caseCount))
  if( missing(caseCount) ) stop("The argument 'caseCount' is missing.")
  #else if( class(caseCount) != "numeric" ) stop(paste("The argument 'caseCount' should be class 'numeric', but was '", class(caseCount), "'.", sep=""))
  
  unity <- ( abs(componentSum - 1.0) < unityTolerance )
  withinBounds <- (0 <= min(aSquared, cSquared, eSquared)) && (max( aSquared, cSquared, eSquared) <= 1)
  return( new("AceEstimate", aSquared, cSquared, eSquared, caseCount, unity, withinBounds, details) )  
}

methods::setMethod(f="print", "AceEstimate", function( x, ... ) {
  #print("ACE Estimates: [print]")#\n")
  #aceDisplay <- matrix(c("ASquared", "CSquared", "ESquared", slot(x, "ASquared"), slot(x, "CSquared"), slot(x, "ESquared")), byrow=T, nrow=2)
  #cat(aceDisplay, "\n")
  #print(aceDisplay)
  #print(c(ASquared=slot(x, "ASquared"), CSquared=slot(x, "CSquared"), ESquared=slot(x, "ESquared"), CaseCount=slot(x,"CaseCount")))
  #print(c(a=33, d=43))
  cat("Results of ACE estimation: [print]\n",
      c(ASquared=slot(x, "ASquared"), CSquared=slot(x, "CSquared"), ESquared=slot(x, "ESquared"), CaseCount=slot(x,"CaseCount")))
})

methods::setMethod(f="show", "AceEstimate", function( object ) {
  print("Results of ACE estimation: [show]")#\n")
  #print(c(GetEstimate(object), CaseCount=slot(object, "CaseCount")))
  print(c(ASquared=slot(object, "ASquared"), CSquared=slot(object, "CSquared"), ESquared=slot(object, "ESquared"), CaseCount=round(slot(object,"CaseCount"))))
  #cat(c(ASquared=slot(object, "ASquared"), CSquared=slot(object, "CSquared"), ESquared=slot(object, "ESquared"), CaseCount=round(slot(object,"CaseCount"))))
})

methods::setGeneric("GetDetails", function( object ) { standardGeneric("GetDetails") })
methods::setMethod(f="GetDetails", "AceEstimate", 
  definition=function( object ) {
    #print(str(object))
    return( slot(object, "Details")[[1]] )
  }
)




# setMethod("summary", "Ace", function(x, ...) {
#   cat("Results of ACE estimation:\n")
#   #aceDisplay <- matrix(c("ASquared", "CSquared", "ESquared", slot(x, "ASquared"), slot(x, "CSquared"), slot(x, "ESquared")), byrow=T, nrow=2)
#   #cat(aceDisplay, "\n")
#   #print(aceDisplay)
#   print(c(ASquared=slot(x, "ASquared"), CSquared=slot(x, "CSquared"), ESquared=slot(x, "ESquared"), CaseCount=slot(x,"CaseCount")))
#   print(c(a=33, d=43))
# })

# setGeneric("GetEstimate", function( object ) { standardGeneric("GetEstimate") })
# setMethod(f="GetEstimate", "AceEstimate", 
#           definition=function( object ) {
#             #print(str(object))
#             return( c(ASquared=slot(object, "ASquared"), CSquared=slot(object, "CSquared"), ESquared=slot(object, "ESquared")) )
#           }
#           )
