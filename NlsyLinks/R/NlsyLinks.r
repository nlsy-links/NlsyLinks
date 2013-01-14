#' Utilities and kinship information for Behavior Genetics and Developmental
#' research using the NLSY.
#' 
#' Utilities and kinship information for Behavior Genetics and Developmental
#' research using the NLSY.
#' 
#' \tabular{ll}{ Package: \tab NlsyLinks\cr Type: \tab Package\cr Version:
#' \tab 1.200\cr Date: \tab 2012-12-18\cr License: \tab GPL\cr LazyLoad: \tab
#' yes\cr } An overview of how to use the package, including the most
#' important functions
#' 
#' @docType package
#' @name NlsyLinks-package
#' @rdname NlsyLinks-package
#' @aliases NlsyLinks-package NlsyLinks
#' @note This package considers both Gen1 and Gen2 subjects.  "Gen1" refers to
#' subjects in the original NLSY79 sample
#' (\url{http://www.bls.gov/nls/nlsy79.htm}).  "Gen2" subjects are the
#' biological children of the Gen1 females -ie, those in the NLSY79 Children
#' and Young Adults sample (\url{http://www.bls.gov/nls/nlsy79ch.htm}).
#' @author Will Beasley, Joe Rodgers, Kelly Meredith, and David Bard
#' 
#' Maintainer: Will Beasley <wibeasley@@hotmail.com>
#' 
#' @references This package's development was largely supported by the NIH
#' Grant 1R01HD65865, "NLSY Kinship Links: Reliable and Valid Sibling
#' Identification" (PI: Joe Rodgers)
#' 
#' Rodgers, Joseph Lee, & Kohler, Hans-Peter (2005).  Reformulating and
#' simplifying the DF analysis model.
#' \href{http://www.springerlink.com/content/n3x1v1q282583366/}{\emph{Behavior
#' Genetics, 35} (2), 211-217}.
#' 
#' Rodgers, J.L., Bard, D., Johnson, A., D'Onofrio, B., & Miller, W.B. (2008).
#' The Cross-Generational Mother-Daughter-Aunt-Niece Design: Establishing
#' Validity of the MDAN Design with NLSY Fertility Variables. \emph{Behavior
#' Genetics, 38}, 567-578.
#' 
#' D'Onofrio, B.M., Van Hulle, C.A., Waldman, I.D., Rodgers, J.L., Rathouz,
#' P.J., & Lahey, B.B. (2007). Causal inferences regarding prenatal alcohol
#' exposure and childhood externalizing problems. \emph{Archives of General
#' Psychiatry, 64}, 1296-1304.
#' 
#' Rodgers, J.L. & Doughty, D. (2000).  Genetic and environmental influences
#' on fertility expectations and outcomes using NLSY kinship data.  In J.L.
#' Rodgers, D. Rowe, & W.B. Miller (Eds.) \emph{Genetic influences on
#' fertility and sexuality.} Boston: Kluwer Academic Press.
#' 
#' Cleveland, H.H., Wiebe, R.P., van den Oord, E.J.C.G., & Rowe, D.C. (2000).
#' Behavior problems among children from different family structures: The
#' influence of genetic self-selection. \emph{Child Development, 71}, 733-751.
#' 
#' Rodgers, J.L., Rowe, D.C., & Buster, M. (1999). Nature, nurture, and first
#' sexual intercourse in the USA: Fitting behavioural genetic models to NLSY
#' kinship data. \emph{Journal of Biosocial Sciences, 31}.
#' 
#' Rodgers, J.L., Rowe, D.C., & Li, C. (1994). Beyond nature versus nurture:
#' DF analysis of nonshared influences on problem behaviors.
#' \emph{Developmental Psychology, 30}, 374-384.
#' @keywords package
#' @examples
#' 
#' library(NlsyLinks) #Load the package into the current R session.
#' data(Links79Pair)  #Load the dataset from the NlsyLinks package.
#' summary(Links79Pair)  #Summarize the five variables.
#' hist(Links79Pair$R)  #Display a histogram of the Relatedness values.
#' table(Links79Pair$R)  #Create a table of the Relatedness values for the whole sample.
#' 
NULL

