#' @name ReadCsvNlsy79
#' @aliases ReadCsvNlsy79 ReadCsvNlsy79Gen2
#' @export ReadCsvNlsy79Gen2
#' 
#' @title Read a CSV file downloaded from the NLS Investigator
#' @description The function accepts a (file path to) CSV file and creates a \code{data.frame}.  The \code{data.frame} is modified and augmented with columns to assist later routines.
#' @usage ReadCsvNlsy79Gen2(filePath, dsExtract=read.csv(filePath) )

#' @param filePath A path to the CSV file. Remember to use double back-slashes in Windows, or forward-slashes in Windows or Linux.
#' @param dsExtract A `data.frame` (containing the extract) can be passed instead of the file path if the data has already been read into R's memory.
#' 
#' @return A \code{data.frame} to facililate biometric analysis.
#' 
#' @details The function does seven things.
#' \enumerate{
#'  \item Reads the CSV into a \code{data.frame}.
#'  \item Checks that the NLSY variables \code{C00001.00} and \code{C00002.00} exist in the \code{data.frame}.
#'  \item The NLSY variable \code{C00001.00} is renamed \code{SubjectID}.
#'  \item A variable named \code{Generation} is given a value of 2 for all subjects.
#'  \item The \code{SubjectTag} variable is created.
#'  \item The NLSY variable \code{C00002.00} is multiplied by 100 and renamed \code{SubjectTagOfMother}.
#'  \item The NLSY variable \code{R00001.49} (ie, their Mother's \code{HHID} is attached to each Gen2 record).
#' }
#' 
#' @author Will Beasley
#' @examples
#' \dontrun{
#' filePathGen2 <- "F:/Projects/RDev/NlsyLinksStaging/Datasets/Gen2Birth.csv"
#' ds <- ReadCsvNlsy79Gen2(filePath=filePathGen2)
#' }
#'
ReadCsvNlsy79Gen2 <- function( filePath, dsExtract=read.csv(filePath) ) {
#   dsExtract <- read.csv(filePath)
  if( !("C0000100" %in% colnames(dsExtract)) ) stop("The NLSY variable 'C0000100' should be present, but was not found.")
  if( !("C0000200" %in% colnames(dsExtract)) ) stop("The NLSY variable 'C0000200' should be present, but was not found.")
  
  colnames(dsExtract)[colnames(dsExtract)=='C0000100'] <- "SubjectID"
  colnames(dsExtract)[colnames(dsExtract)=='C0000200'] <- "SubjectTagOfMother"
  dsExtract$SubjectTagOfMother <- dsExtract$SubjectTagOfMother * 100
  dsExtract$Generation <- 2
  dsExtract$SubjectTag <- dsExtract$SubjectID #CreateSubjectTag(dsExtract$SubjectID, dsExtract$Generation)
  
#   data(SubjectDetails79)
  #dsWithExtended <- subset(SubjectDetails79, Generation==2, select=c("SubjectTag", "ExtendedID"))
  dsWithExtended <- SubjectDetails79[SubjectDetails79$Generation==2, c("SubjectTag", "ExtendedID")]
  #summary(dsWithExtended)
  ds <- merge(x=dsExtract, y=dsWithExtended, by="SubjectTag", all.x=TRUE, all.y=FALSE)
  
  firstColumns <- c("SubjectTag", "SubjectID", "ExtendedID", "Generation")
  remaining <- setdiff(colnames(ds), firstColumns)
  ds <- ds[, c(firstColumns, remaining)]
  
  return( ds )   
}
