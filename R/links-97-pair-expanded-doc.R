#' @name Links97PairExpanded
#' @docType data
#'
#' @title Kinship linking file for pairs of relatives In the NLSY97.  It builds upon the [Links97Pair] dataset.
#'
#' @description Please first read the documentation for [Links97Pair].  That
#' dataset contains the same pairs/rows, but only a subset of the
#' variables/columns.
#'
#' For variables
#' that are measured separately for both subjects (eg, Gender), the subjects' variable name will have an `_S1` or `_S2`
#' appended to it.  For instance, the variables `LastSurvey_S1` and `LastSurvey_S2` correspond to the last surveys completed
#' by the pair's first and second subject, respectively.  Similarly, the functions [CreatePairLinksDoubleEntered()] and
#' [CreatePairLinksSingleEntered()] by default append `_S1` and `_S2`.  However this can be
#' modified using the 'subject1Qualifier' and 'subject2Qualifier' parameters.
#'
#' @details Specifies the relatedness coefficient (ie, '*R*') between subjects in the
#' same extended family.  Each row represents a unique relationship pair.  An
#' extended family with \eqn{k} subjects will have \eqn{k}(\eqn{k}-1)/2 rows.
#' Typically, Subject1 is older while Subject2 is younger.
#'
#'
#' The specific steps to determine the *R* coefficient will be described
#' in an upcoming publication.  The following information may influence the
#' decisions of an applied researcher.
#'
#'
# A distinction is made between 'Explicit' and 'Implicit' information.
# Explicit information comes from survey items that directly address the
# subject's relationships.  For instance in 2006, surveys asked if the
# sibling pair share the same biological father (eg, Y19940.00 and
# T00020.00).  Implicit information comes from items where the subject
# typically isn't aware that their responses may be used to determine genetic
# relatedness.  For instance, if two siblings have biological fathers with
# the same month of death (eg, R37722.00 and R37723.00), it may be reasonable
# to assume they share the same biological father.
#
#
# 'Interpolation' is our lingo when other siblings are used to leverage
# insight into the current pair.  For example, assume Subject 101, 102, and
# 103 have the same mother.  Further assume 101 and 102 report they share a
# biological father, and that 101 and 103 share one too.  Finally, assume
# that we don't have information about the relationship between 102 and 103.
# If we are comfortable with our level of uncertainty of these
# determinations, then we can interpolate/infer that 102 and 103 are
# full-siblings as well.
#
# The math and height scores are duplicated from
# [ExtraOutcomes79], but are included here to make some examples
# more concise and accessible.
#
#' @format
#' A data frame with 11,075 observations on the following 22 variables.
#' There is one row per unique pair of subjects, irrespective of order.
#'
#' * **ExtendedID** see the variable of the same name in [Links97Pair]
#' * **SubjectTag_S1** see the variable of the same name in [Links97Pair]
#' * **SubjectTag_S2** see the variable of the same name in [Links97Pair]
#' * **R** see the variable of the same name in [Links97Pair]
#' * **RFull** This is a superset of `R`.  This includes all the *R* values we estimated, while `R` (i.e., the variable above) excludes values like *R*=0.
#' * **RelationshipPath** see the variable of the same name in [Links97Pair]
#' * **EverSharedHouse** Indicate if the pair likely live in the same house.  This is `TRUE` for all pairs in this NLSY97 dataset.
#' * **IsMz** Indicates if the pair is from the same zygote (ie, they are identical twins/triplets). This variable is a factor, with levels `No`=0, `Yes`=1, `DoNotKnow`=255.
#' * **LastSurvey_S1** The year of Subject1's most recently completed survey. This may be different that the survey's administration date.
#' * **LastSurvey_S2** The year of Subject2's most recently completed survey. This may be different that the survey's administration date.
# * **RImplicitPass1** The pair's *R* coefficient, using only implicit information.  Interpolation was NOT used.
# * **RImplicit** The pair's *R* coefficient, using only implicit information.  Interpolation was used.
# * **RImplicit2004** The pair's *R* coefficient released in our previous projects (**need reference**).  This variable is provided primarily for previous users wishing to replicate previous analyses.
# * **RExplicitPass1** The pair's *R* coefficient, using only explicit information.  Interpolation was NOT used.
# * **RExplicit** The pair's *R* coefficient, using only explicit information.  Interpolation was used.
# * **RExplicitOlderSibVersion** The pair's *R* coefficient, according to the explicit item responses of the older sibling.
# * **RExplicitYoungerSibVersion** The pair's *R* coefficient, according to the explicit item responses of the younger sibling.
#' * **RPass1** The pair's estimated *R* coefficient, using both implicit and explicit information.  Interpolation was NOT used.  The variable `R` is identically constructed, but it did use interpolation.
#' * **SubjectID_S1** The ID value assigned by NLS to the first subject.  For Gen1 Subjects, this is their "CaseID" (ie, R00001.00).  For Gen2 subjects, this is their "CID" (ie, C00001.00).
#' * **SubjectID_S2** The ID value assigned by NLS to the second subject.
#'
#' @author Will Beasley
#'
#' @seealso
#' **Download CSV**
#' If you're using the NlsyLinks package in R, the dataset automatically is available.
#' To use it in a different environment,
#' [download the csv](https://github.com/nlsy-links/NlsyLinks/blob/master/outside-data/nlsy-97/links-2017-97.csv?raw=true),
#' which is readable by all statistical software.
#' [links-metadata-2017-97.yml](https://github.com/nlsy-links/NlsyLinks/blob/master/outside-data/nlsy-97/links-metadata-2017-97.yml)
#' documents the dataset version information.
#'
#' @source See [Links97Pair].
#'
#' @keywords datasets
#'
#' @examples
#' library(NlsyLinks) # Load the package into the current R session.
#' hist(Links97PairExpanded$R)   # Declare a concise variable name.
#'
#' # write.csv(
#' #   Links97PairExpanded,
#' #   file      ='~/NlsyLinksStaging/Links97PairExpanded.csv',
#' #   row.names = FALSE
#' # )
#'
NULL
