% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/links-79-pair-expanded-doc.R
\docType{data}
\name{Links79PairExpanded}
\alias{Links79PairExpanded}
\title{Kinship linking file for pairs of relatives.  It builds upon the \link{Links79Pair} dataset.}
\format{
A data frame with 11,075 observations on the following 22 variables.
There is one row per unique pair of subjects, irrespective of order.
\itemize{
\item \strong{ExtendedID} see the variable of the same name in \link{Links79Pair}
\item \strong{SubjectTag_S1} see the variable of the same name in \link{Links79Pair}
\item \strong{SubjectTag_S2} see the variable of the same name in \link{Links79Pair}
\item \strong{R} see the variable of the same name in \link{Links79Pair}
\item \strong{RFull} This is a superset of \code{R}.  This includes all the \emph{R} values we estimated, while \code{R} (i.e., the variable above) excludes values like \emph{R}=0 for \code{Gen1Housemates}, and the associated relationships based on this \emph{R} value (i.e., \code{Gen2Cousin}s and \code{AuntNiece}s).
\item \strong{RelationshipPath} see the variable of the same name in \link{Links79Pair}
\item \strong{EverSharedHouse} Indicate if the pair likely live in the same house.  This is \code{TRUE} for \code{Gen1Housemates}, \code{Gen2Siblings}, and \code{ParentChild}. This is \code{FALSE} for \code{AuntNiece} and \code{Gen2Cousins}
\item \strong{IsMz} Indicates if the pair is from the same zygote (ie, they are identical twins/triplets). This variable is a factor, with levels \code{No}=0, \code{Yes}=1, \code{DoNotKnow}=255.
\item \strong{LastSurvey_S1} The year of Subject1's most recently completed survey. This may be different that the survey's administration date.
\item \strong{LastSurvey_S2} The year of Subject2's most recently completed survey. This may be different that the survey's administration date.
\item \strong{RImplicitPass1} The pair's \emph{R} coefficient, using only implicit information.  Interpolation was NOT used.
\item \strong{RImplicit} The pair's \emph{R} coefficient, using only implicit information.  Interpolation was used.
\item \strong{RImplicit2004} The pair's \emph{R} coefficient released in our previous projects (\strong{need reference}).  This variable is provided primarily for previous users wishing to replicate previous analyses.
\item \strong{RExplicitPass1} The pair's \emph{R} coefficient, using only explicit information.  Interpolation was NOT used.
\item \strong{RExplicit} The pair's \emph{R} coefficient, using only explicit information.  Interpolation was used.
\item \strong{RExplicitOlderSibVersion} The pair's \emph{R} coefficient, according to the explicit item responses of the older sibling.
\item \strong{RExplicitYoungerSibVersion} The pair's \emph{R} coefficient, according to the explicit item responses of the younger sibling.
\item \strong{RPass1} The pair's estimated \emph{R} coefficient, using both implicit and explicit information.  Interpolation was NOT used.  The variable \code{R} is identically constructed, but it did use interpolation.
\item \strong{Generation_S1} The generation of the first subject.  Values for Gen1 and Gen2 are \code{1} and \code{2}, respectively.
\item \strong{Generation_S2} The generation of the second subject.  Values for Gen1 and Gen2 are \code{1} and \code{2}, respectively.
\item \strong{SubjectID_S1} The ID value assigned by NLS to the first subject.  For Gen1 Subjects, this is their "CaseID" (ie, R00001.00).  For Gen2 subjects, this is their "CID" (ie, C00001.00).
\item \strong{SubjectID_S2} The ID value assigned by NLS to the second subject.
\item \strong{MathStandardized_S1} The PIAT-Math score for Subject1.  See \link{ExtraOutcomes79} for more information about its source.
\item \strong{MathStandardized_S2} The PIAT-Math score for Subject2.
\item \strong{HeightZGenderAge_S1} The early adult height for Subject1.  See \link{ExtraOutcomes79} for more information about its source.
\item \strong{HeightZGenderAge_S2} The early adult height for Subject2.
}
}
\source{
See \link{Links79Pair}.
}
\description{
Please first read the documentation for \link{Links79Pair}.  That
dataset contains the same pairs/rows, but only a subset of the
variables/columns.

NOTE: In Nov 2013, the variable naming scheme changed in order to be more consistent across variables.  For variables
that are measured separately for both subjects (eg, Gender), the subjects' variable name will have an \verb{_S1} or \verb{_S2}
appended to it.  For instance, the variables \code{LastSurvey_S1} and \code{LastSurvey_S2} correspond to the last surveys completed
by the pair's first and second subject, respectively.  Similarly, the functions \code{\link[=CreatePairLinksDoubleEntered]{CreatePairLinksDoubleEntered()}} and
\code{\link[=CreatePairLinksSingleEntered]{CreatePairLinksSingleEntered()}} now by default append \verb{_S1} and \verb{_S2}, instead of \verb{_1} and \verb{_2}.  However this can be
modified using the 'subject1Qualifier' and 'subject2Qualifier' parameters.
}
\details{
Specifies the relatedness coefficient (ie, '\emph{R}') between subjects in the
same extended family.  Each row represents a unique relationship pair.  An
extended family with \eqn{k} subjects will have \eqn{k}(\eqn{k}-1)/2 rows.
Typically, Subject1 is older while Subject2 is younger.

\code{RelationshipPath} variable.  Code written using this dataset should
NOT assume it contains only Gen2 sibling pairs.  See an example of
filtering the relationship category in the in \link{Links79Pair}
documentation.

The specific steps to determine the \emph{R} coefficient will be described
in an upcoming publication.  The following information may influence the
decisions of an applied researcher.

A distinction is made between 'Explicit' and 'Implicit' information.
Explicit information comes from survey items that directly address the
subject's relationships.  For instance in 2006, surveys asked if the
sibling pair share the same biological father (eg, Y19940.00 and
T00020.00).  Implicit information comes from items where the subject
typically isn't aware that their responses may be used to determine genetic
relatedness.  For instance, if two siblings have biological fathers with
the same month of death (eg, R37722.00 and R37723.00), it may be reasonable
to assume they share the same biological father.

'Interpolation' is our lingo when other siblings are used to leverage
insight into the current pair.  For example, assume Subject 101, 102, and
103 have the same mother.  Further assume 101 and 102 report they share a
biological father, and that 101 and 103 share one too.  Finally, assume
that we don't have information about the relationship between 102 and 103.
If we are comfortable with our level of uncertainty of these
determinations, then we can interpolate/infer that 102 and 103 are
full-siblings as well.

The math and height scores are duplicated from
\link{ExtraOutcomes79}, but are included here to make some examples
more concise and accessible.
}
\examples{
library(NlsyLinks) # Load the package into the current R session.
# olderR   <- Links79PairExpanded$RExplicitOlderSibVersion   # Declare a concise variable name.
# youngerR <- Links79PairExpanded$RExplicitYoungerSibVersion # Declare a concise variable name.

# plot(jitter(olderR), jitter(youngerR))  # Scatterplot the siblings' responses.
# table( youngerR, olderR)  # Table of the relationship between the siblings' responses.
# ftable(youngerR, olderR, dnn=c("Younger's Version", "Older's Version")) # A formatted table.

# write.csv(
#   Links79PairExpanded,
#   file      ='~/NlsyLinksStaging/Links79PairExpanded.csv',
#   row.names = FALSE
# )

}
\seealso{
\strong{Download CSV}
If you're using the NlsyLinks package in R, the dataset is automatically available.
To use it in a different environment,
\href{https://github.com/nlsy-links/NlsyLinks/blob/master/outside-data/nlsy-79/links-2017-79.csv?raw=true}{download the csv},
which is readable by all statistical software.
\href{https://github.com/nlsy-links/NlsyLinks/blob/master/outside-data/nlsy-79/links-metadata-2017-79.yml}{links-metadata-2017-79.yml}
documents the dataset version information.
}
\author{
Will Beasley
}
\keyword{datasets}
