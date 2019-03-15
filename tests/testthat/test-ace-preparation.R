
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

  expectedRowCount <- 8338
  expectedColumnNames <- c('R', 'O1', 'O2', 'GroupID')
  expectedCompleteRows <- expectedRowCount
  expectedMeanR <- 0.41858059486687454465
  expectedMeanO1 <- 98.242084432717675213
  expectedMeanO2 <- 98.6032621731830119
  expectedMeanGroupID <- 2.3410889901655074219

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
  expectedMeanR <- 0.42118456832087014519
  expectedMeanO1 <- -0.0241219488333721
  expectedMeanO2 <- -0.0516293302405181
  expectedMeanGroupID <- 2.3613188307273964561

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
  expectedPairCount <- c(2689, 137, 5491, 2, 21)
  expectedO1Mean <- c(95.1044998140573, 93.6313868613139, 99.8937352030595, 108.5, 98.2142857142857)
  expectedO2Mean <- c(95.97936035701, 93.3686131386861, 100.028683299945, 106, 96.0238095238095)
  expectedO1Variance <- c(126.948897154855, 160.012022327179, 168.732558195079, 220.5, 289.439285714286)
  expectedO2Variance <- c(150.177494233562, 136.662757621297, 172.729277300594, 18, 215.236904761905)
  expectedO1O2Covariance <- c(41.9691405281548, 50.3979041434092, 90.0411633343385, 63, 229.107142857143)
  expectedCorrelation <- c(0.30395772301827, 0.340809019009798, 0.527422525509699, 1, 0.917913001835716)
  expectedDeterminant <- c(17303.4585137582, 19327.7354817445, 21037.6417395154, 0, 9807.93306547619)
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
  expectedPairCount <- c(1863, 48, 3957, 0, 16)
  expectedO1Mean <- c(-0.0656790934983323, 0.13536237807408, -0.00607218172541112, NA, -0.127696863629105)
  expectedO2Mean <- c(-0.0809263333200959, -0.107861955617865, -0.0365279114683667, NA, -0.206430523000536)
  expectedO1Variance <- c(1.03906218652336, 1.14976428238439, 0.972674771045228, NA, 0.989812601868269)
  expectedO2Variance <- c(1.03969578031032, 0.926910872047652, 0.958287174752661, NA, 1.062981918949)
  expectedO1O2Covariance <- c(0.268651843136663, 0.407477856542372, 0.391359082973515, NA, 0.947322488484283)
  expectedCorrelation <- c(0.25847343452369, 0.394712262077996, 0.405362672107938, NA, 0.923545760601445)
  expectedDeterminant <- c(1.00813475798763, 0.899690810061788, 0.778939826472253, NA, 0.154733001745783)
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
  expectedPairCount <- c(1863, 48, 3957, 0, 16)
  expectedO1Mean <- c(-0.0656790934983323, 0.13536237807408, -0.00607218172541112, NA, -0.127696863629105)
  expectedO2Mean <- c(-0.0809263333200959, -0.107861955617865, -0.0365279114683667, NA, -0.206430523000536)
  expectedO1Variance <- c(1.03906218652336, 1.14976428238439, 0.972674771045228, NA, 0.989812601868269)
  expectedO2Variance <- c(1.03969578031032, 0.926910872047652, 0.958287174752661, NA, 1.062981918949)
  expectedO1O2Covariance <- c(0.268651843136663, 0.407477856542372, 0.391359082973515, NA, 0.947322488484283)
  expectedCorrelation <- c(0.25847343452369, 0.394712262077996, 0.405362672107938, NA, 0.923545760601445)
  expectedDeterminant <- c(1.00813475798763, 0.899690810061788, 0.778939826472253, NA, 0.154733001745783)
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
  expectedPairCount <- 8340
  expectedO1Mean <- 98.2445443645084
  expectedO2Mean <- 98.605035971223
  expectedO1Variance <- 160.681736631321
  expectedO2Variance <- 168.910299614967
  expectedO1O2Covariance <- 78.8060054127222
  expectedCorrelation <- 0.478352435603954
  expectedDeterminant <- 20930.4137879396
  expectedPosDefinite <- expectedIncluded

  expect_equal(object=nrow(dsGroupSummary), expected=expectedRowCount, scale=1)
  expect_equal(object=colnames(dsGroupSummary), expected=expectedColumnNames, scale=1)
  expect_equal(object=dsGroupSummary[[rName]], expected=expectedR, scale=1)

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
# #
# # dsGroupSummary <- RGroupSummary(dsFull, oName_S1, oName_S2)
# # rName <- "R"
# paste0(colnames(dsGroupSummary), collapse="', '")
# # paste0(dsGroupSummary[, rName], collapse=", ")
# paste0(dsGroupSummary$Included, collapse=", ")
# paste0(dsGroupSummary$PairCount, collapse=", ")
# paste0(dsGroupSummary$O1Mean, collapse=", ")
# paste0(dsGroupSummary$O2Mean, collapse=", ")
# paste0(dsGroupSummary$O1Variance, collapse=", ")
# paste0(dsGroupSummary$O2Variance, collapse=", ")
# paste0(dsGroupSummary$O1O2Covariance, collapse=", ")
# paste0(dsGroupSummary$Correlation, collapse=", ")
# paste0(dsGroupSummary$Determinant, collapse=", ")
# paste0(dsGroupSummary$PosDefinite, collapse=", ")
