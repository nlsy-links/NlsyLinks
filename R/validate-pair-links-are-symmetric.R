#' @name ValidatePairLinksAreSymmetric
#'
#' @export
#' @title Verifies that the pair relationships are symmetric.
#' @description Validates that the `linksPair` data frame is symmetric.
#' In a symmetric `linksPair`, each row has a corresponding row with reversed SubjectTag_S1 and SubjectTag_S2,
#' but the same `R` value.
#' For certain analyses (like types of DF methods and some
#' spatially-inspired methods), the pairs links (which can be considered a type of
#' sparse matrix) need to be symmetric. For example, if Subject 201 is related to
#' Subject 202 with a value of `R=0.5`, then there must be
#' a reciprocal row where Subject 202 is related to Subject 201 with `R=0.5`.
#'
#'
#' @param linksPair A [base::data.frame] containing the pair relationships that should be symmetric
#' @return Returns `TRUE` if symmetric.  Throw an error with [base::stop()] if asymmetric.
#'
#' @seealso [CreatePairLinksDoubleEntered()]
#' @author Will Beasley
#' @keywords validation
#'
#' @examples
#' dsSingleLinks <- data.frame(
#'   ExtendedID       = c(1, 1, 1, 2),
#'   SubjectTag_S1    = c(101, 101, 102, 201),
#'   SubjectTag_S2    = c(102, 103, 103, 202),
#'   R                = c(.5, .25, .25, .5),
#'   RelationshipPath = rep("Gen2Siblings", 4)
#' )
#' dsSingleOutcomes <- data.frame(
#'   SubjectTag = c(101, 102, 103, 201, 202),
#'   DV1        = c(11, 12, 13, 41, 42),
#'   DV2        = c(21, 22, 23, 51, 52)
#' )
#' dsDouble <- CreatePairLinksDoubleEntered(
#'   outcomeDataset         = dsSingleOutcomes,
#'   linksPairDataset       = dsSingleLinks,
#'   outcomeNames           = c("DV1", "DV2"),
#'   validateOutcomeDataset = TRUE
#' )
#' dsDouble # Show the 8 rows in the double-entered pair links
#' summary(dsDouble) # Summarize the variables
#'
#' ValidatePairLinksAreSymmetric(dsDouble) # Should return TRUE.
#'
ValidatePairLinksAreSymmetric <- function(linksPair) {
  # Preliminary validation of the linksPair data frame
  ValidatePairLinks(linksPair)

  # Loop through each row to validate symmetry
  for (rowIndex in base::seq_len(base::nrow(linksPair))) {
    # Extract the 'R' value for the current row
    r <- linksPair$R[rowIndex]

    # Proceed only if 'R' is not NA
    if (!is.na(r)) {
      # Extract other fields for the current row
      tag1 <- linksPair$SubjectTag_S1[rowIndex]
      tag2 <- linksPair$SubjectTag_S2[rowIndex]
      path <- linksPair$RelationshipPath[rowIndex]

      # Check if an opposite pair exists with the same 'R' value
      oppositeCount <- base::nrow(linksPair[linksPair$SubjectTag_S1 == tag2 & linksPair$SubjectTag_S2 == tag1 & linksPair$R == r & linksPair$RelationshipPath == path, ])
      # oppositeCount <- base::nrow(subset(linksPair, SubjectTag_S1==tag2 & SubjectTag_S2==tag1 & R==r & RelationshipPath==path))

      # If opposite pair doesn't exist or exists more than once, throw an error
      if (oppositeCount != 1) {
        base::stop(paste0(
          "The 'linksPair' dataset doesn't appear to be double-entered & symmetric.  The reciprocal of (SubjectTag_S1, SubjectTag_S2, R)=(",
          tag1, ", ", tag2, ", ", r, ") was found ", oppositeCount, " time(s)."
        ))
      }
    }
  }
  # Return TRUE if all pairs are symmetric
  return(TRUE)
}
