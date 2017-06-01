#' @name CreateSpatialNeighbours
#' @export
#'
#' @title Distances between related family members, formated for spatial analysis.
#' @description This helper function formats the LinksPair datasets so it can be used in some types of spatial analyses. The \pkg{spdep} (Spatial Dependence) uses a sparse matrix (actually a [base::data.frame()]) to represent neigbours.
#' @usage  CreateSpatialNeighbours(linksPairsDoubleEntered)
## CreateSpatialNeighbours79Gen2()
#' @param linksPairsDoubleEntered A [base::data.frame()] containing the links, preferably created by a function like
#'
#' [CreatePairLinksDoubleEntered()].
#'
#' @details There is one row per unique pair of subjects, *respecting order*.  This has twice as many rows as [Links79Pair()] and [Links79PairExpanded()] (which have one row per unique pair of subjects, *irrespective of order*).
#'
#' [CreateSpatialNeighbours()] accepts any paired relationships in a [base::data.frame()], as long as it contains the columns `SubjectTag_S1`, `SubjectTag_S2`, and `R`.  See [Links79Pair()] for more details about these columns.
#'
#' @return An S3 [spdep::spatial.neighbours] object to work with functions in the \pkg{spdep} package.
#'
#' `SubjectTag_S1` is renamed '`from`'.
#'
#' `SubjectTag_S2` is renamed '`to`'.
#'
#' `R` is renamed '`weight`'.
#'
#' The attribute `region.id` specifies each unique SubjectTag.
#'
#' The attribue `n` specifies the number of unique subjects.
#'
#' @references
#'
#' Bard, D.E., Beasley, W.H., Meredith, K., & Rodgers, J.L. (2012). [*Biometric Analysis of Complex NLSY Pedigrees: Introducing a Conditional Autoregressive Biometric (CARB) Mixed Model*](http://link.springer.com/article/10.1007/s10519-012-9566-6). Behavior Genetics Association 42nd Annual Meeting. [[Slides](https://r-forge.r-project.org/forum/forum.php?thread_id=4761&forum_id=4266&group_id=1330)]
#'
#' Bivand, R., Pebesma, E., & Gomez-Rubio, V. (2013). [*Applied Spatial Data Analysis with R.*](http://link.springer.com/book/10.1007/978-1-4614-7618-4) New York: Springer. (Especially Chapter 9.)
#'
#' Banerjee, S., Carlin, B.P., & Gelfand, A.E. (2004). [*Hierarchical Modeling and Analysis for Spatial Data*](http://books.google.com/books/about/Hierarchical_Modeling_and_Analysis_for_S.html?id=YqpZKTp-Wh0C). Boca Raton: CRC Press.
#'
#' Lawson, A.B (2013). [*Bayesian Disease Mapping: Hierarchical Modeling in Spatial Epidemiology, Second Edition*](http://books.google.com/books?id=g7RJEZb1umwC). Boca Raton: CRC Press.
#'
#' The \pkg{spdep} package documentation: [spdep: Spatial dependence: weighting schemes, statistics and models](https://cran.r-project.org/package=spdep).
#'
#' @author Will Beasley and  David Bard
#' @note Notice the British variant of 'neighbo*u*rs' is used, to be consistent with the [spdep::spatial.neighbour] class.
#' @examples
#' dsLinksAll <- Links79Pair
#' dsLinksGen1Housemates <- dsLinksAll[dsLinksAll$RelationshipPath=="Gen1Housemates", ]
#' dsLinksGen2Siblings <- dsLinksAll[dsLinksAll$RelationshipPath=="Gen2Siblings", ]
#'
#' spGen1 <- CreateSpatialNeighbours(dsLinksGen1Housemates)
#' spGen2 <- CreateSpatialNeighbours(dsLinksGen2Siblings)
#'
#' head(spGen2)
#' #Returns:
#' #   from  to weight
#' #3   201 202   0.50
#' #6   301 302   0.50
#' #7   301 303   0.50
#' #9   302 303   0.50
#' #24  401 403   0.25
#' #28  801 802   0.50
#'
#' table(spGen2$weight)
#' #Returns:
#' #0.25 0.375   0.5  0.75     1
#' #3442   610  6997    12    27
#' @keywords spatial analysis
#'
CreateSpatialNeighbours <- function( linksPairsDoubleEntered )  {
  ValidatePairLinks(linksPairsDoubleEntered)

  ds <- base::subset(linksPairsDoubleEntered, select=c("SubjectTag_S1", "SubjectTag_S2", "R"))
  base::colnames(ds)[base::colnames(ds) == "SubjectTag_S1"] <- "from"
  base::colnames(ds)[base::colnames(ds) == "SubjectTag_S2"] <- "to"
  base::colnames(ds)[base::colnames(ds) == "R"] <- "weight"
  # summary(ds)

  base::class(ds) <- c("spatial.neighbour", base::class(ds))
  base::attr(ds, "region.id") <- base::unique(ds$from)
  base::attr(ds, "n") <- base::length(base::unique(ds$from))
  return( ds )
}
