\name{ColumnUtilities}
\alias{VerifyColumnExists}
\alias{RenameColumn}
\alias{RenameNlsyColumn}

\title{
A collection of functions that helps data management \code{data.frame}s, particularly those derived from NLS Extracts.
}
\description{
A collection of functions that helps data management \code{data.frame}s, particularly those derived from NLS Extracts.
}
\usage{
VerifyColumnExists( dataFrame, columnName )

RenameColumn( dataFrame, oldColumnName, newColumnName )

RenameNlsyColumn( dataFrame, nlsyRNumber, newColumnName )
}

\arguments{
  \item{dataFrame}{A \code{data.frame} object whose columns are to be verified or renamed.}
  \item{columnName}{The name of the column to verify is present in the \code{data.frame}.}
  \item{nlsyRNumber}{The name of the column to change. }
  \item{oldColumnName}{The name of the column to change. }
  \item{newColumnName}{The desired name of the column.}
}
\details{
The RNumber assigned by the NLS has a pattern.  In the Nlsy79 Gen1 dataset, the names start with a `R' or `T' and are followed by seven digits (eg, R0000100).  In the Nlsy79 Gen2 dataset, the names start with `C' or `Y' and are followed by seven digits (eg, C0007030, Y1994600).


In the NLS Investigator, a decimal is present in the RNumber (eg, R00001.00).  When the Investigator saves the dataset as a CSV, the decimal is removed (R0000100).
}
\value{
*IMPORTANT* The \code{RenameColumn} and \code{RenameNlsyColumn} functions do not use side-effects to rename the \code{data.frame}.  Instead, it returns a new \code{data.frame}.  In the example below, notice the assignment to \code{ds}: \code{ds <- RenameNlsyColumn(...)}.


The \code{VerifyColumnExists} function check that exactly one column exists with the specified \code{columnName}.  If so, the index of the column is returned.  If not, an exception is thrown.
}
%\references{
%% ~put references to the literature/web site here ~
%}
\author{
Will Beasley
}
%\note{
%%  ~~further notes~~
%}

%\seealso{
%\code{\link{Links79Pair}}
%}
\examples{
filePathGen2 <- file.path(path.package("NlsyLinks"), "extdata", "Gen2Birth.csv") #"F:/Projects/RDev/NlsyLinksStaging/Datasets/Gen2Birth.csv"
ds <- read.csv(filePathGen2)

originalColumNames <- c("C0000100", "C0000200", "C0005300", "C0005400", 
  "C0005700", "C0328000", "C0328600", "C0328800")

newColumnNames <- c("SubjectID", "MotherID", "Race", "Gender", "Yob", 
  "GestationWeeks", "BirthWeightInOunces", "BirthLengthInInches")

for( columnIndex in seq_along(originalColumNames) ) {
  ds <- RenameNlsyColumn(ds, originalColumNames[columnIndex], newColumnNames[columnIndex])
}


}


