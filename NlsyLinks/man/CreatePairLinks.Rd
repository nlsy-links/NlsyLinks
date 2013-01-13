\name{CreatePairLinks}
\alias{CreatePairLinksSingleEntered}
\alias{CreatePairLinksDoubleEntered}
\alias{CreatePairLinksDoubleEnteredWithNoOutcomes}

\title{ Creates a pairs linking file. }
\description{ Creates a linking file for BG designs using this file structure (e.g., DF analysis, other ACE modeling).}
\usage{
CreatePairLinksDoubleEntered(outcomeDataset, linksPairDataset, outcomeNames, 
  linksNames = c("ExtendedID", "R", "RelationshipPath"), validateOutcomeDataset=TRUE)

CreatePairLinksSingleEntered(outcomeDataset, linksPairDataset, outcomeNames, 
  linksNames = c("ExtendedID", "R", "RelationshipPath"), validateOutcomeDataset=TRUE)

CreatePairLinksDoubleEnteredWithNoOutcomes(linksPairDataset, 
  linksNames = c("ExtendedID", "R", "RelationshipPath"))
}

\arguments{
  \item{outcomeDataset}{ A data frame containing the outcome variable(s) }
  \item{linksPairDataset}{ A data frame containing the \code{SubjectTag}s of each subject in the pair and their \code{R} coefficient.}
  \item{outcomeNames}{ The column names of the outcome variable(s)}
  \item{linksNames}{ The column names desired to be prseent in the newly created data frame.  \code{Subject1Tag} and \code{Subject2Tag} are included automatically.}
  \item{validateOutcomeDataset}{ Indicates if characteristics of the outcomeDataset should be validated.}
}
\details{

A DF analysis requires a double-entered file that contains the \code{R} value for the pair, and their two outcome variable values.

\code{CreatePairLinksDoubleEnteredWithNoOutcomes} is intended to be a primarily a helper function for \code{\link{CreateSpatialNeighbours}}.
}
%\value{
%%  ~Describe the value returned
%%  If it is a LIST, use
%%  \item{comp1 }{Description of 'comp1'}
%%  \item{comp2 }{Description of 'comp2'}
%% ...
%}
\references{
For more information about a DF analysis, see:
Rodgers, Joseph Lee, & Kohler, Hans-Peter (2005).  Reformulating and simplifying the DF analysis model.  \href{http://www.springerlink.com/content/n3x1v1q282583366/}{\emph{Behavior Genetics, 35} (2), 211-217}.
}
\author{
Will Beasley
}
%\note{
%%  ~~further notes~~
%}

%% ~Make other sections like Warning with \section{Warning }{....} ~

%\seealso{
%% ~~objects to See Also as \code{\link{help}}, ~~~
%}
\examples{
dsSingleLinks <- data.frame(
  ExtendedID=c(1, 1, 1, 2), 
  Subject1Tag=c(101, 101, 102, 201), 
  Subject2Tag=c(102, 103, 103, 202), 
  R=c(.5, .25, .25, .5), 
  RelationshipPath=rep("Gen2Siblings", 4)
)
dsSingleOutcomes <- data.frame(
  SubjectTag=c(101, 102, 103, 201, 202), 
  DV1=c(11, 12, 13, 41, 42), 
  DV2=c(21, 22, 23, 51, 52))
dsDouble <- CreatePairLinksDoubleEntered(
  outcomeDataset=dsSingleOutcomes, 
  linksPairDataset=dsSingleLinks, 
  outcomeNames=c("DV1", "DV2"), 
  validateOutcomeDataset=TRUE)
dsDouble #Show the 8 rows in the double-entered pair links
summary(dsDouble) #Summarize the variables

ValidatePairLinksAreSymmetric(dsDouble) #Should return TRUE.
}

