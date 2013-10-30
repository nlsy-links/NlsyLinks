\name{AceLavaanGroup}
\alias{AceLavaanGroup}
\title{A simple multiple-group ACE model with the \pkg{lavaan} package.}
\usage{
  AceLavaanGroup(dsClean, estimateA=TRUE, estimateC=TRUE,
    printOutput=FALSE)
}
\arguments{
  \item{dsClean}{The \code{data.frame} containing complete
  cases for the \code{R} groups to be included in the
  estimation.}

  \item{estimateA}{Should the \emph{A} variance component
  be estimated?  A^2 represents the proportion of
  variability due to a shared genetic influence.}

  \item{estimateC}{Should the \emph{C} variance component
  be estimated?  C^2 represents the proportion of
  variability due to a shared environmental influence.}

  \item{printOutput}{Indicates if the estimated parameters
  and fit statistics are printed to the console.}
}
\value{
  An \code{AceEstimate} object.
}
\description{
  This function uses the \pkg{lavaan} package to estimate a
  univariate ACE model, using multiple groups.  Each group
  has a unique value of \code{R} (i.e., the
  \emph{R}elatedness coefficient).
}
\details{
  The variance component for \emph{E} is always estimated.
}
\note{
  Currently, the variables in \code{dsClean} must be named
  \code{M1}, \code{M2} and \code{R}.  This may not be as
  restrictive as it initially seems, because \code{dsClean}
  is intented to be produced by \code{CleanSemAceDataset}.
  If this is too restrictive for your uses, we'd like to
  here about it (\emph{please email wibeasley at hotmail
  period com}).
}
\examples{
library(NlsyLinks) #Load the package into the current R session.
dsLinks <- Links79PairExpanded #Start with the built-in data.frame in NlsyLinks
dsLinks <- dsLinks[dsLinks$RelationshipPath=='Gen2Siblings', ] #Use only Gen2 Siblings (NLSY79-C)

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
\author{
  Will Beasley
}
\references{
  The \pkg{lavaan} package is developed by Yves Rosseel at
  Ghent University.  Two good starting points are the
  documentation
  (\url{http://cran.r-project.org/web/packages/lavaan/})
  and his upcoming JSS paper
  (\url{http://users.ugent.be/~yrosseel/lavaan/lavaanJSSpreview.pdf}).
}
\seealso{
  Further ACE model details are discussed in our package's
  vignette (in the console, type
  \code{vignette("NlsyAce")}).
}
\keyword{ACE}

