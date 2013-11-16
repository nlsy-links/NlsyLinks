
###########
context("Clean Ace Sem Dataset")
###########
test_that("CleanSemAceDataset MathStandardized", {
  dsFull <- Links79PairExpanded #Start with the built-in data.frame in NlsyLinks
  oName_S1 <- "MathStandardized_S1" 
  oName_S2 <- "MathStandardized_S2"
  dsFull <- dsFull[dsFull$RelationshipPath=='Gen2Siblings', ]
  dsGroupSummary <- RGroupSummary(dsFull, oName_S1, oName_S2)
  
  dsClean <- CleanSemAceDataset( dsDirty=dsFull, dsGroupSummary, oName_S1, oName_S2, rName="R" )
  
  expectedRowCount <- 8390
  expectedColumnNames <- c('R', 'O1', 'O2', 'GroupID')
  expectedCompleteRows <- expectedRowCount
  expectedMeanR <- 0.418250893921335 #0.41819129916567343574
  expectedMeanO1 <- 98.0691299165673 #98.069129916567348459
  expectedMeanO2 <- 98.5668653158522 #98.566865315852211893
  expectedMeanGroupID <- 2.33814064362336 #2.3376638855780691451
  
  expect_equal(object=nrow(dsClean), expected=expectedRowCount, scale=1)
  expect_equal(object=colnames(dsClean), expected=expectedColumnNames, scale=1)
  expect_equal(object=mean(dsClean$R), expected=expectedMeanR, scale=1)
  expect_equal(object=mean(dsClean$O1), expected=expectedMeanO1, scale=1)
  expect_equal(object=mean(dsClean$O2), expected=expectedMeanO2, scale=1)
  expect_equal(object=mean(dsClean$GroupID), expected=expectedMeanGroupID, scale=1)  
  expect_equal(object=nrow(subset(dsClean, !is.na(R) & !is.na(O1) & !is.na(O2) & !is.na(GroupID))), expected=expectedCompleteRows, scale=1)
})
test_that("CleanSemAceDataset HeightZGenderAge", {
  dsFull <- Links79PairExpanded #Start with the built-in data.frame in NlsyLinks
  oName_S1 <- "HeightZGenderAge_S1" 
  oName_S2 <- "HeightZGenderAge_S2" 
  dsFull <- dsFull[dsFull$RelationshipPath=='Gen2Siblings', ]
  dsGroupSummary <- RGroupSummary(dsFull, oName_S1, oName_S2)
  
  dsClean <- CleanSemAceDataset( dsDirty=dsFull, dsGroupSummary, oName_S1, oName_S2, rName="R" )
  
  expectedRowCount <- 5884
  expectedColumnNames <- c('R', 'O1', 'O2', 'GroupID')
  expectedCompleteRows <- expectedRowCount
  expectedMeanR <- 0.421269544527532
  expectedMeanO1 <- -0.0241219488333721
  expectedMeanO2 <- -0.0516293302405181
  expectedMeanGroupID <- 2.36199864038069
  
  expect_equal(object=nrow(dsClean), expected=expectedRowCount, scale=1)
  expect_equal(object=colnames(dsClean), expected=expectedColumnNames, scale=1)
  expect_equal(object=mean(dsClean$R), expected=expectedMeanR, scale=1)
  expect_equal(object=mean(dsClean$O1), expected=expectedMeanO1, scale=1)
  expect_equal(object=mean(dsClean$O2), expected=expectedMeanO2, scale=1)
  expect_equal(object=mean(dsClean$GroupID), expected=expectedMeanGroupID, scale=1)
  expect_equal(object=nrow(subset(dsClean, !is.na(R) & !is.na(O1) & !is.na(O2) & !is.na(GroupID))), expected=expectedCompleteRows, scale=1)
})

###########
context("R Group Summary")
###########
test_that("Group Summary MathStandardized", {
  dsFull <- Links79PairExpanded #Start with the built-in data.frame in NlsyLinks
  oName_S1 <- "MathStandardized_S1" #Stands for Manifest1
  oName_S2 <- "MathStandardized_S2" #Stands for Manifest2
   
  dsFull <- dsFull[dsFull$RelationshipPath=='Gen2Siblings', ]
  dsGroupSummary <- RGroupSummary(dsFull, oName_S1, oName_S2)
  
  expectedRowCount <- 5
  expectedColumnNames <- c('R', 'Included', 'PairCount', 'O1Mean', 'O2Mean', 'O1Variance', 'O2Variance', 'O1O2Covariance', 'Correlation', 'Determinant', 'PosDefinite')
  expectedR <- c(.25, .375, .5, .75, 1)
  expectedIncluded <- c(T, T, T, F, T)
  expectedPairCount <- c(2718, 139, 5511, 2, 22)
  expectedO1Mean <- c(94.6438557763061, 92.6043165467626, 99.894030121575, 108.5, 98.6363636363636)
  expectedO2Mean <- c(95.5989698307579, 93.1654676258993, 100.178914897478, 106, 95.5454545454545)
  expectedO1Variance <- c(169.650074490786, 172.530705870087, 230.503831867695, 220.5, 319.194805194805)
  expectedO2Variance <- c(207.842060035159, 187.081117714524, 232.970887461177, 18, 343.116883116883)
  expectedO1O2Covariance <- c(41.0783227074618, 40.4789907204671, 107.370687168807, 63, 277.588744588745)
  expectedCorrelation <- c(0.218760524458128, 0.22531053457515, 0.463335771451437, 1, 0.838789337853393)
  expectedDeterminant <- c(33572.9923708246, 30638.6886045039, 42172.2178103171, 0, 32465.6155431869)
  expectedPosDefinite <- expectedIncluded
    
  expect_equal(object=nrow(dsGroupSummary), expected=expectedRowCount, scale=1)
  expect_equal(object=colnames(dsGroupSummary), expected=expectedColumnNames, scale=1)
  expect_equal(object=dsGroupSummary$R, expected=expectedR, scale=1)
  expect_equal(object=dsGroupSummary$Included, expected=expectedIncluded, scale=1)
  expect_equal(object=dsGroupSummary$PairCount, expected=expectedPairCount, scale=1)
  expect_equal(object=dsGroupSummary$O1Mean, expected=expectedO1Mean, scale=1)
  expect_equal(object=dsGroupSummary$O2Mean, expected=expectedO2Mean, scale=1)
  expect_equal(object=dsGroupSummary$O1Variance, expected=expectedO1Variance, scale=1)
  expect_equal(object=dsGroupSummary$O2Variance, expected=expectedO2Variance, scale=1)
  expect_equal(object=dsGroupSummary$O1O2Covariance, expected=expectedO1O2Covariance, scale=1)
  expect_equal(object=dsGroupSummary$Correlation, expected=expectedCorrelation, scale=1)
  expect_equal(object=dsGroupSummary$Determinant, expected=expectedDeterminant, scale=1)
  expect_equal(object=dsGroupSummary$PosDefinite, expected=expectedPosDefinite, scale=1)
})
test_that("Group Summary HeightZGenderAge", {
  dsFull <- Links79PairExpanded #Start with the built-in data.frame in NlsyLinks
  oName_S1 <- "HeightZGenderAge_S1"
  oName_S2 <- "HeightZGenderAge_S2"
  
  dsFull <- dsFull[dsFull$RelationshipPath=='Gen2Siblings', ]
  dsGroupSummary <- RGroupSummary(dsFull, oName_S1, oName_S2)
  
  expectedRowCount <- 5
  expectedColumnNames <- c('R', 'Included', 'PairCount', 'O1Mean', 'O2Mean', 'O1Variance', 'O2Variance', 'O1O2Covariance', 'Correlation', 'Determinant', 'PosDefinite')
  expectedR <- c(.25, .375, .5, .75, 1)
  expectedIncluded <- c(T, T, T, F, T)
  expectedPairCount <- c(1862, 46, 3960, 0, 16)
  expectedO1Mean <- c(-0.0656364953267334, 0.220021924023091, -0.00701925535792626, NA, -0.127696870303618)
  expectedO2Mean <- c(-0.0810552319003634, -0.105982711665083, -0.036536374677054, NA, -0.206430554937734)
  expectedO1Variance <- c(1.03961715337558, 1.06618758435256, 0.973121085246554, NA, 0.98981262769266)
  expectedO2Variance <- c(1.04022348595978, 0.961558580021429, 0.957650770529217, NA, 1.0629819935254)
  expectedO1O2Covariance <- c(0.268806439404608, 0.429343904462538, 0.391073096228867, NA, 0.947322530421869)
  expectedCorrelation <- c(0.258487545385475, 0.424033938082461, 0.405108090993623, NA, 0.923545757041769)
  expectedDeterminant <- c(1.00917727748255, 0.840865631347389, 0.778971990510558, NA, 0.154733023556467)
  expectedPosDefinite <- expectedIncluded
  
  expect_equal(object=nrow(dsGroupSummary), expected=expectedRowCount, scale=1)
  expect_equal(object=colnames(dsGroupSummary), expected=expectedColumnNames, scale=1)
  expect_equal(object=dsGroupSummary$R, expected=expectedR, scale=1)
  expect_equal(object=dsGroupSummary$Included, expected=expectedIncluded, scale=1)
  expect_equal(object=dsGroupSummary$PairCount, expected=expectedPairCount, scale=1)
  expect_equal(object=dsGroupSummary$O1Mean, expected=expectedO1Mean, scale=1)
  expect_equal(object=dsGroupSummary$O2Mean, expected=expectedO2Mean, scale=1)
  expect_equal(object=dsGroupSummary$O1Variance, expected=expectedO1Variance, scale=1)
  expect_equal(object=dsGroupSummary$O2Variance, expected=expectedO2Variance, scale=1)
  expect_equal(object=dsGroupSummary$O1O2Covariance, expected=expectedO1O2Covariance, scale=1)
  expect_equal(object=dsGroupSummary$Correlation, expected=expectedCorrelation, scale=1)
  expect_equal(object=dsGroupSummary$Determinant, expected=expectedDeterminant, scale=1)
  expect_equal(object=dsGroupSummary$PosDefinite, expected=expectedPosDefinite, scale=1)
})


test_that("Group Summary Changed Variable Name for 'R'", {
  dsFull <- Links79PairExpanded #Start with the built-in data.frame in NlsyLinks
  oName_S1 <- "HeightZGenderAge_S1"
  oName_S2 <- "HeightZGenderAge_S2"
  rName <- "RRR"
  dsFull <- RenameNlsyColumn(dsFull, "R", rName)
                         
  dsFull <- dsFull[dsFull$RelationshipPath=='Gen2Siblings', ]
  dsGroupSummary <- RGroupSummary(dsFull, oName_S1, oName_S2, rName)
  
  expectedRowCount <- 5
  expectedColumnNames <- c('RRR', 'Included', 'PairCount', 'O1Mean', 'O2Mean', 'O1Variance', 'O2Variance', 'O1O2Covariance', 'Correlation', 'Determinant', 'PosDefinite')
  expectedR <- c(.25, .375, .5, .75, 1)
  expectedIncluded <- c(T, T, T, F, T)
  expectedPairCount <- c(1862, 46, 3960, 0, 16)
  expectedO1Mean <- c(-0.0656364953267334, 0.220021924023091, -0.00701925535792626, NA, -0.127696870303618)
  expectedO2Mean <- c(-0.0810552319003634, -0.105982711665083, -0.036536374677054, NA, -0.206430554937734)
  expectedO1Variance <- c(1.03961715337558, 1.06618758435256, 0.973121085246554, NA, 0.98981262769266)
  expectedO2Variance <- c(1.04022348595978, 0.961558580021429, 0.957650770529217, NA, 1.0629819935254)
  expectedO1O2Covariance <- c(0.268806439404608, 0.429343904462538, 0.391073096228867, NA, 0.947322530421869)
  expectedCorrelation <- c(0.258487545385475, 0.424033938082461, 0.405108090993623, NA, 0.923545757041769)
  expectedDeterminant <- c(1.00917727748255, 0.840865631347389, 0.778971990510558, NA, 0.154733023556467)
  expectedPosDefinite <- expectedIncluded
  
  expect_equal(object=nrow(dsGroupSummary), expected=expectedRowCount, scale=1)
  expect_equal(object=colnames(dsGroupSummary), expected=expectedColumnNames, scale=1)
  expect_equal(object=dsGroupSummary$R, expected=expectedR, scale=1)
  expect_equal(object=dsGroupSummary$Included, expected=expectedIncluded, scale=1)
  expect_equal(object=dsGroupSummary$PairCount, expected=expectedPairCount, scale=1)
  expect_equal(object=dsGroupSummary$O1Mean, expected=expectedO1Mean, scale=1)
  expect_equal(object=dsGroupSummary$O2Mean, expected=expectedO2Mean, scale=1)
  expect_equal(object=dsGroupSummary$O1Variance, expected=expectedO1Variance, scale=1)
  expect_equal(object=dsGroupSummary$O2Variance, expected=expectedO2Variance, scale=1)
  expect_equal(object=dsGroupSummary$O1O2Covariance, expected=expectedO1O2Covariance, scale=1)
  expect_equal(object=dsGroupSummary$Correlation, expected=expectedCorrelation, scale=1)
  expect_equal(object=dsGroupSummary$Determinant, expected=expectedDeterminant, scale=1)
  expect_equal(object=dsGroupSummary$PosDefinite, expected=expectedPosDefinite, scale=1)
})

test_that("Single Group Summary MathStandardized", {
  dsFull <- Links79PairExpanded #Start with the built-in data.frame in NlsyLinks
  oName_S1 <- "MathStandardized_S1" #Stands for Manifest1
  oName_S2 <- "MathStandardized_S2" #Stands for Manifest2
  dsFull$DummyGroup <- 1
  rName <- "DummyGroup"
  
  dsFull <- dsFull[dsFull$RelationshipPath=='Gen2Siblings', ]
  dsGroupSummary <- RGroupSummary(dsFull, oName_S1, oName_S2, rName)
  
  expectedRowCount <- 1
  expectedColumnNames <- c('DummyGroup', 'Included', 'PairCount', 'O1Mean', 'O2Mean', 'O1Variance', 'O2Variance', 'O1O2Covariance', 'Correlation', 'Determinant', 'PosDefinite')
  expectedR <- 1
  expectedIncluded <- T
  expectedPairCount <- 8392
  expectedO1Mean <- 98.0716158245949
  expectedO2Mean <- 98.5686367969495
  expectedO1Variance <- 216.465970550521
  expectedO2Variance <- 229.298827935283
  expectedO1O2Covariance <- 90.9026634829023
  expectedCorrelation <- 0.4080194579033
  expectedDeterminant <- 41372.099106822
  expectedPosDefinite <- expectedIncluded
  
  expect_equal(object=nrow(dsGroupSummary), expected=expectedRowCount, scale=1)
  expect_equal(object=colnames(dsGroupSummary), expected=expectedColumnNames, scale=1)
  expect_equal(object=dsGroupSummary[, rName], expected=expectedR, scale=1)
  
  expect_equal(object=dsGroupSummary$Included, expected=expectedIncluded, scale=1)
  expect_equal(object=dsGroupSummary$PairCount, expected=expectedPairCount, scale=1)
  expect_equal(object=dsGroupSummary$O1Mean, expected=expectedO1Mean, scale=1)
  expect_equal(object=dsGroupSummary$O2Mean, expected=expectedO2Mean, scale=1)
  expect_equal(object=dsGroupSummary$O1Variance, expected=expectedO1Variance, scale=1)
  expect_equal(object=dsGroupSummary$O2Variance, expected=expectedO2Variance, scale=1)
  expect_equal(object=dsGroupSummary$O1O2Covariance, expected=expectedO1O2Covariance, scale=1)
  expect_equal(object=dsGroupSummary$Correlation, expected=expectedCorrelation, scale=1)
  expect_equal(object=dsGroupSummary$Determinant, expected=expectedDeterminant, scale=1)
  expect_equal(object=dsGroupSummary$PosDefinite, expected=expectedPosDefinite, scale=1)
})
# 
# dsGroupSummary <- RGroupSummary(dsFull, oName_S1, oName_S2)
# rName <- "R"
# str_c(colnames(dsGroupSummary), collapse="', '")
# # str_c(dsGroupSummary[, rName], collapse=", ")
# str_c(dsGroupSummary$Included, collapse=", ")
# str_c(dsGroupSummary$PairCount, collapse=", ")
# str_c(dsGroupSummary$O1Mean, collapse=", ")
# str_c(dsGroupSummary$O2Mean, collapse=", ")
# str_c(dsGroupSummary$O1Variance, collapse=", ")
# str_c(dsGroupSummary$O2Variance, collapse=", ")
# str_c(dsGroupSummary$O1O2Covariance, collapse=", ")
# str_c(dsGroupSummary$Correlation, collapse=", ")
# str_c(dsGroupSummary$Determinant, collapse=", ")
# str_c(dsGroupSummary$PosDefinite, collapse=", ")
