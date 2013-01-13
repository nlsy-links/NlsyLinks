\name{ReadCsvNlsy79}
\alias{ReadCsvNlsy79}
\alias{ReadCsvNlsy79Gen2}
\title{Read a CSV file downloaded from the NLS Investigator}
\usage{
  ReadCsvNlsy79Gen2(filePath)
}
\arguments{
  \item{filePath}{A path to the CSV file. Remember to use
  double back-slashes in Windows, or forward-slashes in
  Windows or *nix.}
}
\value{
  A \code{data.frame} to facililate biometric analysis.
}
\description{
  The function accepts a (file path to) CSV file and
  creates a \code{data.frame}.  The \code{data.frame} is
  modified and augmented with columns to assist later
  routines.
}
\details{
  The function does seven things. \enumerate{ \item Reads
  the CSV into a \code{data.frame}.  \item Checks that the
  NLSY variables \code{C00001.00} and \code{C00002.00}
  exist in the \code{data.frame}.  \item The NLSY variable
  \code{C00001.00} is renamed \code{SubjectID}.  \item A
  variable named \code{Generation} is given a value of 2
  for all subjects.  \item The \code{SubjectTag} variable
  is created.  \item The NLSY variable \code{C00002.00} is
  multiplied by 100 and renamed \code{SubjectTagOfMother}.
  \item The NLSY variable \code{R00001.49} (ie, their
  Mother's \code{HHID} is attached to each Gen2 record). }
}
\examples{
\dontrun{
filePathGen2 <- "F:/Projects/RDev/NlsyLinksStaging/Datasets/Gen2Birth.csv"
ds <- ReadCsvNlsy79Gen2(filePath=filePathGen2)
}
}
\author{
  Will Beasley
}

