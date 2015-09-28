rm(list=ls(all=TRUE)) #Clear variables from previous runs.


# load_sources ------------------------------------------------------------


# load_packages -----------------------------------------------------------

library(NlsyLinks)
library(RODBC)
library(ggplot2)
library(colorspace)
library(xtable)
library(plyr)

# define_globals ----------------------------------------------------------


#Define CSV of outcomes/phenotypes
pathInput <- "./ForDistribution/Outcomes/ExtraOutcomes79.csv"
#dsOutcomes <- read.csv("./CodingUtilities/Gen2Height/ExtraOutcomes79FromKelly2012March.csv")

# oName <- "HeightZGender"
oName <- "HeightZGenderAge"
# oName <- "WeightZGender"
# oName <- "WeightZGenderAge"

# oName <- "AfqtRescaled2006Gaussified" #Gen1 only
# oName <- "Afi"#Gen1 only
# oName <- "Afm" #Gen1 only

# oName <- "IQZGenderAge" #Gen1 only
# oName <- "MathZGenderAge" #Gen2 only
# oName <- "MathStandard" #Gen2 only
# oName <- "MathGaussified" #Gen2 only

# oName <- "RandomFakeOutcome"

# determinantThreshold <- 1e-5

oName_1 <- paste0(oName, "_S1")
oName_2 <- paste0(oName, "_S2")

relationshipPaths <- c(1)
# relationshipPaths <- c(1, 2, 3, 4, 5)
relationshipPathsString <- paste0("(", paste(relationshipPaths, collapse=","), ")")

relationshipPathsPretty <- paste0("(", paste(levels(Links79Pair$RelationshipPath)[relationshipPaths], collapse=", "), ")")


rVersions <- c("R", "RFull", "RExplicit", "RImplicit",  "RImplicit2004") #"RImplicitPass1",
# rVersions <- c("R", "RFull", "RPass1", "RImplicit", "RExplicit", "RExplicitPass1", "RImplicit2004")

#rGroupsToDrop <- c(0, .0625, .125, .375, .75)
rGroupsToDrop <- c() #0, .0625, .125
dropIfHousematesAreNotSameGeneration <- FALSE
startNewPage <- c(F, T, F, T, F, T, F)

suppressGroupTables <- TRUE

sql <- paste("SELECT Process.tblRelatedValuesArchive.AlgorithmVersion, Process.tblRelatedStructure.RelationshipPath, Process.tblRelatedValuesArchive.SubjectTag_S1, Process.tblRelatedValuesArchive.SubjectTag_S2,Process.tblRelatedValuesArchive.RImplicitPass1, Process.tblRelatedValuesArchive.RImplicit, Process.tblRelatedValuesArchive.RImplicitSubject, Process.tblRelatedValuesArchive.RImplicitMother, Process.tblRelatedValuesArchive.RImplicit2004, Process.tblRelatedValuesArchive.RExplicitPass1, Process.tblRelatedValuesArchive.RExplicit, Process.tblRelatedValuesArchive.RPass1, Process.tblRelatedValuesArchive.R, Process.tblRelatedValuesArchive.RFull, SameGeneration
  FROM Process.tblRelatedValuesArchive INNER JOIN Process.tblRelatedStructure ON Process.tblRelatedValuesArchive.SubjectTag_S1 = Process.tblRelatedStructure.SubjectTag_S1 AND Process.tblRelatedValuesArchive.SubjectTag_S2 = Process.tblRelatedStructure.SubjectTag_S2 
  WHERE Process.tblRelatedStructure.RelationshipPath IN ", relationshipPathsString, " 
      AND (Process.tblRelatedValuesArchive.AlgorithmVersion IN (SELECT TOP (2) AlgorithmVersion FROM Process.tblRelatedValuesArchive AS tblRelatedValuesArchive_1 
    GROUP BY AlgorithmVersion ORDER BY AlgorithmVersion DESC))")

# sql <- paste("SELECT Process.tblRelatedValuesArchive.AlgorithmVersion, Process.tblRelatedStructure.RelationshipPath, Process.tblRelatedValuesArchive.SubjectTag_S2, Process.tblRelatedValuesArchive.SubjectTag_S2,Process.tblRelatedValuesArchive.RImplicitPass1, Process.tblRelatedValuesArchive.RImplicit, Process.tblRelatedValuesArchive.RImplicitSubject, Process.tblRelatedValuesArchive.RImplicitMother, Process.tblRelatedValuesArchive.RImplicit2004, Process.tblRelatedValuesArchive.RExplicitPass1, Process.tblRelatedValuesArchive.RExplicit, Process.tblRelatedValuesArchive.RPass1, Process.tblRelatedValuesArchive.R, Process.tblRelatedValuesArchive.RFull, SameGeneration
#   FROM Process.tblRelatedValuesArchive INNER JOIN Process.tblRelatedStructure ON Process.tblRelatedValuesArchive.SubjectTag_S1 = Process.tblRelatedStructure.SubjectTag_S1 AND Process.tblRelatedValuesArchive.SubjectTag_S2 = Process.tblRelatedStructure.SubjectTag_S2 
#   WHERE Process.tblRelatedStructure.RelationshipPath = ", relationshipPath, "  
#       AND (Process.tblRelatedValuesArchive.AlgorithmVersion IN (73, 75))")

sql <- gsub(pattern="\\n", replacement=" ", sql)
sqlDescription <- "SELECT * FROM Process.tblArchiveDescription" #AlgorithmVersion, Description

# load_data ---------------------------------------------------------------


startTime <- Sys.time()
channel <- RODBC::odbcDriverConnect("driver={SQL Server};Server=Bee\\Bass; Database=NlsLinks; Uid=NlsyReadWrite; Pwd=nophi")
# odbcGetInfo(channel)

dsRaw <- sqlQuery(channel, sql, stringsAsFactors=F)
dsDescription <- sqlQuery(channel, sqlDescription, stringsAsFactors=F)
odbcCloseAll()
elapsedTime <- Sys.time() - startTime
# print(elapsedTime)
# nrow(dsRaw)

# tweak_data --------------------------------------------------------------


# sum(dsRaw$SameGeneration != 1)
if( dropIfHousematesAreNotSameGeneration ) {
  dsRaw <- dsRaw[dsRaw$SameGeneration ==1, ]
}

# dsRaw$R <- ifelse(dsRaw$R==.75, 1, dsRaw$R)
# 42025/42773
# sum(!is.na(Links79PairExpanded$RFull))
# sum(!is.na(Links79PairExpanded$RFull))/nrow(Links79PairExpanded)
# mean(!is.na(Links79PairExpanded$RFull))
# table(Links79Pair$RelationshipPath)
# mean(Links79Pair$RelationshipPath %in% c('Gen1Housemates', 'Gen2Cousins', 'AuntNiece'))
# cbind(Links79Pair$RelationshipPath, (Links79Pair$RelationshipPath %in% c('Gen1Housemates', 'Gen2Cousins', ' AuntNiece')))

olderVersionNumber <- min(dsRaw$AlgorithmVersion)
olderDescription <- dsDescription[dsDescription$AlgorithmVersion==olderVersionNumber, 'Description']
newerVersionNumber <- max(dsRaw$AlgorithmVersion)
newerDescription <- dsDescription[dsDescription$AlgorithmVersion==newerVersionNumber, 'Description']
if( is.na(olderVersionNumber) ) stop("The retrived 'olderVersionNumber' is NA.")
if( is.na(newerVersionNumber) ) stop("The retrived 'newerVersionNumber' is NA.")


dsLinkingNewer <- dsRaw[dsRaw$AlgorithmVersion==newerVersionNumber, ]
dsLinkingOlder <- dsRaw[dsRaw$AlgorithmVersion==olderVersionNumber, ]
rm(dsRaw)

dsOutcomes <- read.csv(file=pathInput, stringsAsFactors=F)
dsOutcomes$RandomFakeOutcome <- rnorm(n=nrow(dsOutcomes))
dsOutcomes <- dsOutcomes[, c("SubjectTag", oName)]

#They're called 'dirty' because the final cleaning stage hasn't occurred yet (ie, removing unwanted R groups)
dsDirtyNewer <- CreatePairLinksSingleEntered(outcomeDataset=dsOutcomes, linksPairDataset=dsLinkingNewer, linksNames=rVersions, outcomeNames=oName)
dsDirtyOlder <- CreatePairLinksSingleEntered(outcomeDataset=dsOutcomes, linksPairDataset=dsLinkingOlder, linksNames=rVersions, outcomeNames=oName)
rm(dsOutcomes, dsLinkingNewer, dsLinkingOlder)

# table(dsDirtyNewer$RFull)
# mean(!is.na(dsDirtyNewer$RFull)) 
# mean(!is.na(dsDirtyNewer[!is.na(dsDirtyNewer[, oName_1]) & !is.na(dsDirtyNewer[, oName_2]), "RFull"])) 

# table(dsRaw$R)
# mean(!is.na(dsRaw$R)) 
# mean(!is.na(dsRaw[!is.na(dsRaw[, oName_1]) & !is.na(dsRaw[, oName_2]), "R"])) 


# evaluate_groups ---------------------------------------------------------


groupDatasets <- list() # rep(NA_character_, 2*length(rVersions))
dsAce <- data.frame(Version=rVersions, NewASq=NA_real_, NewCSq=NA_real_, NewESq=NA_real_, NewN=NA_integer_, OldASq=NA_real_, OldCSq=NA_real_, OldESq=NA_real_, OldN=NA_integer_)
for( i in seq_along(rVersions) ) {
  rVersion <-  rVersions[i] # rVersion <- "RFull"
#  print(rVersion)
  dsGroupSummaryNewer <- RGroupSummary(dsDirtyNewer, oName_1, oName_2, rName=rVersion)#, determinantThreshold=determinantThreshold)
  dsGroupSummaryOlder <- RGroupSummary(dsDirtyOlder, oName_1, oName_2, rName=rVersion)#, determinantThreshold=determinantThreshold)
  
  dsGroupSummaryNewer[dsGroupSummaryNewer[, rVersion] %in% rGroupsToDrop, "Included"] <- FALSE
  dsGroupSummaryOlder[dsGroupSummaryOlder[, rVersion] %in% rGroupsToDrop, "Included"] <- FALSE
  
  groupDatasets[[(i-1)*2 + 1]] <- dsGroupSummaryNewer
  groupDatasets[[(i-1)*2 + 2]] <- dsGroupSummaryOlder
       
  dsCleanNewer <- CleanSemAceDataset(dsDirty=dsDirtyNewer, dsGroupSummaryNewer, oName_1, oName_2, rName=rVersion)
  dsCleanOlder <- CleanSemAceDataset(dsDirty=dsDirtyOlder, dsGroupSummaryOlder, oName_1, oName_2, rName=rVersion)
  
  aceNewer <- AceLavaanGroup(dsCleanNewer)
  aceOlder <- AceLavaanGroup(dsCleanOlder)   
  dsAce[i, 2:9] <- c(aceNewer@ASquared, aceNewer@CSquared, aceNewer@ESquared, aceNewer@CaseCount, aceOlder@ASquared, aceOlder@CSquared, aceOlder@ESquared, aceOlder@CaseCount)
}
# dsAce
# groupDatasets[[1]]


## @knitr PrintGroups
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
# PrintGroupSummary(dsSummary=dsGroupSummaryNewer)

for( i in seq_along(rVersions) ) {
  rVersion <- rVersions[i]
  if( startNewPage[i] ) cat('\\newpage \n')
  cat('\\section{Subgroups -- ', rVersion, '}')
  
  PrintGroupSummary(groupDatasets[[(i-1)*2 + 1]], title=paste(rVersion, "-- Newer Version of Links"))
  PrintGroupSummary(groupDatasets[[(i-1)*2 + 2]], title=paste(rVersion, "-- Older Version of Links"))  
}

# mean(!is.na(dsDirtyNewer$RFull)) 
# mean(!is.na(dsDirtyNewer[!is.na(dsDirtyNewer[, oName_1]) & !is.na(dsDirtyNewer[, oName_2]), "RFull"])) 

## @knitr EvalAndPrintAce

# evaluate_ace ------------------------------------------------------------


PrintAces <- function(  ) {
  dsT <- dsAce
  dsT <- cbind(dsT[, 1], numcolwise(round)(dsT,digits=2))
  dsT <- cbind(dsT[, 1], numcolwise(scales::comma)(dsT))
  dsT <- t(apply(dsT, 1, function(x) gsub("^0.", ".", x)))
  
  colnames(dsT) <- c("$R$ Variant", "$a_{new}^2$", "$c_{new}^2$", "$e_{new}^2$", "$N_{new}$", "$a_{old}^2$", "$c_{old}^2$", "$e_{old}^2$", "$N_{old}$")
  digitsFormat <- 2# c(0,1,3,3,3,3,3,3) #Include a dummy at the beginning, for the row.names.
  alignnment <- "ll|rrrr|rrrr" #Include an initial dummy for the (suppressed) row names.
  textTable <- xtable(dsT, caption="Comparison of R Variants (by rows) and of Links Versions (left vs right side).", digits=digitsFormat, align=alignnment)
  print(textTable, include.rownames=F, size="large", sanitize.text.function = function(x) {x}, floating=T)
}
PrintAces()
# summary(dsAce)
