library(devtools)
options(device = "windows") #http://support.rstudio.org/help/discussions/problems/80-error-in-function-only-one-rstudio-graphics-device-is-permitted

devtools::document(roclets = c("collate", "namespace","rd") ) #Remember to change this in RStudio too.
devtools::check_doc() #Should return NULL
#  system("R CMD Rd2pdf --force --output=F:/Projects/RDev/NlsyLinksStaging/NlsyLinks/NlsyLinksDocumentationPeek.pdf F:/Projects/RDev/NlsyLinksStaging/NlsyLinks" )


devtools::run_examples() #This overwrites the NAMESPACE file too
# devtools::run_examples(, "Ace.Rd")
test()
build()
check()
release()
