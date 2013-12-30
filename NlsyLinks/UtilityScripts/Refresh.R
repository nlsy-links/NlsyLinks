rm(list=ls(all=TRUE))
require(devtools)
# setwd("~nlsylinks/pkg")
options(device = "windows") #http://support.rstudio.org/help/discussions/problems/80-error-in-function-only-one-rstudio-graphics-device-is-permitted

#devtools::build()#args="--resave-data")
devtools::build(args="--resave-data --no-build-vignettes")
devtools::document(roclets = c("collate", "namespace", "rd"), clean=T, reload=T) # #Remember to change this in RStudio too.
devtools::check_doc() #Should return NULL
#  system("R CMD Rd2pdf --force --output=./NlsyLinksDocumentationPeek.pdf ." )
#
devtools::run_examples(); dev.off() #This overwrites the NAMESPACE file too
# devtools::run_examples(, "Ace.Rd")
devtools::test()

devtools::build(args="--resave-data --no-build-vignettes")#args="--resave-data")
# system("R CMD build --resave-data")


system("R CMD build --resave-data D:/Projects/RDev/NlsyLinksStaging/NlsyLinks") #Then move it up one directory.
system("R CMD check --as-cran D:/Projects/RDev/NlsyLinksStaging/NlsyLinks_1.302.tar.gz")

#system("R CMD check D:/Projects/RDev/NlsyLinksStaging/NlsyLinks")
devtools::check()#build_args="--resave-data")
# devtools::check(build_args="--as-cran")

# devtools::build_win(version="R-devel") #CRAN submission policies encourage the development version
devtools::revdep_check(pkg="NlsyLinks", recursive=TRUE)
# devtools::revdep_check(pkg="Wats", recursive=TRUE)
# devtools::release(check=FALSE) #Careful, the last question ultimately uploads it to CRAN, where you can't delete/reverse your decision.

mean(is.na(NlsyLinks::Links79PairExpanded[NlsyLinks::Links79PairExpanded$RelationshipPath=="Gen1Housemates", "RFull"]))
sum(is.na(NlsyLinks::Links79PairExpanded[NlsyLinks::Links79PairExpanded$RelationshipPath=="Gen1Housemates", "RFull"]))

# table(Links79Pair$RelationshipPath, Links79Pair$R)
