\name{CreateSpatialNeighbours}
\alias{CreateSpatialNeighbours}
\alias{CreateSpatialNeighbours79Gen2}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
Distances between related family members, formated for spatial analysis.
}
\description{
This helper function formats the LinksPair datasets so it can be used in some types of spatial analyses. The \pkg{spdep} (Spatial Dependence) uses a sparse matrix (actually a \code{\link{data.frame}}) to represent neigbours.
}
\usage{
CreateSpatialNeighbours(linksPairsDoubleEntered)
CreateSpatialNeighbours79Gen2()
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{linksPairsDoubleEntered}{ ## Need something here. ##}
}
\details{
There is one row per unique pair of subjects, \emph{respecting order}.  This is different than \code{\link{Links79Pair}} and \code{\link{Links79PairExpanded}}, which has one row per unique pair of subjects, \emph{irrespective of order}.

\code{CreateSpatialNeighbours79Gen2} automatically creates dataset of NLSY79 Gen2 subjects (i.e., the children of the mothers in the initial NLSY79 sample.

\code{CreateSpatialNeighbours} accepts any paired relationships in a \code{data.frame}, as long as it contains the columns \code{Subject1Tag}, \code{Subject2Tag}, and \code{R}.  See \code{\link{Links79Pair}} for more details.
}
\value{
Returns an S3 \code{spatial.neighbours} object to work with functions in the \pkg{spdep} package.  
\code{Subject1Tag} is renamed \code{from}. 
\code{Subject2Tag} is renamed \code{to}. 
\code{R} is renamed \code{weight}.
The attribute \code{region.id} specifies each unique SubjectTag.
The attribue \code{n} specifies the number of unique subjects.
}
\references{

Bivand, R., Pebesma, E., & Gomez-Rubio, V. (2008). \emph{Applied Spatial Data Analysis with R.} New York: Springer. (Especially Chapter 9.)

##David, can you please give me some of the articles/books that you used this with?

}
\author{
Will Beasley, David Bard
}
\note{
Notice the British variant of 'neighbo\emph{u}rs'
}

%% ~Make other sections like Warning with \section{Warning }{....} ~

\seealso{
\code{\link{Links79Pair}}

\code{\link[spdep]{listw2sn}}, \code{\link[spdep]{sn2listw}}, \code{\link[spdep]{df2sn}}, \code{\link[spdep]{write.sn2gwt}}, \code{\link[spdep]{write.sn2dat}} are some of the functions in the \pkg{spdep} package that use a \code{spatial.neighbours} object.
}
\examples{
#Need something here
% R documentation directory.
}
\keyword{ spatial analysis }

