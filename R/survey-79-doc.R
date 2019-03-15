#' @name Survey79
#'
#' @docType data
#'
#' @title Dataset containing survey details for each subject, for each year
#'
#' @description Each row represents a survey that a subject completed (or didn't complete).
#' It can be very helpful when restructuring the NLS investigator extracts into a
#' longitudinal dataset that's aligned by age (instead of by survey wave).
#' The Age variables can help to align other response variables across subjects.
#' While the 'SurveySource' indicates where to look for their responses.
#'
#' These variables are useful to many types of analyses (not just behavior genetics), and are
#' provided to save users time.
#'
#' @name Survey79
#'
#' @docType data
#'
#' @format A data frame with 580,752 observations on the following 6 variables.
#' * **SubjectTag** see the variable of the same name in [Links79Pair]
#' * **SurveySource** The location of that subject's survey responses that year.  Values are `NoInterview`, `Gen1`, `Gen2C` or `Gen2YA`.
#' * **SurveyYear** The year/wave of the survey.
#' * **Survey79** The exact date of the administered survey.
#' * **AgeSelfReportYears** The subject's age, according to a their own response, or their mother's response.
#' * **AgeCalculateYears** The subject's age, calculated from subtracting their birthday from the interview date.
#' * **Age** The subject's age, which uses `AgeCalculateYears` or `AgeSelfReportYears` if it's not available.
#'
#' @details The `AgeSelfReportYears` and `AgeCalculateYears` variables usually agree, but not always.  The `Age` variable uses `AgeCalculateYears` (or `AgeSelfReportYears` when `AgeCalculateYears` is missing).
#'
#' The exact *date* of birth isn't public (only the subject's *month* of birth).  To balance the downward bias of two weeks,
#' theri birthday is set to the 15th day of the month to produce `AgeCalculateYears`.
#'
#' In the Gen2 Child dataset, self-reported age is
#' stated by month (eg, the child is 38 months old); a constant of 0.5 months has been added to balance the downward bias.  In the Gen2 YA and
#' Gen1 datasets, self-reported age is stated by year (eg, the subject is 52 years old); a constant of 0.5 years has been added.
#'
#' @author Will Beasley
#'
#' @source Gen1 information comes from the Summer 2013 release of the [NLSY79 sample](http://www.bls.gov/nls/nlsy79.htm).  Gen2 information
#' comes from the January 2015 release of the
#' [NLSY79 Children and Young Adults sample](http://www.bls.gov/nls/nlsy79ch.htm).  Data were extracted with the NLS Investigator
#' (https://www.nlsinfo.org/investigator/).
#'
#' @keywords datasets
#'
#' @examples
#' library(NlsyLinks) #Load the package into the current R session.
#'
#' summary(Survey79)
#' table(Survey79$SurveyYear, Survey79$SurveySource)
#' table(is.na(Survey79$AgeSelfReportYears), is.na(Survey79$AgeCalculateYears))
#'
#' if( require(ggplot2) & require(plyr) ) {
#'   dsSourceYear <- plyr::count(Survey79, c("SurveyYear", "SurveySource"))
#'   dsSourceYear <- dsSourceYear[dsSourceYear$SurveySource != "NoInterview", ]
#'
#'   ggplot(dsSourceYear, aes(x=SurveyYear, y=freq, color=SurveySource)) +
#'     geom_line(size=2) +
#'     geom_point(size=5, shape=21) +
#'     scale_color_brewer(palette = "Dark2") +
#'     theme_bw() +
#'     theme(legend.position=c(0,0), legend.justification=c(0,0))
#'
#'   ggplot(Survey79, aes(x=AgeSelfReportYears, y=AgeCalculateYears)) +
#'     geom_abline() +
#'     geom_point(shape=21) +
#'     theme_bw()
#' }
#'
NULL
