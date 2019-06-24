#' @name Links79PairExpanded
#' @docType data
#'
#' @title Kinship linking file for pairs of relatives.  It builds upon the [Links79Pair] dataset.
#'
#' @description Please first read the documentation for [Links79Pair].  That
#' dataset contains the same pairs/rows, but only a subset of the
#' variables/columns.
#'
#' NOTE: In Nov 2013, the variable naming scheme changed in order to be more consistent across variables.  For variables
#' that are measured separately for both subjects (eg, Gender), the subjects' variable name will have an `_S1` or `_S2`
#' appended to it.  For instance, the variables `LastSurvey_S1` and `LastSurvey_S2` correspond to the last surveys completed
#' by the pair's first and second subject, respectively.  Similarly, the functions [CreatePairLinksDoubleEntered()] and
#' [CreatePairLinksSingleEntered()] now by default append `_S1` and `_S2`, instead of `_1` and `_2`.  However this can be
#' modified using the 'subject1Qualifier' and 'subject2Qualifier' parameters.
#'
#' @details Specifies the relatedness coefficient (ie, '*R*') between subjects in the
#' same extended family.  Each row represents a unique relationship pair.  An
#' extended family with \eqn{k} subjects will have \eqn{k}(\eqn{k}-1)/2 rows.
#' Typically, Subject1 is older while Subject2 is younger.
#'
#' `RelationshipPath` variable.  Code written using this dataset should
#' NOT assume it contains only Gen2 sibiling pairs.  See an example of
#' filtering the relationship category in the in [Links79Pair]
#' documentation.
#'
#'
#' The specific steps to determine the *R* coefficient will be described
#' in an upcoming publication.  The following information may influence the
#' decisions of an applied researcher.
#'
#'
#' A distinction is made between 'Explicit' and 'Implicit' information.
#' Explicit information comes from survey items that directly address the
#' subject's relationships.  For instance in 2006, surveys asked if the
#' sibling pair share the same biological father (eg, Y19940.00 and
#' T00020.00).  Implicit information comes from items where the subject
#' typically isn't aware that their responses may be used to determine genetic
#' relatedness.  For instance, if two siblings have biological fathers with
#' the same month of death (eg, R37722.00 and R37723.00), it may be reasonable
#' to assume they share the same biological father.
#'
#'
#' 'Interpolation' is our lingo when other siblings are used to leverage
#' insight into the current pair.  For example, assume Subject 101, 102, and
#' 103 have the same mother.  Further assume 101 and 102 report they share a
#' biological father, and that 101 and 103 share one too.  Finally, assume
#' that we don't have information about the relationship between 102 and 103.
#' If we are comfortable with our level of uncertainty of these
#' determinations, then we can interpolate/infer that 102 and 103 are
#' full-siblings as well.
#'
#' The math and height scores are duplicated from
#' [ExtraOutcomes79], but are included here to make some examples
#' more concise and accessible.
#'
#' @format
#' A data frame with 11,075 observations on the following 22 variables.
#' There is one row per unique pair of subjects, irrespective of order.
#'
#' * **ExtendedID** see the variable of the same name in [Links79Pair]
#' * **SubjectTag_S1** see the variable of the same name in [Links79Pair]
#' * **SubjectTag_S2** see the variable of the same name in [Links79Pair]
#' * **R** see the variable of the same name in [Links79Pair]
#' * **RFull** This is a superset of `R`.  This includes all the *R* values we estimated, while `R` (i.e., the variable above) excludes values like *R*=0 for `Gen1Housemates`, and the associated relationships based on this *R* value (i.e., `Gen2Cousin`s and `AuntNiece`s).
#' * **RelationshipPath** see the variable of the same name in [Links79Pair]
#' * **EverSharedHouse** Indicate if the pair likely live in the same house.  This is `TRUE` for `Gen1Housemates`, `Gen2Siblings`, and `ParentChild`. This is `FALSE` for `AuntNiece` and `Gen2Cousins`

#####  ' %\item{`MultipleBirth`}{Indicates if the pair are twins (or triplets). This variable is a factor, with levels `No`=0, `Twin`=2, `Triplet`=3, `DoNotKnow`=255.}

#' * **IsMz** Indicates if the pair is from the same zygote (ie, they are identical twins/triplets). This variable is a factor, with levels `No`=0, `Yes`=1, `DoNotKnow`=255.
#' * **LastSurvey_S1** The year of Subject1's most recently completed survey. This may be different that the survey's administration date.
#' * **LastSurvey_S2** The year of Subject2's most recently completed survey. This may be different that the survey's administration date.
#' * **RImplicitPass1** The pair's *R* coefficient, using only implicit information.  Interpolation was NOT used.
#' * **RImplicit** The pair's *R* coefficient, using only implicit information.  Interpolation was used.
#' * **RImplicit2004** The pair's *R* coefficient released in our previous projects (**need reference**).  This variable is provided primarily for previous users wishing to replicate previous analyses.
#' * **RExplicitPass1** The pair's *R* coefficient, using only explicit information.  Interpolation was NOT used.
#' * **RExplicit** The pair's *R* coefficient, using only explicit information.  Interpolation was used.
#' * **RExplicitOlderSibVersion** The pair's *R* coefficient, according to the explicit item responses of the older sibling.
#' * **RExplicitYoungerSibVersion** The pair's *R* coefficient, according to the explicit item responses of the younger sibling.
#' * **RPass1** The pair's estimated *R* coefficient, using both implicit and explicit information.  Interpolation was NOT used.  The variable `R` is identically constructed, but it did use interpolation.
#' * **Generation_S1** The generation of the first subject.  Values for Gen1 and Gen2 are `1` and `2`, respectively.
#' * **Generation_S2** The generation of the second subject.  Values for Gen1 and Gen2 are `1` and `2`, respectively.
#' * **SubjectID_S1** The ID value assigned by NLS to the first subject.  For Gen1 Subjects, this is their "CaseID" (ie, R00001.00).  For Gen2 subjects, this is their "CID" (ie, C00001.00).
#' * **SubjectID_S2** The ID value assigned by NLS to the second subject.
#' * **MathStandardized_S1** The PIAT-Math score for Subject1.  See [ExtraOutcomes79] for more information about its source.
#' * **MathStandardized_S2** The PIAT-Math score for Subject2.
#' * **HeightZGenderAge_S1** The early adult height for Subject1.  See [ExtraOutcomes79] for more information about its source.
#' * **HeightZGenderAge_S2** The early adult height for Subject2.
#'
#' @author Will Beasley
#'
#' @seealso
#' **Download CSV**
#' If you're using the NlsyLinks package in R, the dataset is automatically available.
#' To use it in a different environment,
#' [download the csv](https://github.com/nlsy-links/NlsyLinks/blob/master/outside-data/nlsy-79/links-2017-79.csv?raw=true),
#' which is readble by all statistical software.
#' [links-metadata-2017-79.yml](https://github.com/nlsy-links/NlsyLinks/blob/master/outside-data/nlsy-79/links-metadata-2017-79.yml)
#' documents the dataset version information.
#'
#' @source See [Links79Pair].
#'
#' @keywords datasets
#'
#' @examples
#' library(NlsyLinks) # Load the package into the current R session.
#' # olderR   <- Links79PairExpanded$RExplicitOlderSibVersion   # Declare a concise variable name.
#' # youngerR <- Links79PairExpanded$RExplicitYoungerSibVersion # Declare a concise variable name.
#'
#' # plot(jitter(olderR), jitter(youngerR))  # Scatterplot the siblings' responses.
#' # table( youngerR, olderR)  # Table of the relationship between the siblings' responses.
#' # ftable(youngerR, olderR, dnn=c("Younger's Version", "Older's Version")) # A formatted table.
#'
#' # write.csv(
#' #   Links79PairExpanded,
#' #   file      ='~/NlsyLinksStaging/Links79PairExpanded.csv',
#' #   row.names = FALSE
#' # )
#'
NULL
