ValidatePairLinksAreSymmetric <-
function( linksPair ) {
  ValidatePairLinks(linksPair)
  for( rowIndex in seq_along(nrow(linksPair)) ) {
#     tag1 <- linksPair$Subject1Tag[rowIndex]
#     tag2 <- linksPair$Subject2Tag[rowIndex]    
#     r <- linksPair$R[rowIndex]    
#     path <- linksPair$RelationshipPath[rowIndex]
    tag1 <- linksPair[rowIndex, 'Subject1Tag']
    tag2 <- linksPair[rowIndex, 'Subject2Tag']    
    r <- linksPair[rowIndex, 'R']    
    path <- linksPair[rowIndex, 'RelationshipPath']    
    #oppositeCount <- nrow(subset(linksPair, Subject1Tag==tag2 & Subject2Tag==tag1 & R==r & RelationshipPath==path))
    oppositeCount <- nrow(linksPair[linksPair$Subject1Tag==tag2 & linksPair$Subject2Tag==tag1 & linksPair$R==r & linksPair$RelationshipPath==path, ])
    if( oppositeCount != 1 ) {
      stop(paste("The 'linksPair' dataset doesn't appear to be double-entered & symmetric.  The reciprocal of (Subject1Tag, Subject2Tag, R)=(",
                 tag1, ", ", tag2, ", ", r, ") was found ", oppositeCount, " time(s).", sep=""))
    }
  }  
  return( TRUE )
}
