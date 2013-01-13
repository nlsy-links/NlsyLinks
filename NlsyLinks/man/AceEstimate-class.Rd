\name{AceEstimate-class}
\Rdversion{1.1}
\docType{class}
\alias{AceEstimate-class}
\alias{getEstimate,AceEstimate-method}
\alias{initialize,AceEstimate-method}
\alias{print,AceEstimate-method}
\alias{show,AceEstimate-method}
\alias{GetDetails,AceEstimate-method}

\title{Class \code{"AceEstimate"}}
\description{
A class containing information about a single univariate ACE model.
}
\section{Objects from the Class}{
Objects can be created by calls of the form:

\code{new("AceEstimate", aSquared, cSquared, eSquared, caseCount, unity, withinBounds, details, ...)}

}
\section{Slots}{
  \describe{
    \item{\code{ASquared}:}{The proportion of variability due to a shared genetic influence (typically represented as a^2, or sometimes h^2). }
    \item{\code{CSquared}:}{The proportion of variability due to shared common environmental influence.}
    \item{\code{ESquared}:}{The proportion of variability due to unexplained/residual/error influence.}
    \item{\code{CaseCount}:}{The number cases contributing to this estimate.}
    \item{\code{Unity}:}{Indicates if the three components sum to 1.}
    \item{\code{WithinBounds}:}{Indicates if the three components are each bounded by [0, 1].}
    \item{\code{Details}:}{A \code{list} that contains the modeling and estimation output and details.}
  }
}
\section{Methods}{
  \describe{
    \item{GetDetails}{\code{signature(object = "AceEstimate")}: ... }
    \item{initialize}{\code{signature(.Object = "AceEstimate")}: ... }
    \item{print}{\code{signature(x = "AceEstimate")}: ... }
    \item{show}{\code{signature(object = "AceEstimate")}: ... }
	 }
}
%\references{
%%  ~~put references to the literature/web site here~~
%}
%\author{
%%  ~~who you are~~
%}
\note{
The contents of the \code{Details} list depends on the underlying estimation routine.  For example, when the ACE model is estimated with a DF analysis, the output is an \code{lm} object, because the \code{lm} function was used (ie, the basical general linear model).  Alternatively, if the user specified the \code{lavaan} package should estimate that ACE model, the output is a \code{lavaan} object.
}

%% ~Make other sections like Warning with \section{Warning }{....} ~

%\seealso{
%%  ~~objects to See Also as \code{\link{~~fun~~}}, ~~~
%%  ~~or \code{\linkS4class{CLASSNAME}} for links to other classes ~~~
%}
\examples{
library(NlsyLinks) #Load the package into the current R session.

showClass("AceEstimate")
est <- CreateAceEstimate(.5, .2, .3, 40)
est 
print(est)


}
\keyword{classes}
\keyword{ACE}
