rm(list = ls(all.names = TRUE))
# library(devtools)
deviceType <- ifelse(R.version$os=="linux-gnu", "X11", "windows")
options(device = deviceType) #http://support.rstudio.org/help/discussions/problems/80-error-in-function-only-one-rstudio-graphics-device-is-permitted

spelling::spell_check_package()
# spelling::update_wordlist()

devtools::document()
devtools::check_man() #Should return NULL
devtools::clean_vignettes()
devtools::build_vignettes()
# pkgdown::clean_site()
pkgdown::build_site()
system("R CMD Rd2pdf --no-preview --force --output=./documentation-peek.pdf ." )

checks_to_exclude <- c(
  "covr",
  "cyclocomp",
  "lintr_line_length_linter"
)
gp <-
  goodpractice::all_checks() |>
  purrr::discard(~(. %in% checks_to_exclude)) |>
  goodpractice::gp()
goodpractice::results(gp)
gp

devtools::run_examples(); dev.off() #This overwrites the NAMESPACE file too
# devtools::run_examples(, "redcap_read.Rd")
test_results_checked <- devtools::test()
# test_results_not_checked <- testthat::test_dir("./tests/manual/")


urlchecker::url_check(); urlchecker::url_update()

# devtools::build(args="--resave-data --no-build-vignetteszz")#args="--resave-data")

# devtools::check(force_suggests = FALSE)
devtools::check(cran=TRUE)
devtools::check( # Equivalent of R-hub
  manual    = TRUE,
  remote    = TRUE,
  incoming  = TRUE
)
devtools::check_rhub(email="wibeasley@hotmail.com")
# devtools::check_win_devel() # CRAN submission policies encourage the development version
# revdepcheck::revdep_check(num_workers = 4)
# devtools::release(check=FALSE) #Careful, the last question ultimately uploads it to CRAN, where you can't delete/reverse your decision.

mean(is.na(NlsyLinks::Links79PairExpanded[NlsyLinks::Links79PairExpanded$RelationshipPath=="Gen1Housemates", "RFull"]))
sum(is.na(NlsyLinks::Links79PairExpanded[NlsyLinks::Links79PairExpanded$RelationshipPath=="Gen1Housemates", "RFull"]))

# table(Links79Pair$RelationshipPath, Links79Pair$R)
