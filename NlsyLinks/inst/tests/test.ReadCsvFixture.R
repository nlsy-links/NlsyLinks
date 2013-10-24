
# filePathGen2 <- "./../extdata/Gen2Birth.csv" #"F:/Projects/RDev/NlsyLinksStaging/Datasets/Gen2Birth.csv"
# fileNameGen2 <- "Gen2Birth.csv"

# print(basename(normalizePath(".")))
# {
# if( basename(normalizePath("."))=="NlsyLinks" ) 
#   directory <- "./inst/extdata"
# else if( basename(normalizePath("."))=="tests" ) 
#   directory <- "./../extdata/"
# else
#   stop("The working directory is not recognized by this test fixture.")
# }
# basename(dirname(normalizePath(".")))
# basename((normalizePath(".")))

###########
context("Read CSV")
###########
test_that("Nlsy79Gen2", {  
#   ds <- ReadCsvNlsy79Gen2(filePath=file.path(directory, fileNameGen2))
  filePathGen2 <- file.path(inst("NlsyLinks"), "extdata", "Gen2Birth.csv") #"F:/Projects/RDev/NlsyLinksStaging/Datasets/Gen2Birth.csv"  
  ds <- ReadCsvNlsy79Gen2(filePath=filePathGen2)
  
  expect_equal(object=min(ds$SubjectTag), expected=201, scale=1)
  expect_equal(object=max(ds$SubjectTag), expected=1267501, scale=1)
  expect_true(all(ds$Generation==2))
  expect_equal(object=min(ds$SubjectTagOfMother), expected=200, scale=1)
  expect_equal(object=max(ds$SubjectTagOfMother), expected=1267500, scale=1)
  expect_equal(object=nrow(ds), expected=11495, scale=1)
})


#   dsOutcomes <- ExtraOutcomes79
#   dsOutcomes$SubjectTag <- CreateSubjectTag(subjectID=dsOutcomes$SubjectID,generation=dsOutcomes$Generation)
#   dsDF <- CreatePairLinksDoubleEntered(outcomeDataset=dsOutcomes, linksPairDataset=Links79Pair, outcomeNames=c("MathStandardized", "Weight", "WeightStandardized", "WeightStandardizedForAge19To25"))
#   expectedHSquared <- 0.9779665
#   expectedCSquared <- -0.02715555
#   expectedESquared <- 0.04918908
#   expectedRowCount <- 16588
#   
#   actual <- DeFriesFulkerMethod1(outcomeForSubject1=dsDF$MathStandardized_1, outcomeForSubject2=dsDF$MathStandardized_2, relatedness=dsDF$R)
#   expect_equal(object=actual$HSquared, expected=expectedHSquared, tolerance=1e-6, scale=1)
#   expect_equal(object=actual$CSquared, expected=expectedCSquared, tolerance=1e-6, scale=1)
#   expect_equal(object=actual$ESquared, expected=expectedESquared, tolerance=1e-6, scale=1)
#   expect_equal(object=actual$RowCount, expected=expectedRowCount, tolerance=1e-6, scale=1)
#   
#   actualFromWrapper <- AceUnivariate(outcomeForSubject1=dsDF$MathStandardized_1, outcomeForSubject2=dsDF$MathStandardized_2, relatedness=dsDF$R, method="DeFriesFulkerMethod1")
#   expect_equal(object=actualFromWrapper$HSquared, expected=expectedHSquared, tolerance=1e-6, scale=1)
#   expect_equal(object=actualFromWrapper$CSquared, expected=expectedCSquared, tolerance=1e-6, scale=1)
#   expect_equal(object=actualFromWrapper$ESquared, expected=expectedESquared, tolerance=1e-6, scale=1)
#   expect_equal(object=actualFromWrapper$RowCount, expected=expectedRowCount, tolerance=1e-6, scale=1)  

