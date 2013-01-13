\name{AceLavaanGroup}
\alias{AceLavaanGroup}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
A simple multiple-group ACE model with the \pkg{lavaan} package.
}
\description{
This function uses the \pkg{lavaan} package to estimate a univariate ACE model, using multiple groups.  Each group has a unique value of \code{R} (i.e., the \emph{R}elatedness coefficient).
}
\usage{
AceLavaanGroup(dsClean, estimateA=TRUE, estimateC=TRUE, printOutput=FALSE)
%AceLavaanGroup(dsClean, rLevels, oName_1, oName_2, rName="R", 
%  estimateA=TRUE, estimateC=TRUE, printOutput=FALSE)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{dsClean}{The \code{data.frame} containing complete cases for the \code{R} groups to be included in the estimation.}
%  \item{rLevels}{The values of \code{R} forming each group.}
%  \item{oName_1}{The name of the manifest variable for the \emph{first} subject in each pair.}
%  \item{oName_2}{The name of the manifest variable for the \emph{second} subject in each pair.}
%  \item{rName}{The name of the variable containing the \code{R} value.}
  \item{estimateA}{Should the \emph{A} variance component be estimated?  A^2 represents the proportion of variability due to a shared genetic influence.}
  \item{estimateC}{Should the \emph{C} variance component be estimated?  C^2 represents the proportion of variability due to a shared environmental influence.}
  \item{printOutput}{Indicates if the estimated parameters and fit statistics are printed to the console.}
}
\details{
The variance component for \emph{E} is always estimated.

}
\value{
An \code{AceEstimate} object.
}
\references{
The \pkg{lavaan} package is developed by Yves Rosseel at Ghent University.  Two good starting points are the documentation (\url{http://cran.r-project.org/web/packages/lavaan/}) and his upcoming JSS paper (\url{http://users.ugent.be/~yrosseel/lavaan/lavaanJSSpreview.pdf}).
}
\author{
Will Beasley
}
\note{
Currently, the variables in \code{dsClean} must be named \code{M1}, \code{M2} and \code{R}.  This may not be as restrictive as it initially seems, because \code{dsClean} is intented to be produced by \code{CleanSemAceDataset}.  If this is too restrictive for your uses, we'd like to here about it (\emph{please email wibeasley at hotmail period com}).
}


\seealso{
Further ACE model details are discussed in our package's vignette (in the console, type \code{vignette("NlsyAce")}).
}
\examples{
library(NlsyLinks) #Load the package into the current R session.
dsLinks <- Links79PairExpanded #Start with the built-in data.frame in NlsyLinks
dsLinks <- dsLinks[dsLinks$RelationshipPath=='Gen2Siblings', ] #Use only the Gen2 Siblings (ie, NLSY79-C subjects)

oName_1 <- "MathStandardized_1" #Stands for Outcome1
oName_2 <- "MathStandardized_2" #Stands for Outcome2

dsGroupSummary <- RGroupSummary(dsLinks, oName_1, oName_2)
dsClean <- CleanSemAceDataset(dsDirty=dsLinks, dsGroupSummary, oName_1, oName_2)

ace <- AceLavaanGroup(dsClean)
ace

#Should produce:
# [1] "Results of ACE estimation: [show]"
#     ASquared     CSquared     ESquared    CaseCount 
#    0.6681874    0.1181227    0.2136900 8390.0000000 

library(lavaan) #Load the package to access methods of the lavaan class.
GetDetails(ace)

#Exmaine fit stats like Chi-Squared, RMSEA, CFI, etc.
fitMeasures(GetDetails(ace)) #The function 'fitMeasures' is defined in the lavaan package.

#Examine low-level details like each group's individual parameter estimates and standard errors.
summary(GetDetails(ace))

#Extract low-level details. This may be useful when programming simulations.
inspect(GetDetails(ace), what="converged") #The lavaan package defines 'inspect'.
inspect(GetDetails(ace), what="coef")
}
\keyword{ ACE }

