\name{Links79Pair}
\alias{Links79Pair}
\docType{data}
\title{
Kinship linking file for pairs of relatives in the NLSY79 and NLSY79 Children and Young Adults
}
\description{
This dataset specifies the relatedness coefficient (ie, '\code{R}') between subjects in the same extended family.  Each row represents a unique relationship pair.  An extended family with \eqn{k} subjects will have \eqn{k}(\eqn{k}-1)/2 rows.  Typically, Subject1 is older while Subject2 is younger.

The dataset contains Gen1 and Gen2 subjects.  "Gen1" refers to subjects in the original NLSY79 sample (\url{http://www.bls.gov/nls/nlsy79.htm}).  "Gen2" subjects are the biological children of the Gen1 females -ie, those in the NLSY79 Children and Young Adults sample (\url{http://www.bls.gov/nls/nlsy79ch.htm)}.

}
\usage{data(Links79Pair)}
\format{
  A data frame with 11,075 observations on the following 5 variables.  There is one row per unique pair of subjects, irrespective of order.
  \describe{
    \item{\code{ExtendedID}}{Identity of the extended family of the pair; it corresponds to the HHID in the NLSY79.  See References below.}
    \item{\code{Subject1Tag}}{Identity of the pair's first subject.  See Details below.}
    \item{\code{Subject2Tag}}{Identity of the pair's second subject.  See Details below.}
    \item{\code{R}}{The pair's Relatedness coefficient.  See Details below.}
    \item{\code{RelationshipPath}}{Specifies the relationship category of the pair.  This variable is a factor, with levels \code{Gen1Housemates}=1, \code{Gen2Siblings}=2, \code{Gen2Cousins}=3, \code{ParentChild}=4, \code{AuntNiece}=5.}
  }
}
\details{
Subjects will be in the same extended family if either: [1] they are Gen1 housemates, [2] they are Gen2 siblings, [3] they are Gen2 cousins (ie, they have mothers who are Gen1 sisters in the NLSY79, [4] they are mother and child (in Gen1 and Gen2, respectively), or [5] they are {aunt|uncle} and {niece|nephew} (in Gen1 and Gen2, respectively).

The variables \code{Subject1Tag} and \code{Subject2Tag} uniquely identify subjects.  For Gen2 subjects, the SubjectTag is identical to their CID (ie, C00001.00 -the SubjectID assigned in the NLSY79-Children files).  However for Gen1 subjects, the SubjectTag is their CaseID (ie, R00001.00), with "00" appended.  This manipulation is necessary to identify subjects uniquely in inter-generational datasets.  A Gen1 subject with an ID of 43 has a \code{SubjectTag} of 4300.  The SubjectTags of her four children remain 4301, 4302, 4303, and 4304.

Level 5 of \code{RelationshipPath} (ie, AuntNiece) is gender neutral.  The relationship could be either Aunt-Niece, Aunt-Nephew, Uncle-Niece, or Uncle-Nephew.  If there's a widely-accepted gender-neutral term, please tell me.

MZ twins have \code{R}=1.  DZ twins and full-siblings have \code{R}=.5.  Half-siblings have \code{R}=.25. Typical first-cousins have \code{R}=.125 Unrelated subjects have \code{R}=0 (this occasionally happens for \code{Gen1Housemates}).  Other \code{R} coefficients are possible. ??Joe, do you have an earlier paper that enumerates all the obscure combinations, like half-cousins or an ambiguous AuntNiece??
}
\source{
Gen1 information comes from the May 15, 2010 release of the \href{http://www.bls.gov/nls/nlsy79.htm}{NLSY79 sample}.  Gen2 information comes from the Sept 15, 2010 release of the \href{http://www.bls.gov/nls/nlsy79ch.htm}{NLSY79 Children and Young Adults sample}.  Data were extracted with the NLS Investigator (\url{https://www.nlsinfo.org/investigator/}).

The internal version for the links is \code{Links2011V51}.
}
\references{
The NLSY79 variable HHID (ie, R00001.49) is the source for the \code{ExtendedID} variable.  This is discussed at \url{http://www.nlsinfo.org/nlsy79/docs/79html/79text/hhcomp.htm}.
** We need an introduction reference/information for 'R'/Relatedness. **
}
\author{
Will Beasley
}
\seealso{
The \code{LinksPair79} dataset contains columns necessary for a basic BG analysis.  The \code{\link{Links79PairExpanded}} dataset contains further information that might be useful in more complicated BG analyses.

A tutorial that produces a similar dataset is \url{http://www.nlsinfo.org/childya/nlsdocs/tutorials/linking_mothers_and_children/linking_mothers_and_children_tutorial.html}.  It provides examples in SAS, SPSS, and STATA.


The current dataset (ie, \code{Links79Pair}) can be saved as a CSV file (comma-separated file) and imported into in other programs and languages.  In the R console, type the following two lines of code:

\code{library(NlsyLinks); data(Links79Pair)}

\code{write.csv(Links79Pair, "C:/BGDirectory/Links79Pair.csv")}

where \code{"C:/BGDirectory/"} is replaced by your preferred directory.  Remember to use forward slashes instead of backslashes; for instance, the path \code{"C:\\BGDirectory\\Links79Pair.csv"} will be misinterpreted.
}
\examples{
library(NlsyLinks) #Load the package into the current R session.
data(Links79Pair)  #Load the dataset from the NlsyLinks package.
summary(Links79Pair)  #Summarize the five variables.
hist(Links79Pair$R)  #Display a histogram of the Relatedness coefficients.
table(Links79Pair$R)  #Create a table of the Relatedness coefficients for the whole sample.

#Create a dataset of only Gen2 sibs, and display the distribution of R.
gen2Siblings <- subset(Links79Pair, RelationshipPath=='Gen2Siblings')
table(gen2Siblings$R)  #Create a table of the Relatedness coefficients for the Gen2 sibs.
}
\keyword{datasets}
