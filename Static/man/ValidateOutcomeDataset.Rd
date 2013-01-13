\name{ValidateOutcomeDataset}
\alias{ValidateOutcomeDataset}
\title{
Validates the schema of datasets containing outcome variables.
}
\description{
The \pkg{NlsyLinks} handles a lot of the plumbing code needed to transform extracted NLSY datasets into a format that statistical routines can interpret.  In some cases, a dataset of measured variables is needed, with one row per subject.  This function validates the measured/outcome dataset, to ensure it posses an interpretable schema.  For a specific list of the requirements, see \code{Details} below.
}
\usage{
ValidateOutcomeDataset(dsOutcome, outcomeNames)
}
\arguments{
  \item{dsOutcome}{A data frame with the measured variables}
  \item{outcomeNames}{The column names of the measure variables that eventually will be used by a statistical procedure.}
}
\details{
The \code{dsOutcome} parameter must:
1) Have a non-missing value.
2) Contain at least one row.
3) Contain a column called 'SubjectTag' (case sensitive).
4) Have the SubjectTag column containing only positive numbers.
5) Have the SubjectTag column where all values are unique (ie, two rows/subjects cannot have the same value).


The \code{outcomeNames} parameter must:
1) Have a non-missing value
2) Contain only column names that are present in the \code{dsOutcome} data frame.
}
\value{
Returns \code{TRUE} if the validation passes.
Returns an error (and associated descriptive message) if it false.
}
%\references{
%% ~put references to the literature/web site here ~
%}

%\note{
%%  ~~further notes~~
%}

%\seealso{
%% ~~objects to See Also as \code{\link{help}}, ~~~
%\code{\link{CreatePairLinks}}
%}
\author{
Will Beasley
}
\examples{
library(NlsyLinks) #Load the package into the current R session.
ds <- ExtraOutcomes79
outcomeNames <- c("MathStandardized", "WeightZGenderAge")
ValidateOutcomeDataset(dsOutcome=ds, outcomeNames=outcomeNames) #Returns TRUE.

outcomeNamesBad <- c("MathMisspelled", "WeightZGenderAge")
#ValidateOutcomeDataset(dsOutcome=ds, outcomeNames=outcomeNamesBad) #Throws error.
}

\keyword{ validation }

