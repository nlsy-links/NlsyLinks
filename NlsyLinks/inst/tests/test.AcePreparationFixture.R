
###########
context("Clean Ace Sem Dataset")
###########
test_that("CleanSemAceDataset MathStandardized", {
  dsFull <- Links79PairExpanded #Start with the built-in data.frame in NlsyLinks
  oName_1 <- "MathStandardized_1" 
  oName_2 <- "MathStandardized_2"
  dsFull <- dsFull[dsFull$RelationshipPath=='Gen2Siblings', ]
  dsGroupSummary <- RGroupSummary(dsFull, oName_1, oName_2)
  
  dsClean <- CleanSemAceDataset( dsDirty=dsFull, dsGroupSummary, oName_1, oName_2, rName="R" )
  
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
  oName_1 <- "HeightZGenderAge_1" 
  oName_2 <- "HeightZGenderAge_2" 
  dsFull <- dsFull[dsFull$RelationshipPath=='Gen2Siblings', ]
  dsGroupSummary <- RGroupSummary(dsFull, oName_1, oName_2)
  
  dsClean <- CleanSemAceDataset( dsDirty=dsFull, dsGroupSummary, oName_1, oName_2, rName="R" )
  
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
# test_that("CleanSemAceDataset WeightStandardizedForAge19To25", {
#   dsFull <- Links79PairExpanded #Start with the built-in data.frame in NlsyLinks
#   oName_1 <- "WeightStandardizedForAge19To25_1" #Stands for Manifest1
#   oName_2 <- "WeightStandardizedForAge19To25_2" #Stands for Manifest2
#   dsFull <- dsFull[dsFull$RelationshipPath=='Gen2Siblings', ]
#   dsGroupSummary <- RGroupSummary(dsFull, oName_1, oName_2)
#   
#   dsClean <- CleanSemAceDataset( dsDirty=dsFull, dsGroupSummary, oName_1, oName_2, rName="R" )
#   
#   expectedRowCount <- 3479
#   expectedColumnNames <- c('R', 'O1', 'O2', 'GroupID')
#   expectedCompleteRows <- expectedRowCount
#   expectedMeanR <- 0.425086231675769 #0.42522995113538375467
#   expectedMeanO1 <- 0.0762599144233975 #0.076259914423397523464
#   expectedMeanO2 <- -0.0276821544946824 #-0.027682154494682382345
#   expectedMeanGroupID <- 2.38947973555619 #2.3906294912331129687
#   
#   expect_equal(object=nrow(dsClean), expected=expectedRowCount, scale=1)
#   expect_equal(object=colnames(dsClean), expected=expectedColumnNames, scale=1)
#   expect_equal(object=mean(dsClean$R), expected=expectedMeanR, scale=1)
#   expect_equal(object=mean(dsClean$O1), expected=expectedMeanO1, scale=1)
#   expect_equal(object=mean(dsClean$O2), expected=expectedMeanO2, scale=1)
#   expect_equal(object=mean(dsClean$GroupID), expected=expectedMeanGroupID, scale=1)
#   expect_equal(object=nrow(subset(dsClean, !is.na(R) & !is.na(O1) & !is.na(O2) & !is.na(GroupID))), expected=expectedCompleteRows, scale=1)
# })
# nrow(dsClean)
# str_c(colnames(dsClean), collapse="', '")
# str_c(mean(dsClean$R))
# str_c(mean(dsClean$O1))
# str_c(mean(dsClean$O2))
# str_c(mean(dsClean$GroupID))

###########
context("R Group Summary")
###########
test_that("Group Summary MathStandardized", {
  dsFull <- Links79PairExpanded #Start with the built-in data.frame in NlsyLinks
  oName_1 <- "MathStandardized_1" #Stands for Manifest1
  oName_2 <- "MathStandardized_2" #Stands for Manifest2
   
  dsFull <- dsFull[dsFull$RelationshipPath=='Gen2Siblings', ]
  dsGroupSummary <- RGroupSummary(dsFull, oName_1, oName_2)
  
  expectedRowCount <- 5
  expectedColumnNames <- c('R', 'Included', 'PairCount', 'O1Variance', 'O2Variance', 'O1O2Covariance', 'Correlation', 'Determinant', 'PosDefinite')
  expectedR <- c(.25, .375, .5, .75, 1)
  expectedIncluded <- c(T, T, T, F, T)
  expectedPairCount <- c(2718, 139, 5511, 2, 22)
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
  expect_equal(object=dsGroupSummary$O1Variance, expected=expectedO1Variance, scale=1)
  expect_equal(object=dsGroupSummary$O2Variance, expected=expectedO2Variance, scale=1)
  expect_equal(object=dsGroupSummary$O1O2Covariance, expected=expectedO1O2Covariance, scale=1)
  expect_equal(object=dsGroupSummary$Correlation, expected=expectedCorrelation, scale=1)
  expect_equal(object=dsGroupSummary$Determinant, expected=expectedDeterminant, scale=1)
  expect_equal(object=dsGroupSummary$PosDefinite, expected=expectedPosDefinite, scale=1)
})
test_that("Group Summary HeightZGenderAge", {
  dsFull <- Links79PairExpanded #Start with the built-in data.frame in NlsyLinks
  oName_1 <- "HeightZGenderAge_1"
  oName_2 <- "HeightZGenderAge_2"
  
  dsFull <- dsFull[dsFull$RelationshipPath=='Gen2Siblings', ]
  dsGroupSummary <- RGroupSummary(dsFull, oName_1, oName_2)
  
  expectedRowCount <- 5
  expectedColumnNames <- c('R', 'Included', 'PairCount', 'O1Variance', 'O2Variance', 'O1O2Covariance', 'Correlation', 'Determinant', 'PosDefinite')
  expectedR <- c(.25, .375, .5, .75, 1)
  expectedIncluded <- c(T, T, T, F, T)
  expectedPairCount <- c(1862, 46, 3960, 0, 16)
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
  expect_equal(object=dsGroupSummary$O1Variance, expected=expectedO1Variance, scale=1)
  expect_equal(object=dsGroupSummary$O2Variance, expected=expectedO2Variance, scale=1)
  expect_equal(object=dsGroupSummary$O1O2Covariance, expected=expectedO1O2Covariance, scale=1)
  expect_equal(object=dsGroupSummary$Correlation, expected=expectedCorrelation, scale=1)
  expect_equal(object=dsGroupSummary$Determinant, expected=expectedDeterminant, scale=1)
  expect_equal(object=dsGroupSummary$PosDefinite, expected=expectedPosDefinite, scale=1)
})

# test_that("Group Summary WeightStandardizedForAge19To25", {
#   dsFull <- Links79PairExpanded #Start with the built-in data.frame in NlsyLinks
#   oName_1 <- "WeightStandardizedForAge19To25_1" #Stands for Manifest1
#   oName_2 <- "WeightStandardizedForAge19To25_2" #Stands for Manifest2
#   
#   dsFull <- dsFull[dsFull$RelationshipPath=='Gen2Siblings', ]
#   dsGroupSummary <- RGroupSummary(dsFull, oName_1, oName_2)
#   
#   expectedRowCount <- 5
#   expectedColumnNames <- c('R', 'Included', 'PairCount', 'O1Variance', 'O2Variance', 'O1O2Covariance', 'Correlation', 'Determinant', 'PosDefinite')
#   expectedR <- c(.25, .375, .5, .75, 1)
#   expectedIncluded <- c(T, T, T, F, T)
#   expectedPairCount <- c(1053, 31, 2382, 0, 13)
#   expectedO1Variance <- c(1.22201353751576, 1.76977307994312, 0.964031941386966, NA, 1.16811811494777)
#   expectedO2Variance <- c(1.03170996045351, 0.982548788608192, 0.906499719554973, NA, 1.51474929993746)
#   expectedO1O2Covariance <- c(0.191319643011453, 0.0710231448923719, 0.300908457657194, NA, 1.27081120357811)
#   expectedCorrelation <- c(0.170389465911755, 0.0538597141598764, 0.321888043965459, NA, 0.955360487068942)
#   expectedDeterminant <- c(1.22416033266202, 1.7338441086991, 0.783348784619689, NA, 0.154444981721754)
#   expectedPosDefinite <- expectedIncluded
#   
#   expect_equal(object=nrow(dsGroupSummary), expected=expectedRowCount, scale=1)
#   expect_equal(object=colnames(dsGroupSummary), expected=expectedColumnNames, scale=1)
#   expect_equal(object=dsGroupSummary$R, expected=expectedR, scale=1)
#   expect_equal(object=dsGroupSummary$Included, expected=expectedIncluded, scale=1)
#   expect_equal(object=dsGroupSummary$PairCount, expected=expectedPairCount, scale=1)
#   expect_equal(object=dsGroupSummary$O1Variance, expected=expectedO1Variance, scale=1)
#   expect_equal(object=dsGroupSummary$O2Variance, expected=expectedO2Variance, scale=1)
#   expect_equal(object=dsGroupSummary$O1O2Covariance, expected=expectedO1O2Covariance, scale=1)
#   expect_equal(object=dsGroupSummary$Correlation, expected=expectedCorrelation, scale=1)
#   expect_equal(object=dsGroupSummary$Determinant, expected=expectedDeterminant, scale=1)
#   expect_equal(object=dsGroupSummary$PosDefinite, expected=expectedPosDefinite, scale=1)
# })

test_that("Group Summary Changed Variable Name for 'R'", {
  dsFull <- Links79PairExpanded #Start with the built-in data.frame in NlsyLinks
  oName_1 <- "HeightZGenderAge_1"
  oName_2 <- "HeightZGenderAge_2"
  rName <- "RRR"
  dsFull <- RenameNlsyColumn(dsFull, "R", rName)
                         
  dsFull <- dsFull[dsFull$RelationshipPath=='Gen2Siblings', ]
  dsGroupSummary <- RGroupSummary(dsFull, oName_1, oName_2, rName)
  
  expectedRowCount <- 5
  expectedColumnNames <- c('RRR', 'Included', 'PairCount', 'O1Variance', 'O2Variance', 'O1O2Covariance', 'Correlation', 'Determinant', 'PosDefinite')
  expectedR <- c(.25, .375, .5, .75, 1)
  expectedIncluded <- c(T, T, T, F, T)
  expectedPairCount <- c(1862, 46, 3960, 0, 16)
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
  expect_equal(object=dsGroupSummary$O1Variance, expected=expectedO1Variance, scale=1)
  expect_equal(object=dsGroupSummary$O2Variance, expected=expectedO2Variance, scale=1)
  expect_equal(object=dsGroupSummary$O1O2Covariance, expected=expectedO1O2Covariance, scale=1)
  expect_equal(object=dsGroupSummary$Correlation, expected=expectedCorrelation, scale=1)
  expect_equal(object=dsGroupSummary$Determinant, expected=expectedDeterminant, scale=1)
  expect_equal(object=dsGroupSummary$PosDefinite, expected=expectedPosDefinite, scale=1)
})

test_that("Single Group Summary MathStandardized", {
  dsFull <- Links79PairExpanded #Start with the built-in data.frame in NlsyLinks
  oName_1 <- "MathStandardized_1" #Stands for Manifest1
  oName_2 <- "MathStandardized_2" #Stands for Manifest2
  dsFull$DummyGroup <- 1
  rName <- "DummyGroup"
  
  dsFull <- dsFull[dsFull$RelationshipPath=='Gen2Siblings', ]
  dsGroupSummary <- RGroupSummary(dsFull, oName_1, oName_2, rName)
  
  expectedRowCount <- 1
  expectedColumnNames <- c(rName, 'Included', 'PairCount', 'O1Variance', 'O2Variance', 'O1O2Covariance', 'Correlation', 'Determinant', 'PosDefinite')
  expectedR <- 1
  expectedIncluded <- T
  expectedPairCount <- 8392
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
  expect_equal(object=dsGroupSummary$O1Variance, expected=expectedO1Variance, scale=1)
  expect_equal(object=dsGroupSummary$O2Variance, expected=expectedO2Variance, scale=1)
  expect_equal(object=dsGroupSummary$O1O2Covariance, expected=expectedO1O2Covariance, scale=1)
  expect_equal(object=dsGroupSummary$Correlation, expected=expectedCorrelation, scale=1)
  expect_equal(object=dsGroupSummary$Determinant, expected=expectedDeterminant, scale=1)
  expect_equal(object=dsGroupSummary$PosDefinite, expected=expectedPosDefinite, scale=1)
})
# 
# dsGroupSummary <- RGroupSummary(dsFull, oName_1, oName_2)
# rName <- "R"
# str_c(colnames(dsGroupSummary), collapse="', '")
# # str_c(dsGroupSummary[, rName], collapse=", ")
# str_c(dsGroupSummary$Included, collapse=", ")
# str_c(dsGroupSummary$PairCount, collapse=", ")
# str_c(dsGroupSummary$O1Variance, collapse=", ")
# str_c(dsGroupSummary$O2Variance, collapse=", ")
# str_c(dsGroupSummary$O1O2Covariance, collapse=", ")
# str_c(dsGroupSummary$Correlation, collapse=", ")
# str_c(dsGroupSummary$Determinant, collapse=", ")
# str_c(dsGroupSummary$PosDefinite, collapse=", ")
