library(devtools)
options(device = "windows") #http://support.rstudio.org/help/discussions/problems/80-error-in-function-only-one-rstudio-graphics-device-is-permitted

devtools::document(roclets = c("collate", "namespace","rd") ) # #Remember to change this in RStudio too.
devtools::check_doc() #Should return NULL
#  system("R CMD Rd2pdf --force --output=./NlsyLinksDocumentationPeek.pdf ." )

devtools::run_examples(); dev.off() #This overwrites the NAMESPACE file too
# devtools::run_examples(, "Ace.Rd")
devtools::check_doc()
devtools::test()

# devtools::build(args="--resave-data")
system("R CMD build --resave-data")

#system("R CMD check D:/Projects/RDev/NlsyLinksStaging/NlsyLinks_1.205.tar.gz") #system("R CMD check F:/Projects/RDev/NlsyLinksStaging/NlsyLinks")
system("R CMD check --as-cran --no-clean D:/Projects/RDev/NlsyLinksStaging/NlsyLinks_1.205.tar.gz") #system("R CMD check F:/Projects/RDev/NlsyLinksStaging/NlsyLinks")
devtools::check(build_args="--resave-data")

devtools::revdep_check(pkg="NlsyLinks", recursive=TRUE)
# devtools::revdep_check(pkg="Wats", recursive=TRUE)
devtools::release(check=FALSE) #Careful, the last question ultimately uploads it to CRAN, where you can't delete/reverse your decision.
