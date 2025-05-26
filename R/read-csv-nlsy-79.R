#' @name ReadCsvNlsy79
#'
#' @aliases ReadCsvNlsy79Gen1 ReadCsvNlsy79Gen2
#'
#' @export ReadCsvNlsy79Gen1 ReadCsvNlsy79Gen2
#'
#' @title Read a CSV file downloaded from the NLS Investigator
#'
#' @description The function accepts a (file path to) CSV file and creates a [base::data.frame].  The [base::data.frame] is modified and augmented with columns to assist later routines.
#'
#' @param filePath A path to the CSV file. Remember to use double back-slashes in Windows, or forward-slashes in Windows or Linux.
#' @param dsExtract A 'data.frame' (containing the extract) can be passed instead of the file path if the data has already been read into R's memory.
#'
#' @return A [base::data.frame] to facilitate biometric analysis.
#'
#' @details The function does seven things.
#' 1. Reads the CSV into a [base::data.frame].
#' 1. Checks that the NLSY variables `C00001.00` and `C00002.00` exist in the [base::data.frame].
#' 1. The NLSY variable `C00001.00` is renamed `SubjectID`.
#' 1. A variable named `Generation` is given a value of 2 for all subjects.
#' 1. The `SubjectTag` variable is created.
#' 1. The NLSY variable `C00002.00` is multiplied by 100 and renamed `SubjectTagOfMother`.
#' 1. The NLSY variable `R00001.49` (ie, their Mother's `HHID` is attached to each Gen2 record).
#'
#' @author Will Beasley
#'
#' @examples
#' \dontrun{
#' filePathGen2 <- "~/Nlsy/Datasets/gen2-birth.csv"
#' ds <- ReadCsvNlsy79Gen2(filePath = filePathGen2)
#' }
ReadCsvNlsy79Gen1 <- function(filePath = NULL,
                              dsExtract = NULL) {
  if (is.null(dsExtract)) {
    if (is.null(filePath)) {
      stop("Either 'filePath' or 'dsExtract' must be provided.")
    }
    dsExtract <- utils::read.csv(filePath)
  }

  d <- NlsyLinks::SubjectDetails79
  if (!("R0000100" %in%
    colnames(dsExtract))) {
    stop("The NLSY variable 'R0000100' should be present, but was not found.")
  }

  colnames(dsExtract)[colnames(dsExtract) == "R0000100"] <-
    "SubjectID"
  dsExtract$Generation <- 1
  dsExtract$SubjectTag <-
    CreateSubjectTag(dsExtract$SubjectID, dsExtract$Generation)

  dsWithExtended <-
    d[d$Generation == 1, c("SubjectTag", "ExtendedID")]
  ds <-
    merge(
      x = dsExtract,
      y = dsWithExtended,
      by = "SubjectTag",
      all.x = TRUE,
      all.y = FALSE
    )

  firstColumns <-
    c("SubjectTag", "SubjectID", "ExtendedID", "Generation")
  remaining <- setdiff(colnames(ds), firstColumns)
  ds <- ds[, c(firstColumns, remaining)]

  return(ds)
}
ReadCsvNlsy79Gen2 <- function(filePath = NULL,
                              dsExtract = NULL) {
  if (is.null(dsExtract)) {
    if (is.null(filePath)) {
      stop("Either 'filePath' or 'dsExtract' must be provided.")
    }
    dsExtract <- utils::read.csv(filePath)
  }
  d <- NlsyLinks::SubjectDetails79
  #   dsExtract <- read.csv(filePath)
  if (!("C0000100" %in% colnames(dsExtract))) {
    stop("The NLSY variable 'C0000100' should be present, but was not found.")
  }
  if (!("C0000200" %in% colnames(dsExtract))) {
    stop("The NLSY variable 'C0000200' should be present, but was not found.")
  }

  colnames(dsExtract)[colnames(dsExtract) == "C0000100"] <-
    "SubjectID"
  colnames(dsExtract)[colnames(dsExtract) == "C0000200"] <-
    "SubjectTagOfMother"
  dsExtract$SubjectTagOfMother <- dsExtract$SubjectTagOfMother * 100
  dsExtract$Generation <- 2
  dsExtract$SubjectTag <-
    dsExtract$SubjectID # CreateSubjectTag(dsExtract$SubjectID, dsExtract$Generation)

  dsWithExtended <-
    d[d$Generation == 2, c("SubjectTag", "ExtendedID")]
  ds <-
    merge(
      x = dsExtract,
      y = dsWithExtended,
      by = "SubjectTag",
      all.x = TRUE,
      all.y = FALSE
    )

  firstColumns <-
    c("SubjectTag", "SubjectID", "ExtendedID", "Generation")
  remaining <- setdiff(colnames(ds), firstColumns)
  ds <- ds[, c(firstColumns, remaining)]

  return(ds)
}
