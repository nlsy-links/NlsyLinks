rm(list=ls(all=TRUE)) #Clear all the variables before starting a new run.

require(testthat)
#test_dir("F:/Projects/RDev/NlsyLinksStaging/Static/tests")
#trace(ValidatePairLinks)
isDevelopmentBox <- Sys.info()["nodename"] == "MICKEY"
if( isDevelopmentBox ) {
  directory <- "F:/Projects/RDev/NlsyLinksStaging"
  directoryTests <- file.path(directory, "Static/inst/tests")
  pathToBeIncorporated <- file.path(directory, "Content/ToBeIncorporated.R")
}
if( !isDevelopmentBox ) {
  directory <- path.package("NlsyLinks")
  directoryTests <- file.path(directory, "tests")
}


ClearMostVariables <- function( ) {
  rm(list=ls(all=TRUE)[!(ls(all=TRUE) %in% c("ClearMostVariables", "directoryTests", "pathToBeIncorporated") )])
}

try(detach("package:NlsyLinks"), silent=TRUE)
require(NlsyLinks)
#?NlsyLinks

#source(pathToBeIncorporated)

ClearMostVariables()
test_file(file.path(directoryTests, "AceLavaanGroupFixture.R"))

ClearMostVariables()
test_file(file.path(directoryTests, "AcePreparationFixture.R"))

ClearMostVariables()
test_file(file.path(directoryTests, "AceDFFixture.R"))

ClearMostVariables()
test_file(file.path(directoryTests, "AceWrapperExceptions.R"))

ClearMostVariables()
test_file(file.path(directoryTests, "AceEstimationFixture.R"))

ClearMostVariables()
test_file(file.path(directoryTests, "CreatePairDatasetFixture.R"))

ClearMostVariables()
test_file(file.path(directoryTests, "OutcomeDatasetFixture.R"))

ClearMostVariables()
test_file(file.path(directoryTests, "CreatePairDatasetFixture.R"))

ClearMostVariables()
test_file(file.path(directoryTests, "ReadCsvFixture.R"))

ClearMostVariables()
source(file.path(directoryTests, "ExpectedVectors.R"))
test_file(file.path(directoryTests, "ColumnUtilitiesFixture.R"))

#expect_that(print("sss"), prints_text("sss"))
#expect_that(message("a"), shows_message("a"))

