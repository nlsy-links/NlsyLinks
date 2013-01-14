library(Rd2roxygen)
options(roxygen.comment = "##' ")
#(info = parse_file( "F:/Projects/RDev/NlsyLinksStaging/NlsyLinks/man/NlsyLinks-package.Rd"))
(info = parse_file( "man/Links79PairExpanded.Rd"))
cat(create_roxygen(info), sep = "\n")

#Help files: https://github.com/hadley/devtools/wiki/docs-function

roc_proc(roclet, "R/NlsyLinks.R", base_path=".")

