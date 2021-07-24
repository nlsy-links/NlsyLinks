#' @name ExtraOutcomes79
#'
#' @docType data
#'
#' @title Extra outcome variables in the NLSY79
#'
#' @description This dataset is provided primarily to facilitate documentation examples.
#'
#' @format A data frame with 11,495 observations on the following 6 variables. There is one row per subject.
#' * **SubjectTag** The ID value assigned by NLS to the first subject.  For Gen1 Subjects, this is their "CaseID" (ie, R00001.00).  For Gen2 subjects, this is their "CID" (ie, C00001.00).
#' * **SubjectID** The ID value assigned by NLS to the first subject.  For Gen1 Subjects, this is their "CaseID" (ie, R00001.00).  For Gen2 subjects, this is their "CID" (ie, C00001.00).
#' * **Generation** The generation of the subject.  Values are either 1 or 2, representing Gen1 and Gen2.  Note that this variable is not a  `factor` (in contrast with data frames like
#'    [Links79Pair]).  This dataset is supposed to mimic the dataset provided by the researcher, which typically will not have been converted to a `factor`.
#' * **HeightZGenderAge** The subject's height, standardized by gender and age (see Details).
#' * **WeightZGenderAge** The subject's weight, standardized by gender and age (see Details).
#' * **AfqtRescaled2006Gaussified** Armed Forces Qualification Test Score (Gen1 only; see Details).
#' * **Afi** Self-reported age of first intercourse (Gen1 only; see Details).
#' * **Afm** Self-reported age of first menstruation (Gen1 only; see Details).
#' * **MathStandardized** Standardized PIAT Math scores (Gen2 only; see Details).
#'
#' @author Will Beasley
#' @source Gen1 information comes from the Summer 2013 release of the
#' [NLSY79 sample](https://www.bls.gov/nls/nlsy79.htm).  Gen2 information comes from the Summer 2013 release of the
#' [NLSY79 Children and Young Adults sample](https://www.bls.gov/nls/nlsy79ch.htm).  Data were extracted with the NLS Investigator
#' ({https://www.nlsinfo.org/investigator/}).
#'
#' @details
#' The `SubjectTag` variable uniquely identify subjects.  For Gen2
#' subjects, the SubjectTag is identical to their CID (ie, C00001.00 -the
#' SubjectID assigned in the NLSY79-Children files).  However for Gen1
#' subjects, the SubjectTag is their CaseID (ie, R00001.00), with "00"
#' appended.  This manipulation is necessary to identify subjects uniquely in
#' inter-generational datasets.  A Gen1 subject with an ID of 43 has a
#' `SubjectTag` of 4300.  The SubjectTags of her four children remain
#' 4301, 4302, 4303, and 4304.
#'
#' For Gen2, an NLSY79 variable of `MathStandardized` is C05801.00.
#'
#' `Afi` and `Afm`, values were simplified
#' (to one value per subject) by Kelly Williams in Sept 2010.
#'
#' The variables for height and weight were manipulated in R files available in a
#' [repository](https://github.com/nlsy-links/nlsy-links-determination-2017/tree/master/data-public/derived) available to the public.
#' Find the appropriate subfolder, and view the HTML report for more details.
#'
#' **Download CSV**
#' If you're using the NlsyLinks package in R, the dataset is automatically available.
#' However to use the kinship information in a different environment, download the
#' [csv](https://github.com/nlsy-links/NlsyLinks/blob/master/outside-data/nlsy-79/extra-outcomes-79.csv?raw=true),
#' which is readable by all statistical software.
#' [links-metadata-2017-79.yml](https://github.com/nlsy-links/NlsyLinks/blob/master/outside-data/nlsy-79/links-metadata-2017-79.yml)
#' documents the dataset version information.
#'
#' @keywords datasets
#'
#' @examples
#' library(NlsyLinks) #Load the package into the current R session.
#' gen2Outcomes <- subset(ExtraOutcomes79, Generation==2) #Create a dataset of only Gen2 subjects.
#'
#' #plot(ExtraOutcomes79) #Uncomment to see a large scatterplot matrix.
#' summary(ExtraOutcomes79)
#'
#' oldPar <- par(mfrow=c(3,2))
#' hist(ExtraOutcomes79$Generation)
#' hist(ExtraOutcomes79$MathStandardized)
#' hist(ExtraOutcomes79$HeightZGenderAge)
#' hist(ExtraOutcomes79$WeightZGenderAge)
#' hist(ExtraOutcomes79$Afi)
#' hist(ExtraOutcomes79$Afm)
#' par(oldPar)
#'
NULL
