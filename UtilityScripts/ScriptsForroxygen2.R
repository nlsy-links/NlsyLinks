library(Rd2roxygen)
options(roxygen.comment = "##' ")
#(info = parse_file( "./NlsyLinksStaging/NlsyLinks/man/NlsyLinks-package.Rd"))
(info = parse_file( "man/ExtraOutcomes79.Rd")) #Rd2roxygen
cat(create_roxygen(info), sep = "\n")

#Help files: https://github.com/hadley/devtools/wiki/docs-function

roc_proc(roclet, "R/NlsyLinks.R", base_path=".")

# (info = parse_file( "D:/Projects/RDev/Hadley/plyr/man/baseball.Rd"))
# cat(create_roxygen(info), sep = "\n")
