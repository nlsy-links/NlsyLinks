
###########
context("DF Method 1")
###########
test_that("DFMethod1 -MathStandardized", {
  dsOutcomes <- ExtraOutcomes79
  dsOutcomes$SubjectTag <- CreateSubjectTag(subjectID=dsOutcomes$SubjectID,generation=dsOutcomes$Generation)
  dsFull <- Links79Pair[Links79Pair$RelationshipPath=='Gen2Siblings', ]
  dsDF <- CreatePairLinksDoubleEntered(outcomeDataset=dsOutcomes, linksPairDataset=dsFull, outcomeNames=c("MathStandardized", "WeightZGenderAge"))
  expectedASquared <- 0.97281725241557127#0.97878157157751255468
  expectedCSquared <- -0.02425670538213379 #-0.026817134106613928907
  expectedESquared <- 0.051439452966562493 #0.048035562529101349938
  expectedRowCount <- 16784
  unique(dsDF$R)
  #dsDF <- dsDF[dsDF$R %in% c(0, .25, .375, .5, 1), ]  
  oName_1 <- "MathStandardized_1"
  oName_2 <- "MathStandardized_2"  
  
  actual <- DeFriesFulkerMethod1(dataSet=dsDF, oName_1=oName_1, oName_2=oName_2)  
  #actual <- DeFriesFulkerMethod1(outcomeForSubject1=dsDF$MathStandardized_1, outcomeForSubject2=dsDF$MathStandardized_2, relatedness=dsDF$R)
  expect_equal(object=slot(actual, "ASquared"), expected=expectedASquared, tolerance=1e-6, scale=1)
  expect_equal(object=slot(actual, "CSquared"), expected=expectedCSquared, tolerance=1e-6, scale=1)
  expect_equal(object=slot(actual, "ESquared"), expected=expectedESquared, tolerance=1e-6, scale=1)  
  expect_equal(object=slot(actual, "CaseCount"), expected=expectedRowCount, tolerance=1e-6, scale=1)
  expect_true(object=slot(actual, "Unity"))
  expect_false(object=slot(actual, "WithinBounds"))
  #expect_equal(object=actual$ASquared, expected=expectedASquared, tolerance=1e-6, scale=1)
  
  
  actualFromWrapper <- AceUnivariate(method="DeFriesFulkerMethod1", dataSet=dsDF, oName_1=oName_1, oName_2=oName_2)
  #actualFromWrapper <- AceUnivariate(outcomeForSubject1=dsDF$MathStandardized_1, outcomeForSubject2=dsDF$MathStandardized_2, relatedness=dsDF$R, method="DeFriesFulkerMethod1")
  expect_equal(object=slot(actualFromWrapper, "ASquared"), expected=expectedASquared, tolerance=1e-6, scale=1)
  expect_equal(object=slot(actualFromWrapper, "CSquared"), expected=expectedCSquared, tolerance=1e-6, scale=1)
  expect_equal(object=slot(actualFromWrapper, "ESquared"), expected=expectedESquared, tolerance=1e-6, scale=1)
  expect_equal(object=slot(actualFromWrapper, "CaseCount"), expected=expectedRowCount, tolerance=1e-6, scale=1)
  expect_true(object=slot(actualFromWrapper, "Unity"))
  expect_false(object=slot(actualFromWrapper, "WithinBounds"))
})

# test_that("DFMethod1 -WeightZGenderAge", {
#   dsOutcomes <- ExtraOutcomes79
#   dsOutcomes$SubjectTag <- CreateSubjectTag(subjectID=dsOutcomes$SubjectID,generation=dsOutcomes$Generation)
#   dsFull <- Links79Pair[Links79Pair$RelationshipPath=='Gen2Siblings', ]
#   dsDF <- CreatePairLinksDoubleEntered(outcomeDataset=dsOutcomes, linksPairDataset=dsFull, outcomeNames=c("MathStandardized", "WeightZGenderAge"))
#   expectedASquared <- 0.67402146265628393 
#   expectedCSquared <- -0.013283359091640816 
#   expectedESquared <- 0.33926189643535687 
#   expectedRowCount <- 6958
#   oName_1 <- "WeightZGenderAge_1"
#   oName_2 <- "WeightZGenderAge_2"
#   
#   dsDF$WeightZGenderAge_1
#   dsDF[, c(oName_1, oName_2)]
#   
#   actual <- DeFriesFulkerMethod1(dataSet=dsDF, oName_1=oName_1, oName_2=oName_2)  
#   expect_equal(object=slot(actual, "ASquared"), expected=expectedASquared, tolerance=1e-6, scale=1)
#   expect_equal(object=slot(actual, "CSquared"), expected=expectedCSquared, tolerance=1e-6, scale=1)
#   expect_equal(object=slot(actual, "ESquared"), expected=expectedESquared, tolerance=1e-6, scale=1)  
#   expect_equal(object=slot(actual, "CaseCount"), expected=expectedRowCount, tolerance=1e-6, scale=1)
#   expect_true(object=slot(actual, "Unity"))
#   expect_false(object=slot(actual, "WithinBounds"))
#   #expect_equal(object=actual$ASquared, expected=expectedASquared, tolerance=1e-6, scale=1)
#   
#   
#   actualFromWrapper <- AceUnivariate(method="DeFriesFulkerMethod1", dataSet=dsDF, oName_1=oName_1, oName_2=oName_2)
#   expect_equal(object=slot(actualFromWrapper, "ASquared"), expected=expectedASquared, tolerance=1e-6, scale=1)
#   expect_equal(object=slot(actualFromWrapper, "CSquared"), expected=expectedCSquared, tolerance=1e-6, scale=1)
#   expect_equal(object=slot(actualFromWrapper, "ESquared"), expected=expectedESquared, tolerance=1e-6, scale=1)
#   expect_equal(object=slot(actualFromWrapper, "CaseCount"), expected=expectedRowCount, tolerance=1e-6, scale=1)
#   expect_true(object=slot(actualFromWrapper, "Unity"))
#   expect_false(object=slot(actualFromWrapper, "WithinBounds"))
# })



###########
context("DF Method 3")
###########
test_that("DFMethod3 -MathStandardized", {
  dsOutcomes <- ExtraOutcomes79
  dsOutcomes$SubjectTag <- CreateSubjectTag(subjectID=dsOutcomes$SubjectID,generation=dsOutcomes$Generation)
  dsFull <- Links79Pair[Links79Pair$RelationshipPath=='Gen2Siblings', ]
  dsDF <- CreatePairLinksDoubleEntered(outcomeDataset=dsOutcomes, linksPairDataset=dsFull, outcomeNames=c("MathStandardized", "WeightZGenderAge"))
  expectedASquared <- 0.84796879015144833 
  expectedCSquared <- 0.044772351172503257 
  expectedESquared <- 0.10725885867604845 
  expectedRowCount <- 16784
  #dsDF <- dsDF[dsDF$R %in% c(0, .25, .375, .5, 1), ]
  oName_1 <- "MathStandardized_1"
  oName_2 <- "MathStandardized_2"  
  
  actual <- DeFriesFulkerMethod3(dataSet=dsDF, oName_1=oName_1, oName_2=oName_2)
  expect_equal(object=slot(actual, "ASquared"), expected=expectedASquared, tolerance=1e-6, scale=1)
  expect_equal(object=slot(actual, "CSquared"), expected=expectedCSquared, tolerance=1e-6, scale=1)
  expect_equal(object=slot(actual, "ESquared"), expected=expectedESquared, tolerance=1e-6, scale=1)  
  expect_equal(object=slot(actual, "CaseCount"), expected=expectedRowCount, tolerance=1e-6, scale=1)
  expect_true(object=slot(actual, "Unity"))
  expect_true(object=slot(actual, "WithinBounds"))
  #expect_equal(object=actual$ASquared, expected=expectedASquared, tolerance=1e-6, scale=1)
  
  actualFromWrapper <- AceUnivariate(method="DeFriesFulkerMethod3", dataSet=dsDF, oName_1=oName_1, oName_2=oName_2)
  expect_equal(object=slot(actualFromWrapper, "ASquared"), expected=expectedASquared, tolerance=1e-6, scale=1)
  expect_equal(object=slot(actualFromWrapper, "CSquared"), expected=expectedCSquared, tolerance=1e-6, scale=1)
  expect_equal(object=slot(actualFromWrapper, "ESquared"), expected=expectedESquared, tolerance=1e-6, scale=1)
  expect_equal(object=slot(actualFromWrapper, "CaseCount"), expected=expectedRowCount, tolerance=1e-6, scale=1)
  expect_true(object=slot(actualFromWrapper, "Unity"))
  expect_true(object=slot(actualFromWrapper, "WithinBounds"))
})



# test_that("DFMethod3 -WeightStandardizedAdult", {
#   dsOutcomes <- ExtraOutcomes79
#   dsOutcomes$SubjectTag <- CreateSubjectTag(subjectID=dsOutcomes$SubjectID,generation=dsOutcomes$Generation)
#   dsFull <- Links79Pair[Links79Pair$RelationshipPath=='Gen2Siblings', ]
#   dsDF <- CreatePairLinksDoubleEntered(outcomeDataset=dsOutcomes, linksPairDataset=dsFull, outcomeNames=c("MathStandardized", "Weight", "WeightStandardized", "WeightStandardizedForAge19To25"))
#   expectedASquared <- 0.64047731125483631 
#   expectedCSquared <- 0.0035255270911337348 
#   expectedESquared <- 0.35599716165402995 
#   expectedRowCount <- 6958
#   #dsDF <- dsDF[dsDF$R %in% c(0, .25, .375, .5, 1), ]
#   oName_1 <- "WeightStandardizedForAge19To25_1"
#   oName_2 <- "WeightStandardizedForAge19To25_2"  
#   
#   actual <- DeFriesFulkerMethod3(dataSet=dsDF, oName_1=oName_1, oName_2=oName_2)
#   expect_equal(object=slot(actual, "ASquared"), expected=expectedASquared, tolerance=1e-6, scale=1)
#   expect_equal(object=slot(actual, "CSquared"), expected=expectedCSquared, tolerance=1e-6, scale=1)
#   expect_equal(object=slot(actual, "ESquared"), expected=expectedESquared, tolerance=1e-6, scale=1)  
#   expect_equal(object=slot(actual, "CaseCount"), expected=expectedRowCount, tolerance=1e-6, scale=1)
#   expect_true(object=slot(actual, "Unity"))
#   expect_true(object=slot(actual, "WithinBounds"))
#   #expect_equal(object=actual$ASquared, expected=expectedASquared, tolerance=1e-6, scale=1)
#   
#   actualFromWrapper <- AceUnivariate(method="DeFriesFulkerMethod3", dataSet=dsDF, oName_1=oName_1, oName_2=oName_2)
#   expect_equal(object=slot(actualFromWrapper, "ASquared"), expected=expectedASquared, tolerance=1e-6, scale=1)
#   expect_equal(object=slot(actualFromWrapper, "CSquared"), expected=expectedCSquared, tolerance=1e-6, scale=1)
#   expect_equal(object=slot(actualFromWrapper, "ESquared"), expected=expectedESquared, tolerance=1e-6, scale=1)
#   expect_equal(object=slot(actualFromWrapper, "CaseCount"), expected=expectedRowCount, tolerance=1e-6, scale=1)
#   expect_true(object=slot(actualFromWrapper, "Unity"))
#   expect_true(object=slot(actualFromWrapper, "WithinBounds"))
# })
