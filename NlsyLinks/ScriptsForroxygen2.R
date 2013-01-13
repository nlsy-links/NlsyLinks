library(Rd2roxygen)
options(roxygen.comment = "##' ")
(info = parse_file( "F:/Projects/RDev/NlsyLinksStaging/NlsyLinks/man/Ace.Rd"))
cat(create_roxygen(info), sep = "\n")