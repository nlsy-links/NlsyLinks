library(devtools)

devtools::document(roclets = c("collate",  "rd") ) #"namespace",
devtools::check_doc()
#  system("R CMD Rd2pdf --force --output=F:/Projects/RDev/NlsyLinksStaging/NlsyLinks/NlsyLinksDocumentationPeek.pdf F:/Projects/RDev/NlsyLinksStaging/NlsyLinks" )


run_examples()
run_examples(, "rv.Rd")
test()
check()
build()
