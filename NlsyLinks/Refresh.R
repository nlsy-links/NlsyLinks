library(devtools)

devtools::document(roclets = c("rd") ) #  "collate","namespace",
devtools::check_doc()
#  system("R CMD Rd2pdf --force --output=F:/Projects/RDev/NlsyLinksStaging/NlsyLinks/NlsyLinksDocumentationPeek.pdf F:/Projects/RDev/NlsyLinksStaging/NlsyLinks" )

pkg <- as.package("F:/Projects/RDev/NlsyLinksStaging/NlsyLinks/")
devtools:::find_code(pkg)
cat(pkg$collate)


path_r <- file.path(pkg$path, "R")

code_paths <- dir(path_r, "\\.[Rrq]$", full.names = TRUE)  
r_files <- with_collate("C", sort(code_paths))


devtools::run_examples()
devtools::run_examples(, "rv.Rd")
test()
check()
build()
