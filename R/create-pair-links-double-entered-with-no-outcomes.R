# Roxygen comments in CreatePairLinks file.


#' @rdname CreatePairLinks
#' @export CreatePairLinksDoubleEnteredWithNoOutcomes
#' @title Creates a pairs linking file without outcomes.
#' @description Creates a linking file for BG designs using this file structure (e.g., DF analysis, other ACE modeling).
#' DF analysis requires a double-entered file that contains the `R`
#' value for the pair, and their two outcome variable values.
#' [CreatePairLinksDoubleEnteredWithNoOutcomes()] is intended to be a
#' primarily a helper function for [CreateSpatialNeighbours()].



CreatePairLinksDoubleEnteredWithNoOutcomes <- function(linksPairDataset, linksNames = c("ExtendedID", "R", "RelationshipPath")) {
  ValidatePairLinks(linksPairDataset)

  dsLinksLeftHand <- base::subset(linksPairDataset, select = c("SubjectTag_S1", "SubjectTag_S2", linksNames)) #' Lefthand' is my slang for Subjec1Tag is less than the SubjectTag_S2
  dsLinksRightHand <- base::subset(linksPairDataset, select = c("SubjectTag_S2", "SubjectTag_S1", linksNames))

  base::colnames(dsLinksRightHand)[colnames(dsLinksRightHand) == "SubjectTag_S1"] <- "SubjectTempTag"
  base::colnames(dsLinksRightHand)[colnames(dsLinksRightHand) == "SubjectTag_S2"] <- "SubjectTag_S1"
  base::colnames(dsLinksRightHand)[colnames(dsLinksRightHand) == "SubjectTempTag"] <- "SubjectTag_S2"

  ds <- base::rbind(dsLinksLeftHand, dsLinksRightHand) #' RowBind' the two datasets
  ds <- ds[, c("SubjectTag_S1", "SubjectTag_S2", linksNames)]
  base::rm(dsLinksLeftHand, dsLinksRightHand)
  return(ds)
}
