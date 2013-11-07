#' @name CreateSpatialNeighbours79Gen2
#' @export
#' 
#' @usage CreateSpatialNeighbours79Gen2()
#' @title  Automatically creates dataset of NLSY79 Gen2 subjects (i.e., the children of the mothers in the initial NLSY79 sample).
#' @description \code{CreateSpatialNeighbours79Gen2} automatically creates dataset of NLSY79 Gen2 subjects (i.e., the children of the mothers in the initial NLSY79 sample).  
#' 
#' For more information, please see \code{\link{CreateSpatialNeighbours}}
#' 
CreateSpatialNeighbours79Gen2 <-
function( )  {
  return( CreateSpatialNeighbours(Links79Pair) )
}
