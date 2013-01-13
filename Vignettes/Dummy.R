# TODO: Add comment
# 
# Author: wibeasley
###############################################################################


d <- rnorm(32)
d
     
#require(testthat)
#?expect_equal
#installed.packages()
install.packages("F:/Projects/RDev/NlsyLinksStaging/NlsyLinks_0.27.tar.gz", repos=NULL, type="source")


#fg <- rnorm

require(NlsyLinks); require(lavaan) #Step 2: load libraries.

#Steps 3-4: Load the linking dataset and outcomes dataset.
dsLinking <- subset(Links79Pair, RelationshipPath=="Gen2Siblings")
dsOutcomes <- ReadCsvNlsy79Gen2('C:/BGResearch/NlsExtracts/Gen2Birth.csv')

#Step 5: Verify and rename an existing column.
VerifyColumnExists(dsOutcomes,  "C0328600") 
dsOutcomes <- RenameNlsyColumn(dsOutcomes, "C0328600", "BirthWeightInOunces")

#Step 6: Manipulate & groom
dsOutcomes$BirthWeightInOunces[dsOutcomes$BirthWeightInOunces < 0] <- NA
dsOutcomes$BirthWeightInOunces <- pmin(dsOutcomes$BirthWeightInOunces, 300)
qplot(dsOutcomes$BirthWeightInOunces, binwidth=2)
hist(dsOutcomes$BirthWeightInOunces, breaks=500, border="NA", col="blue")


#Steps 7-8: Merge outcome & linking datasets & declare outcome variable names
dsSingle <- CreatePairLinksSingleEntered(dsOutcomes, dsLinking, 'BirthWeightInOunces')
oName_1 <- "BirthWeightInOunces_1"; oName_2 <- "BirthWeightInOunces_2" 

#Step 9-10: GroupSummary & Create Cleaned dataset
(dsGroupSummary <- RGroupSummary(dsSingle, oName_1, oName_2))
dsClean <- CleanSemAceDataset(dsDirty=dsSingle, dsGroupSummary, oName_1, oName_2)

#Steps 11-12: Run the model & Inspect the output 
(ace <- AceLavaanGroup(dsClean))
GetDetails(ace)

