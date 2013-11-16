options(digits=20)

###########
context("Lavaan")
###########
test_that("AceLavaanGroup -MathStandardized", {
  dsFull <- Links79PairExpanded #Start with the built-in data.frame in NlsyLinks
  oName_S1 <- "MathStandardized_S1" #Stands for Manifest1
  oName_S2 <- "MathStandardized_S2" #Stands for Manifest2
  dsFull <- dsFull[dsFull$RelationshipPath=='Gen2Siblings', ]
  
  dsGroupSummary <- RGroupSummary(dsFull, oName_S1, oName_S2)
#   rLevels <- dsGroupSummary[dsGroupSummary$Included, "R"]
  dsClean <- CleanSemAceDataset(dsDirty=dsFull, dsGroupSummary=dsGroupSummary, oName_S1=oName_S1, oName_S2=oName_S2)
#   dsClean
  
  ace <- AceLavaanGroup(dsClean)
  
  expectedASquared <- 0.66726524577656531889 #0.66726463036133044 #0.66818735332097090041 #0.670103215171409
  expectedCSquared  <- 0.11880724941394785188 #0.11880754807264618 #0.11812265118722645174 #0.11670604326754
  expectedESquared <- 0.21392750480948682923 #0.21392782156602341 #0.21368999549180262010 #0.213190741561051
  expectedCaseCount <- 8390 #8292
    
  expect_equal(object=ace@ASquared, expected=expectedASquared, scale=1)
  expect_equal(object=ace@CSquared, expected=expectedCSquared, scale=1)
  expect_equal(object=ace@ESquared, expected=expectedESquared, scale=1)
  expect_equal(object=ace@CaseCount, expected=expectedCaseCount, scale=1)
  expect_equal(object=slot(ace, "CaseCount"), expected=expectedCaseCount, scale=1)
  expect_true(object=slot(ace, "Unity"))
  expect_true(object=slot(ace, "WithinBounds"))
})
test_that("AceLavaanGroup -HeightZGenderAge", {
  dsFull <- Links79PairExpanded #Start with the built-in data.frame in NlsyLinks
  oName_S1 <- "HeightZGenderAge_S1"
  oName_S2 <- "HeightZGenderAge_S2"
  dsFull <- dsFull[dsFull$RelationshipPath=='Gen2Siblings', ]
  
  dsGroupSummary <- RGroupSummary(dsFull, oName_S1, oName_S2)
  #   rLevels <- dsGroupSummary[dsGroupSummary$Included, "R"]
  dsClean <- CleanSemAceDataset(dsDirty=dsFull, dsGroupSummary=dsGroupSummary, oName_S1=oName_S1, oName_S2=oName_S2)
  
  ace <- AceLavaanGroup(dsClean)
  
  expectedASquared <- 0.78569416052626706026 #0.785693984682088
  expectedCSquared  <- 0.03207961688916031312 #0.0320796864720722
  expectedESquared <- 0.18222622258457257804 #0.18222632884584
  expectedCaseCount <- 5884
  
  expect_equal(object=ace@ASquared, expected=expectedASquared, scale=1)
  expect_equal(object=ace@CSquared, expected=expectedCSquared, scale=1)
  expect_equal(object=ace@ESquared, expected=expectedESquared, scale=1)
  expect_equal(object=ace@CaseCount, expected=expectedCaseCount, scale=1)
  expect_true(object=slot(ace, "Unity"))
  expect_true(object=slot(ace, "WithinBounds"))
})
# test_that("AceLavaanGroup -WeightStandardizedForAge19To25", {
#   dsFull <- Links79PairExpanded #Start with the built-in data.frame in NlsyLinks
#   oName_S1 <- "WeightStandardizedForAge19To25_S1"
#   oName_S2 <- "WeightStandardizedForAge19To25_S2"
#   dsFull <- dsFull[dsFull$RelationshipPath=='Gen2Siblings', ]
#   
#   dsGroupSummary <- RGroupSummary(dsFull, oName_S1, oName_S2)
# #   rLevels <- dsGroupSummary[dsGroupSummary$Included, "R"]
#   dsClean <- CleanSemAceDataset(dsDirty=dsFull, dsGroupSummary=dsGroupSummary, oName_S1=oName_S1, oName_S2=oName_S2)
#   
#   ace <- AceLavaanGroup(dsClean)
#   
#   expectedASquared <- 0.68859786571166337 #.68764112310158664876 #0.687801119966999
#   expectedCSquared  <- 2.0347745721123465e-17 #1.6026541226325013592e-17 #7.10884537223939e-15
#   expectedESquared <- 0.31140213428833668 #.31235887689841324022 #0.312198880032994
#   expectedCaseCount <- 3479 #3478
#   
#   expect_equal(object=ace@ASquared, expected=expectedASquared, scale=1)
#   expect_equal(object=ace@CSquared, expected=expectedCSquared, scale=1)
#   expect_equal(object=ace@ESquared, expected=expectedESquared, scale=1)
#   expect_equal(object=ace@CaseCount, expected=expectedCaseCount, scale=1)
#   expect_true(object=slot(ace, "Unity"))
#   expect_true(object=slot(ace, "WithinBounds"))
# })
# str_c(ace@ASquared)
# str_c(ace@CSquared)
# str_c(ace@ESquared)
# str_c(ace@CaseCount)
