\name{RGroupSummary}
\alias{RGroupSummary}
\title{Calculates summary statistics for each \emph{R}elatedness Group in the sample.}
\usage{
  RGroupSummary(ds, oName_1, oName_2, rName,
    determinantThreshold=1e-5)
}
\arguments{
  \item{ds}{The \code{data.frame} containing the following
  variables:}

  \item{oName_1}{The name of the outcome variable
  corresponding to the first subject in the pair.}

  \item{oName_2}{The name of the outcome variable
  corresponding to the first subject in the pair.}

  \item{rName}{The name of the variable specifying the
  pair's \code{Relatedness} coefficient.}

  \item{determinantThreshold}{The minimum value the
  covariance matrix's determinant (for the group) should
  exceed to be considered Positive Definite.}
}
\value{
  A \code{data.frame} with one row per group.  The
  \code{data.frame} contains the following variables:
  \item{ R }{The group's \code{R} value.  Note the name of
  this variable can be changed by the user, by specifying a
  non-default value to the \code{rName} argument.} \item{
  Included }{Indicates if the group should be included in a
  multiple-group SEM.} \item{ PairCount }{The number of
  pairs in the group with \emph{complete} data for \code{R}
  and the two outcome/manifest variables.} \item{
  O1Variance }{ The variance (of the outcome variable)
  among the group's first members. } \item{ O2Variance }{
  The variance (of the outcome variable) among the group's
  second members. } \item{ O1O2Covariance }{ The covariance
  (of the outcome variable) across the group's first and
  second members.} \item{ Correlation }{The correlation (of
  the outcome variable) across the group's first and second
  members.} \item{ Determinant }{ The determinant of the
  group's covariance matrix.} \item{ PosDefinite }{
  Indicates if the group's covariance matrix is positive
  definite.}
}
\description{
  Before and after running ACE Models, it is important to
  examine the characteristics of the different groups.
  When the ACE is estimated with an SEM using multiple
  groups, it is even even more important.  Groups may
  contain too few subjects to have a well-behaved
  covariance matrix.

  If a group's covariance matrix is not Positive Definite
  (or it's misbehaving in some other way), it's typically
  recommended to exclude that group from the SEM.
}
\details{
  This function doesn't specific to an ACE model and groups
  defined by \code{R}.  It could be applied to any
  multiple-group SEM with two manifest/outcome variables.
  In the future, we may generalize it beyond two manifest
  variables.

  To get summary stats for the entire sample, create a
  dummy indicator variable that assigns everyone to the
  same group.  See the second example below.

  The default determinantThreshold value is nonzero, in
  order to forgive slight numerical inaccuracies caused by
  fixed-precision arithmetic.
}
\examples{
library(NlsyLinks) #Load the package into the current R session.
dsLinks <- Links79PairExpanded  #Load the dataset from the NlsyLinks package.
dsLinks <- dsLinks[dsLinks$RelationshipPath=='Gen2Siblings', ]
oName_1 <- "MathStandardized_1" #Stands for Outcome1
oName_2 <- "MathStandardized_2" #Stands for Outcome2
dsGroupSummary <- RGroupSummary(dsLinks, oName_1, oName_2)
dsGroupSummary

#Should return:
# R Included PairCount O1Variance O2Variance O1O2Covariance Correlation Determinant PosDefinite
# 1 0.250     TRUE      2719   169.1291   207.0233       40.66048   0.2172970    33360.38    TRUE
# 2 0.375     TRUE       141   167.9943   181.8788       40.67609   0.2327024    28900.07    TRUE
# 3 0.500     TRUE      5508   230.9663   233.3492      107.59822   0.4634764    42318.42    TRUE
# 4 0.750    FALSE         2   220.5000    18.0000       63.00000   1.0000000        0.00   FALSE
# 5 1.000     TRUE        22   319.1948   343.1169      277.58874   0.8387893    32465.62    TRUE

#To get summary stats for the whole sample, create one large inclusive group.
dsLinks$Dummy <- 1
(dsSampleSummary <- RGroupSummary(dsLinks, oName_1, oName_2, rName="Dummy"))

#Should return:
# Dummy Included PairCount M1Variance M2Variance M1M2Covariance Correlation Determinant PosDefinite
#1    1     TRUE      8392    216.466   229.2988       90.90266   0.4080195     41372.1        TRUE
###
### ReadCsvNlsy79
###
\dontrun{
filePathGen2 <- "F:/Projects/RDev/NlsyLinksStaging/Datasets/Gen2Birth.csv"
ds <- ReadCsvNlsy79Gen2(filePath=filePathGen2)
}
}
\author{
  Will Beasley and David Bard
}
\references{
  Please see ZZZ (200?) for more information about SEM with
  multiple groups.

  TODO: refs for determinant & positive definite.
}
\keyword{ACE}

