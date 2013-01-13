\name{CreateSpatialNeighbours}
\alias{CreateSpatialNeighbours}
\title{Distances between related family members, formated for spatial analysis.}
\usage{
  CreateSpatialNeighbours(linksPairsDoubleEntered)
}
\arguments{
  \item{linksPairsDoubleEntered}{A \code{data.frame}
  containing the links, preferably created by a function
  like \code{\link{CreatePairLinksDoubleEntered}}.}
}
\value{
  An S3 \code{spatial.neighbours} object to work with
  functions in the \pkg{spdep} package. \code{Subject1Tag}
  is renamed \code{from}. \code{Subject2Tag} is renamed
  \code{to}. \code{R} is renamed \code{weight}. The
  attribute \code{region.id} specifies each unique
  SubjectTag. The attribue \code{n} specifies the number of
  unique subjects.
}
\description{
  This helper function formats the LinksPair datasets so it
  can be used in some types of spatial analyses. The
  \pkg{spdep} (Spatial Dependence) uses a sparse matrix
  (actually a \code{\link{data.frame}}) to represent
  neigbours.
}
\details{
  There is one row per unique pair of subjects,
  \emph{respecting order}.  This is different than
  \code{\link{Links79Pair}} and
  \code{\link{Links79PairExpanded}}, which has one row per
  unique pair of subjects, \emph{irrespective of order}.
  #\code{CreateSpatialNeighbours79Gen2} automatically
  creates dataset of NLSY79 Gen2 subjects (i.e., the
  children of the mothers in the initial NLSY79 sample.

  \code{CreateSpatialNeighbours} accepts any paired
  relationships in a \code{data.frame}, as long as it
  contains the columns \code{Subject1Tag},
  \code{Subject2Tag}, and \code{R}.  See
  \code{\link{Links79Pair}} for more details.
}
\note{
  Notice the British variant of 'neighbo\emph{u}rs'
}
\examples{
##Need something here
}
\author{
  Will Beasley David Bard
}
\references{
  Bivand, R., Pebesma, E., & Gomez-Rubio, V. (2008).
  \emph{Applied Spatial Data Analysis with R.} New York:
  Springer. (Especially Chapter 9.) ##David, can you please
  give me some of the articles/books that you used this
  with?
}
\keyword{analysis}
\keyword{spatial}

