rm(list=ls(all=TRUE)) #Clear all the variables before starting a new run.

require(testthat)
#test_dir("F:/Projects/RDev/NlsyLinksStaging/Static/tests")
#trace(ValidatePairLinks)
isDevelopmentBox <- Sys.info()["nodename"] == "GIMBLE"
if( isDevelopmentBox ) {
  directory <- "D:/Projects/RDev/NlsyLinksStaging"
  directoryTests <- file.path(directory, "NlsyLinks/inst/tests")
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
test_file(file.path(directoryTests, "test.AceLavaanGroupFixture.R"))

ClearMostVariables()
test_file(file.path(directoryTests, "test.AcePreparationFixture.R"))

ClearMostVariables()
test_file(file.path(directoryTests, "test.AceDFFixture.R"))

ClearMostVariables()
test_file(file.path(directoryTests, "test.AceWrapperExceptionFixture.R"))

ClearMostVariables()
test_file(file.path(directoryTests, "test.AceEstimationFixture.R"))

ClearMostVariables()
test_file(file.path(directoryTests, "test.CreatePairDatasetFixture.R"))

ClearMostVariables()
test_file(file.path(directoryTests, "test.OutcomeDatasetFixture.R"))

ClearMostVariables()
test_file(file.path(directoryTests, "test.CreatePairDatasetFixture.R"))

ClearMostVariables()
test_file(file.path(directoryTests, "test.ReadCsvFixture.R"))

ClearMostVariables()
source(file.path(directoryTests, "ExpectedVectors.R"))
test_file(file.path(directoryTests, "test.ColumnUtilitiesFixture.R"))

#expect_that(print("sss"), prints_text("sss"))
#expect_that(message("a"), shows_message("a"))
