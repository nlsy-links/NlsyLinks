#' @title Utilities and kinship information for Behavior Genetics and Developmental research using the NLSY.
#'
#' @description Utilities and kinship information for Behavior Genetics and Developmental research using the NLSY.
#' Researchers and grad students interested using the [NLSY](http://www.bls.gov/nls/) for Behavior Genetics and family research, please start with our 2016 article,
#' '[*The NLSY Kinship Links: Using the NLSY79 and NLSY-Children Data to Conduct Genetically-Informed and Family-Oriented Research*](https://link.springer.com/article/10.1007/s10519-016-9785-3).
#'
#' @docType package
#'
#' @name NlsyLinks-package
#'
#' @aliases NlsyLinks
#'
#' @note This package considers both Gen1 and Gen2 subjects.  "Gen1" refers to
#' subjects in the original NLSY79 sample
#' (http://www.bls.gov/nls/nlsy79.htm).  "Gen2" subjects are the
#' biological children of the Gen1 females -ie, those in the NLSY79 Children
#' and Young Adults sample (http://www.bls.gov/nls/nlsy79ch.htm).
#'
#' The release version is available through [CRAN](https://cran.r-project.org/package=NlsyLinks) by
#' running `install.packages('NlsyLinks')`.
#' The most recent development version is available through [GitHub](https://github.com/nlsy-links/NlsyLinks) by
#' running
#' `devtools::install_github` `(repo = 'nlsy-links/NlsyLinks')`
#' (make sure [devtools](https://cran.r-project.org/package=devtools) is already installed).
#' If you're having trouble with the package, please install the development version.  If this doesn't solve
#' your problem, please create a [new issue](https://github.com/nlsy-links/NlsyLinks/issues), or email Will.
#'
#' @author
#' [William Howard Beasley](http://scholar.google.com/citations?user=ffsJTC0AAAAJ) ([Howard Live Oak LLC](), Norman)
#'
#' [Joseph Lee Rodgers](http://www.vanderbilt.edu/psychological_sciences/bio/joe-rodgers) (Vanderbilt University, Nashville)
#'
#' [David Bard](https://medicine.ouhsc.edu/Academic-Departments/Pediatrics/Sections/Developmental-Behavioral-Pediatrics/Faculty/david-e-bard-phd) (University of Oklahoma Health Sciences Center, OKC)
#'
#' Kelly Meredith (Oklahoma City University, OKC)
#'
#' [Michael D. Hunter](http://mhuntero.com/) (University of Oklahoma, Norman)
#'
#' Maintainer: Will Beasley <wibeasley@@hotmail.com>
#'
#' @references This package's development was largely supported by the NIH
#' Grant 1R01HD65865, ["NLSY Kinship Links: Reliable and Valid Sibling
#' Identification"](http://taggs.hhs.gov/AwardDetail.cfm?s_Award_Num=R01HD065865&n_Prog_Office_Code=50)
#' (PI: Joe Rodgers).  A more complete list of research articles
#' using NLSY Kinship Links is maintained on our [package's
#' website](http://nlsy-links.github.io/NlsyLinks/research-publications.html).
#'
#' Rodgers, Joseph Lee, & Kohler, Hans-Peter (2005).
#' [Reformulating and simplifying the DF analysis model](https://pubmed.ncbi.nlm.nih.gov/15685433/).
#' *Behavior Genetics, 35* (2), 211-217.
#'
#' Rodgers, J.L., Bard, D., Johnson, A., D'Onofrio, B., & Miller, W.B. (2008).
#' [The Cross-Generational Mother-Daughter-Aunt-Niece Design: Establishing
#' Validity of the MDAN Design with NLSY Fertility Variables.](http://www.ncbi.nlm.nih.gov/pubmed/18825497).
#' *Behavior Genetics, 38*, 567-578.
#'
#' D'Onofrio, B.M., Van Hulle, C.A., Waldman, I.D., Rodgers, J.L., Rathouz,
#' P.J., & Lahey, B.B. (2007). [Causal inferences regarding prenatal alcohol
#' exposure and childhood externalizing problems.](http://www.ncbi.nlm.nih.gov/pubmed/17984398).
#' *Archives of General Psychiatry, 64*, 1296-1304.
#'
#' Rodgers, J.L. & Doughty, D. (2000).  [Genetic and environmental influences
#' on fertility expectations and outcomes using NLSY kinship data.](http://link.springer.com/chapter/10.1007\%2F978-1-4615-4467-8_6)
#' In J.L. Rodgers, D. Rowe, & W.B. Miller (Eds.)
#' *Genetic influences on fertility and sexuality.* Boston: Kluwer Academic Press.
#'
#' Cleveland, H.H., Wiebe, R.P., van den Oord, E.J.C.G., & Rowe, D.C. (2000).
#' [Behavior problems among children from different family structures: The
#' influence of genetic self-selection.](http://www.ncbi.nlm.nih.gov/pubmed/10953940)
#' *Child Development, 71*, 733-751.
#'
#' Rodgers, J.L., Rowe, D.C., & Buster, M. (1999). [Nature, nurture, and first
#' sexual intercourse in the USA: Fitting behavioural genetic models to NLSY
#' kinship data](https://pubmed.ncbi.nlm.nih.gov/10081235/).
#' *Journal of Biosocial Sciences, 31*.
#'
#' Rodgers, J.L., Rowe, D.C., & Li, C. (1994). [Beyond nature versus nurture:
#' DF analysis of nonshared influences on problem behaviors.](http://psycnet.apa.org/journals/dev/30/3/374/)
#' *Developmental Psychology, 30*, 374-384.
#'
#' @keywords package
#'
#' @examples
#' library(NlsyLinks)    # Load the package into the current R session.
#' summary(Links79Pair)  # Summarize the five variables.
#' hist(Links79Pair$R)   # Display a histogram of the Relatedness values.
#' table(Links79Pair$R)  # Create a table of the Relatedness values for the whole sample.
#'
#' \dontrun{
#' # Install/update NlsyLinks with the release version from CRAN.
#' install.packages('NlsyLinks')
#'
#' # Install/update NlsyLinks with the development version from GitHub
#' #install.packages('devtools') #Uncomment if 'devtools' isn't installed already.
#' devtools::install_github('nlsy-links/NlsyLinks')
#' }
NULL
