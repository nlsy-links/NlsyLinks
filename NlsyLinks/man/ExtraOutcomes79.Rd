\name{ExtraOutcomes79}
\alias{ExtraOutcomes79}
\docType{data}
\title{
Extra outcome variables in the NLSY79
}
\description{
This dataset is provided primarily to facilitate documentation examples.

Currently this dataset contains only Gen2 subjects.  However, it soon will include Gen1 subjects.  Code written using this dataset should NOT assume it contains only Gen2 subjects.  See below for an example of filtering by generation.
}
\usage{data(ExtraOutcomes79)}
\format{
  A data frame with 11,495 observations on the following 6 variables.  There is one row per subject.
  \describe{
    \item{\code{SubjectTag}}{The ID value assigned by NLS to the first subject.  For Gen1 Subjects, this is their "CaseID" (ie, R00001.00).  For Gen2 subjects, this is their "CID" (ie, C00001.00).}
    \item{\code{SubjectID}}{The ID value assigned by NLS to the first subject.  For Gen1 Subjects, this is their "CaseID" (ie, R00001.00).  For Gen2 subjects, this is their "CID" (ie, C00001.00).}
    \item{\code{Generation}}{The generation of the subject.  Values are either 1 or 2, representing Gen1 and Gen2.  Note that this variable is not a \code{factor} (in constrast with data frames like \code{\link{Links79Pair}}).   This dataset is supposed to mimick the dataset provided by the researcher, which typically will not have been converted to a \code{factor}.}
    \item{\code{AfqtRescaled2006Gaussified}}{Armed Forces Qualification Test Score for Gen1.}
    \item{\code{HeightZGender}}{The subject's height, standardized by gender (see Details).}
    \item{\code{HeightZGenderAge}}{The subject's height, standardized by gender and age (see Details).}
    \item{\code{WeightZGender}}{The subject's weight, standardized by gender (see Details).}
    \item{\code{WeightZGenderAge}}{The subject's weight, standardized by gender and age (see Details).}
    \item{\code{Afi}}{Self-reported age of first intercourse (see Details).}
    \item{\code{Afm}}{Self-reported age of first menstration (see Details).}
    \item{\code{MathStandardized}}{Standardized PIAT Math score for Gen2 (see Details).}
    
  }
}
%\details{
%%  ~~ If necessary, more details than the __description__ above ~~
%}
\source{
Gen1 information comes from the May 15, 2010 release of the \href{http://www.bls.gov/nls/nlsy79.htm}{NLSY79 sample}.  Gen2 information comes from the Sept 15, 2010 release of the \href{http://www.bls.gov/nls/nlsy79ch.htm}{NLSY79 Children and Young Adults sample}.  Data were extracted with the NLS Investigator (\url{https://www.nlsinfo.org/investigator/}).

The \code{SubjectTag} variable uniquely identify subjects.  For Gen2 subjects, the SubjectTag is identical to their CID (ie, C00001.00 -the SubjectID assigned in the NLSY79-Children files).  However for Gen1 subjects, the SubjectTag is their CaseID (ie, R00001.00), with "00" appended.  This manipulation is necessary to identify subjects uniquely in inter-generational datasets.  A Gen1 subject with an ID of 43 has a \code{SubjectTag} of 4300.  The SubjectTags of her four children remain 4301, 4302, 4303, and 4304.

For Gen2, an NLSY79 variable of \code{MathStandardized} is C0580100.00.

\code{Afi}, \code{Afm}, and \code{MathStandardized} values were simplied (to one value per subject) by Kelly Meredith in January 2012 using the Sept 15, 2010 release of NLSY data.
}
%\references{
%%  ~~ possibly secondary sources and usages ~~
%}
\author{
Will Beasley
}
\examples{
library(NlsyLinks) #Load the package into the current R session.
data(ExtraOutcomes79)  #Load the dataset from the NlsyLinks package.
gen2Outcomes <- subset(ExtraOutcomes79, Generation==2) #Create a dataset of only Gen2 subjects.
                  
plot(ExtraOutcomes79)
summary(ExtraOutcomes79)

oldPar <- par(mfrow=c(3,2))
hist(ExtraOutcomes79$Generation)
hist(ExtraOutcomes79$MathStandardized)
hist(ExtraOutcomes79$HeightZGenderAge)
hist(ExtraOutcomes79$WeightZGenderAge)
hist(ExtraOutcomes79$Afi)
hist(ExtraOutcomes79$Afm)
par(oldPar)
}
\keyword{datasets}
