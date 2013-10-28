library(devtools)
options(device = "windows") #http://support.rstudio.org/help/discussions/problems/80-error-in-function-only-one-rstudio-graphics-device-is-permitted

devtools::document(roclets = c("collate", "namespace","rd") ) # #Remember to change this in RStudio too.
devtools::check_doc() #Should return NULL
#  system("R CMD Rd2pdf --force --output=./NlsyLinksDocumentationPeek.pdf ." )

devtools::run_examples(); dev.off() #This overwrites the NAMESPACE file too
# devtools::run_examples(, "Ace.Rd")
devtools::check_doc()
devtools::test()
devtools::build()
devtools::check()
devtools::revdep_check(pkg="NlsyLinks", recursive=TRUE)
# devtools::revdep_check(pkg="Wats", recursive=TRUE)
devtools::release()
