\name{ReadCsvNlsy79}
\alias{ReadCsvNlsy79Gen2}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
Read a CSV file downloaded from the NLS Investigator
}
\description{
The function accepts a (file path to) CSV file and creates a \code{data.frame}.  The \code{data.frame} is modified and augmented with columns to assist later routines.
}
\usage{
ReadCsvNlsy79Gen2(filePath)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{filePath}{A path to the CSV file. Remember to use double back-slashes in Windows, or forward slashes in Windows or *nix.}
}
\details{
The function does seven things.
1) Reads the CSV into a \code{data.frame}.
2) Checks that the NLSY variables \code{C00001.00} and \code{C00002.00} exist in the \code{data.frame}.
3) The NLSY variable \code{C00001.00} is renamed \code{SubjectID}.
4) A variable named \code{Generation} is given a value of 2 for all subjects.
5) The \code{SubjectTag} variable is created.
6) The NLSY variable \code{C00002.00} is multiplied by 100 and renamed \code{SubjectTagOfMother}.
7) The NLSY variable \code{R00001.49} (ie, their Mother's \code{HHID} is attached to each Gen2 record).

}
%\value{
%%  If it is a LIST, use
%%  \item{comp1 }{Description of 'comp1'}
%}
%\references{
%% ~put references to the literature/web site here ~
%}
%\note{
%%  ~~further notes~~
%}
%\seealso{
%% ~~objects to See Also as \code{\link{help}}, ~~~
%}
\author{
Will Beasley
}
\examples{
## Not run:
#filePathGen2 <- "F:/Projects/RDev/NlsyLinksStaging/Datasets/Gen2Birth.csv"
#ds <- ReadCsvNlsy79Gen2(filePath=filePathGen2)
## End(Not run)
}

