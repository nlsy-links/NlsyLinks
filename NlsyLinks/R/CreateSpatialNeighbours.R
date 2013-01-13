#' @name CreateSpatialNeighbours
#' @aliases CreateSpatialNeighbours
#' @export
#' 
#' @title Distances between related family members, formated for spatial analysis.
#' @description This helper function formats the LinksPair datasets so it can be used in some types of spatial analyses. The \pkg{spdep} (Spatial Dependence) uses a sparse matrix (actually a \code{\link{data.frame}}) to represent neigbours.
#' @usage  CreateSpatialNeighbours(linksPairsDoubleEntered)
## CreateSpatialNeighbours79Gen2()
#' @param linksPairsDoubleEntered A \code{data.frame} containing the links, preferably created by a function like \code{\link{CreatePairLinksDoubleEntered}}.
#' 
#' @details There is one row per unique pair of subjects, \emph{respecting order}.  This is different than \code{\link{Links79Pair}} and \code{\link{Links79PairExpanded}}, which has one row per unique pair of subjects, \emph{irrespective of order}.
# #' \code{CreateSpatialNeighbours79Gen2} automatically creates dataset of NLSY79 Gen2 subjects (i.e., the children of the mothers in the initial NLSY79 sample.
#' 
#' \code{CreateSpatialNeighbours} accepts any paired relationships in a \code{data.frame}, as long as it contains the columns \code{Subject1Tag}, \code{Subject2Tag}, and \code{R}.  See \code{\link{Links79Pair}} for more details.
#' 
#' @return An S3 \code{spatial.neighbours} object to work with functions in the \pkg{spdep} package.  
#' \code{Subject1Tag} is renamed \code{from}. 
#' \code{Subject2Tag} is renamed \code{to}. 
#' \code{R} is renamed \code{weight}.
#' The attribute \code{region.id} specifies each unique SubjectTag.
#' The attribue \code{n} specifies the number of unique subjects.
#' 
#' @references Bivand, R., Pebesma, E., & Gomez-Rubio, V. (2008). \emph{Applied Spatial Data Analysis with R.} New York: Springer. (Especially Chapter 9.)
#' ##David, can you please give me some of the articles/books that you used this with?
#' @author Will Beasley  David Bard
#' @note Notice the British variant of 'neighbo\emph{u}rs'
#' @examples
#' ##Need something here
#' @keywords spatial analysis
#' 
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
