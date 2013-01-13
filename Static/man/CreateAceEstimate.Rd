\name{CreateAceEstimate}
\alias{CreateAceEstimate}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
Instantiate an \code{\link{AceEstimate-class}} object.
}
\description{
Creates an instance of the \code{S4} class, \code{AceEstimate}  instantiating arguments set the parameter values estimated by the ACE model.
}
\usage{
CreateAceEstimate(aSquared, cSquared, eSquared, caseCount, 
  details=list(), unityTolerance = 1e-11)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{aSquared}{The proportion of variability due to a shared genetic influence (typically represented as a^2, or sometimes h^2).}
  \item{cSquared}{The proportion of variability due to shared common environmental influence.}
  \item{eSquared}{The proportion of variability due to unexplained/residual/error influence.}
  \item{caseCount}{The number of cases used to estimate the model.}
  \item{unityTolerance}{Specifies how close the the sum of the ACE components should be to one, to be considered properly scaled to one.}
  \item{details}{A \code{list} that contains the modeling output and details.}
}
\details{
The contents of the \code{details} list depends on the underlying estimation routine.  For example, when the ACE model is estimated with a DF analysis, the output is an \code{lm} object, because the \code{lm} function was used (ie, the basical general linear model).  Alternatively, if the user specified the \code{lavaan} package should estimate that ACE model, the output is a \code{lavaan} object.
}
\value{
An S4 object of \code{\link{AceEstimate-class}}.
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

%% ~Make other sections like Warning with \section{Warning }{....} ~

%\seealso{
%% ~~objects to See Also as \code{\link{help}}, ~~~
%}
%\examples{
%}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ ACE }
