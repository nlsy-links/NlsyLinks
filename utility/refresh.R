rm(list=ls(all=TRUE))
# library(devtools)
deviceType <- ifelse(R.version$os=="linux-gnu", "X11", "windows")
options(device = deviceType) #http://support.rstudio.org/help/discussions/problems/80-error-in-function-only-one-rstudio-graphics-device-is-permitted

devtools::document()
devtools::check_man() #Should return NULL
pkgdown::build_site()
system("R CMD Rd2pdf --no-preview --force --output=./documentation-peek.pdf ." )

devtools::run_examples(); dev.off() #This overwrites the NAMESPACE file too
# devtools::run_examples(, "redcap_read.Rd")
test_results_checked <- devtools::test()
# test_results_not_checked <- testthat::test_dir("./tests/manual/")
devtools::clean_vignettes()
devtools::build_vignettes()
pkgdown::build_site()

# devtools::build(args="--resave-data --no-build-vignettes")#args="--resave-data")

# system("R CMD build --resave-data .") #Then move it up one directory.
# tarBallPattern <- "^NlsyLinks_.+\\.tar\\.gz$"
# file.copy(from=list.files(pattern=tarBallPattern), to="../", overwrite=TRUE)
# system(paste("R CMD check --as-cran", list.files(pattern=tarBallPattern, path="..//", full.names=TRUE)))
# unlink(list.files(pattern=tarBallPattern))
# unlink(list.files(pattern=tarBallPattern, path="..//", full.names=TRUE))
# unlink("NlsyLinks.Rcheck", recursive=T)
# system("R CMD check --as-cran D:/Projects/RDev/NlsyLinksStaging/NlsyLinks_1.300.tar.gz")

# devtools::check(force_suggests = FALSE)
# devtools::build_win(version="R-devel") #CRAN submission policies encourage the development version
# devtools::revdep_check(pkg="NlsyLinks", recursive=TRUE)
# devtools::release(check=FALSE) #Careful, the last question ultimately uploads it to CRAN, where you can't delete/reverse your decision.

mean(is.na(NlsyLinks::Links79PairExpanded[NlsyLinks::Links79PairExpanded$RelationshipPath=="Gen1Housemates", "RFull"]))
sum(is.na(NlsyLinks::Links79PairExpanded[NlsyLinks::Links79PairExpanded$RelationshipPath=="Gen1Housemates", "RFull"]))

# table(Links79Pair$RelationshipPath, Links79Pair$R)
