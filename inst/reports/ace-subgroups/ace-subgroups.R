rm(list=ls(all=TRUE)) #Clear variables from previous runs.

# @knitr load_sources ------------------------------------------------------------

# @knitr load_packages -----------------------------------------------------------
library(NlsyLinks)
library(magrittr)
library(knitr)
library(xtable)
requireNamespace("dplyr", quietly=T)
requireNamespace("plyr", quietly=T)
requireNamespace("scales", quietly=T)

# @knitr define_globals ----------------------------------------------------------
oName <- "HeightZGenderAge" # o' stands for outcomes
# oName <- "WeightZGenderAge"

relationshipPaths <- c(2)
# relationshipPaths <- c(1, 2, 3, 4, 5)

rVersions <- c("R", "RFull", "RExplicit", "RImplicit",  "RImplicit2004")

dropIfHousematesAreNotSameGeneration <- FALSE

rGroupsToDrop <- c()
# determinantThreshold <- 1e-5

suppressGroupTables <- TRUE

# sql <- paste(
#   "SELECT 
#       Process.tblRelatedValuesArchive.AlgorithmVersion, 
#       Process.tblRelatedStructure.RelationshipPath, 
#       Process.tblRelatedValuesArchive.SubjectTag_S1, 
#       Process.tblRelatedValuesArchive.SubjectTag_S2,
#       Process.tblRelatedValuesArchive.RImplicitPass1, 
#       Process.tblRelatedValuesArchive.RImplicit, 
#       Process.tblRelatedValuesArchive.RImplicitSubject, 
#       Process.tblRelatedValuesArchive.RImplicitMother, 
#       Process.tblRelatedValuesArchive.RImplicit2004, 
#       Process.tblRelatedValuesArchive.RExplicitPass1, 
#       Process.tblRelatedValuesArchive.RExplicit, 
#       Process.tblRelatedValuesArchive.RPass1, 
#       Process.tblRelatedValuesArchive.R,
#       Process.tblRelatedValuesArchive.RFull, 
#       SameGeneration
#   FROM Process.tblRelatedValuesArchive 
#       INNER JOIN Process.tblRelatedStructure ON Process.tblRelatedValuesArchive.SubjectTag_S1 = Process.tblRelatedStructure.SubjectTag_S1 AND Process.tblRelatedValuesArchive.SubjectTag_S2 = Process.tblRelatedStructure.SubjectTag_S2 
#   WHERE Process.tblRelatedStructure.RelationshipPath IN ", relationshipPathsString, " 
#       AND (
#         Process.tblRelatedValuesArchive.AlgorithmVersion IN (
#           SELECT TOP (2) AlgorithmVersion 
#           FROM Process.tblRelatedValuesArchive AS tblRelatedValuesArchive_1 
#           GROUP BY AlgorithmVersion 
#           ORDER BY AlgorithmVersion DESC
#         )
#       )"
# )

# @knitr load_data ---------------------------------------------------------------
dsPair <- NlsyLinks::Links79PairExpanded
dsOutcomes <- NlsyLinks::ExtraOutcomes79


# @knitr tweak_data --------------------------------------------------------------
dsPair <- dsPair[as.integer(dsPair$RelationshipPath) %in% relationshipPaths, ]

oName_1 <- paste0(oName, "_S1")
oName_2 <- paste0(oName, "_S2")
relationshipPathsString <- paste0("(", paste(relationshipPaths, collapse=","), ")")
relationshipPathsPretty <- paste0("(", paste(levels(Links79Pair$RelationshipPath)[relationshipPaths], collapse=", "), ")")

dsOutcomes$RandomFakeOutcome <- rnorm(n=nrow(dsOutcomes))
dsOutcomes <- dsOutcomes[, c("SubjectTag", oName)]

if( dropIfHousematesAreNotSameGeneration ) {
  dsRaw <- dsRaw[dsRaw$SameGeneration==1L, ]
}

#They're called 'dirty' because the final cleaning stage hasn't occurred yet (ie, removing unwanted R groups)
dsDirty <- CreatePairLinksSingleEntered(
  outcomeDataset   = dsOutcomes, 
  linksPairDataset = dsPair, 
  linksNames       = rVersions, 
  outcomeNames     = oName
)
# rm(dsOutcomes, dsPair)

# table(dsDirty$RFull)
# mean(!is.na(dsDirty$RFull)) 
# mean(!is.na(dsDirty[!is.na(dsDirty[, oName_1]) & !is.na(dsDirty[, oName_2]), "RFull"])) 

# @knitr evaluate_groups ---------------------------------------------------------
groupDatasets <- list() 
dsAce <- data.frame(Version=rVersions, ASq=NA_real_, CSq=NA_real_, ESq=NA_real_, N=NA_integer_)
for( i in seq_along(rVersions) ) {
  rVersion <-  rVersions[i] # rVersion <- "RFull"
#  print(rVersion)
  dsGroupSummary <- RGroupSummary(dsDirty, oName_1, oName_2, rName=rVersion)#, determinantThreshold=determinantThreshold)
  dsGroupSummary[dsGroupSummary[, rVersion] %in% rGroupsToDrop, "Included"] <- FALSE
  
  groupDatasets[[(i-1)*2 + 1]] <- dsGroupSummary
       
  dsClean <- CleanSemAceDataset(dsDirty=dsDirty, dsGroupSummary, oName_1, oName_2, rName=rVersion)
  
  ace <- AceLavaanGroup(dsClean)
  dsAce[i, 2:5] <- c(ace@ASquared, ace@CSquared, ace@ESquared, ace@CaseCount)
}
# dsAce
# groupDatasets[[1]]

PrintGroupSummary <- function( dsSummary, title="Group Summary"  ) {
  colnames(dsSummary)[colnames(dsSummary)=="Included"] <- "Included in SEM"
  colnames(dsSummary)[colnames(dsSummary)=="PairCount"] <- "$N_{Pairs}$"
  colnames(dsSummary)[colnames(dsSummary)=="O1Mean"] <- "$\\bar{x}_1$"
  colnames(dsSummary)[colnames(dsSummary)=="O2Mean"] <- "$\\bar{x}_2$"
  colnames(dsSummary)[colnames(dsSummary)=="O1Variance"] <- "$s_1^2$"
  colnames(dsSummary)[colnames(dsSummary)=="O2Variance"] <- "$s_2^2$"
  colnames(dsSummary)[colnames(dsSummary)=="O1O2Covariance"] <- "$s_{1,2}$"
  colnames(dsSummary)[colnames(dsSummary)=="Correlation"] <- "$r$"
  
  digitsFormat <- c(0,3,0,0,2,2,2,2,2,2,1,0) #Include a dummy at the beginning, for the row.names.
  textTable <- xtable(dsSummary, caption=title, digits=digitsFormat)
  print(textTable, include.rownames=F, sanitize.text.function = function(x) {x}) # size="large", size="small",
}
# PrintGroupSummary(dsSummary=dsGroupSummary)

for( i in seq_along(rVersions) ) {
  rVersion <- rVersions[i]
  # if( startNewPage[i] ) cat('\\newpage \n')
  cat('\\section{Subgroups -- ', rVersion, '}')
  
  PrintGroupSummary(groupDatasets[[(i-1)*2 + 1]], title=rVersion)
}

# @knitr evaluate_ace ------------------------------------------------------------
PrintAces <- function( ) {
  dsT <- dsAce
  dsT <- cbind(dsT[, 1], plyr::numcolwise(round)(dsT,digits=2))
  dsT <- cbind(dsT[, 1], plyr::numcolwise(scales::comma)(dsT))
  dsT <- t(apply(dsT, 1, function(x) gsub("^0.", ".", x)))
  
  colnames(dsT) <- c("$R$ Variant", "$a^2$", "$c^2$", "$e^2$", "$N$")
  digitsFormat <- 2# c(0,1,3,3,3,3,3,3) #Include a dummy at the beginning, for the row.names.
  alignnment <- "ll|rrrr" #Include an initial dummy for the (suppressed) row names.
  textTable <- xtable(dsT, caption="Comparison of R Variants (by rows) and of Links Versions (left vs right side).", digits=digitsFormat, align=alignnment)
  print(textTable, include.rownames=F, size="large", sanitize.text.function = function(x) {x}, floating=T)
}
PrintAces()
# summary(dsAce)
