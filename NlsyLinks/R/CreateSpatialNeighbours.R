CreateSpatialNeighbours <-
function( linksPairsDoubleEntered )  {
  ValidatePairLinks(linksPairsDoubleEntered)
  
  ds <- subset(linksPairsDoubleEntered, select=c("Subject1Tag", "Subject2Tag", "R"))
  colnames(ds)[colnames(ds) == "Subject1Tag"] <- "from"
  colnames(ds)[colnames(ds) == "Subject2Tag"] <- "to"
  colnames(ds)[colnames(ds) == "R"] <- "weight"
  summary(ds)
  
  class(ds) <- c("spatial.neighbour", class(ds))
  attr(ds, "region.id") <- unique(ds$from)
  attr(ds, "n") <- length(unique(ds$from)) 
  return( ds )
}
