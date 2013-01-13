\name{Ace}
\alias{AceUnivariate}
\alias{DeFriesFulkerMethod1}
\alias{DeFriesFulkerMethod3}

\title{
Estimates the heritability of additive traits using a single variable.
}
\description{
An ACE model is the foundation of most Behavior Genetic research.  It estimates the additive heritability (with \emph{a}), common environment (with \emph{c}) and unshared heritability/environment (with \emph{e}).
}
\usage{
AceUnivariate(method=c("DeFriesFulkerMethod1","DeFriesFulkerMethod3"), dataSet, oName_1, oName_2, 
  rName="R", manifestScale="Continuous")
  
DeFriesFulkerMethod1(dataSet, oName_1, oName_2, rName="R")

DeFriesFulkerMethod3(dataSet, oName_1, oName_2, rName="R")
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{method}{The specific estimation technique.}
  \item{dataSet}{The \code{data.frame} that contains the two outcome variables and the relatedness coefficient (corresponding to \code{oName_1}, \code{oName_2}, and \code{rName})}.
  \item{oName_1}{The name of the outcome variable corresponding to the first subject in the pair. This should be a \code{character} value.}
  \item{oName_2}{The name of theoutcome variable corresponding to the second subject in the pair. This should be a \code{character} value. }
  \item{rName}{The name of the relatedness coefficient for the pair (this is typically abbreviated as \code{R}). This should be a \code{character} value.}
  \item{manifestScale}{Currently, only continuous manifest/outcome variables are supported.}
}
\details{
The \code{AceUnivariate} function is a wrapper that calls \code{DeFriesFulkerMethod1} or \code{DeFriesFulkerMethod3}.  Future versions will incorporate methods that use latent variable models.
}
\value{
Currently, a list is returned with the arguments \code{HSquared}, \code{CSquared}, \code{ESquared}, and \code{RowCount}.  In the future, this may be changed to an \code{S4} class.
}
\references{
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
library(NlsyLinks) #Load the package into the current R session.
dsOutcomes <- ExtraOutcomes79
dsOutcomes$SubjectTag <- CreateSubjectTag(subjectID=dsOutcomes$SubjectID,
  generation=dsOutcomes$Generation)
dsLinks <- Links79Pair
dsLinks <- dsLinks[dsLinks$RelationshipPath=='Gen2Siblings', ] #Use only the Gen2 Siblings (ie, NLSY79-C subjects)
dsDF <- CreatePairLinksDoubleEntered(outcomeDataset=dsOutcomes, linksPairDataset=dsLinks, 
  outcomeNames=c("MathStandardized", "HeightZGenderAge", "WeightZGenderAge"))

estimatedAdultHeight <- DeFriesFulkerMethod3(
  dataSet=dsDF,    
  oName_1="HeightZGenderAge_1", 
  oName_2="HeightZGenderAge_2")  
estimatedAdultHeight #ASquared and CSquared should be 0.606 and 0.105 for this rough analysis.

estimatedMath <- DeFriesFulkerMethod3(
  dataSet=dsDF,    
  oName_1="MathStandardized_1", 
  oName_2="MathStandardized_2")
estimatedMath #ASquared and CSquared should be 0.878 and 0.048.

class(GetDetails(estimatedMath))
summary(GetDetails(estimatedMath))

}
