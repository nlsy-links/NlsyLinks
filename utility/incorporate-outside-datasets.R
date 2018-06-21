#This isn't part of the build process.  They should be executed infrequently, not for every build.
#   Run it when there's a chance the extract data is different, or there's been a new version frrom NlsyLinksDetermination
rm(list=ls(all=TRUE))
if( any(search()=="package:NlsyLinks") ) detach("package:NlsyLinks") #So the lazy-loaded datasets aren't available
# if( any(.packages(all.available=TRUE) == "NlsyLinks") ) remove.packages("NlsyLinks") #system("R CMD REMOVE NlsyLinks") #This shouldn't be necesary.
library(magrittr)
library(RODBC)
# require(NlsyLinks) #Don't load' the lazy-loaded datasets shouldn't be accessible

###############################################################
###  Declare Paths
###############################################################
directoryDatasetsCsv <- "./outside-data" #These CSVs are in the repository, but not in the build.
directoryDatasetsRda <- "./data" #These RDAs are derived from the CSV, and included in the build as compressed binaries.
algorithmVersion <- 85L

pathInputLinks              <- file.path(directoryDatasetsCsv, paste0("links-2011-v"     , algorithmVersion, ".csv"))
pathInputSubjectDetails     <- file.path(directoryDatasetsCsv, paste0("subject-details-v", algorithmVersion, ".csv"))
pathInputSurveyDate         <- file.path(directoryDatasetsCsv, paste0("survey-time.csv"))

pathOutputExtraOutcomes     <- file.path(directoryDatasetsRda, "ExtraOutcomes79.rda")
pathOutputLinkTrim          <- file.path(directoryDatasetsRda, "Links79Pair.rda")
pathOutputLinkExpanded      <- file.path(directoryDatasetsRda, "Links79PairExpanded.rda")
pathOutputSubjectDetails    <- file.path(directoryDatasetsRda, "SubjectDetails79.rda")
pathOutputSurveyDate        <- file.path(directoryDatasetsRda, "SurveyDate.rda")

###############################################################
###  ExtraOutcomes79
ExtraOutcomes79             <- read.csv(file.path(directoryDatasetsCsv, "extra-outcomes-79.csv"))
# ExtraOutcomes79$SubjectTag <- as.integer(round(ExtraOutcomes79$SubjectTag))

sapply(ExtraOutcomes79, class)
save(ExtraOutcomes79, file=pathOutputExtraOutcomes, compress="xz")

###############################################################
###  Links79PairExpanded and Links79Pair
dsLinks79PairWithoutOutcomes <- pathInputLinks %>% 
  read.csv(stringsAsFactors=FALSE) %>% 
  dplyr::select(-MultipleBirthIfSameSex, -RImplicitSubject, -RImplicitMother)


ExtraOutcomes79$SubjectTag <- NlsyLinks::CreateSubjectTag(subjectID=ExtraOutcomes79$SubjectID, generation=ExtraOutcomes79$Generation)
# colnames(dsLinks79PairWithoutOutcomes)
remaining           <- setdiff(colnames(dsLinks79PairWithoutOutcomes),  c("SubjectTag_S1", "SubjectTag_S2"))
relationshipLabels  <- c("Gen1Housemates","Gen2Siblings","Gen2Cousins","ParentChild", "AuntNiece")

Links79PairExpanded <- c("MathStandardized", "HeightZGenderAge") %>% 
  NlsyLinks::CreatePairLinksSingleEntered(
    outcomeNames      = .,
    outcomeDataset    = ExtraOutcomes79,
    linksPairDataset  = dsLinks79PairWithoutOutcomes,
    linksNames        = remaining
  ) %>% 
  dplyr::filter(SubjectTag_S1 < SubjectTag_S2) %>% 
  dplyr::mutate(
    RelationshipPath  = factor(RelationshipPath, levels=seq_along(relationshipLabels), labels=relationshipLabels),
    IsMz              = factor(IsMz            , levels=c(0, 1, 255), labels=c("No", "Yes", "DoNotKnow")),
    EverSharedHouse   = as.logical(EverSharedHouse)
    
  ) %>% 
  dplyr::select(-RImplicitDifference) %>% 
  dplyr::arrange(ExtendedID, SubjectTag_S1, SubjectTag_S2)


### Prepare for rda
# multipleBirthLabels <- c("No", "Twin", "Triplet", "DoNotKnow")
# Links79PairExpanded$MultipleBirth <- factor(Links79PairExpanded$MultipleBirth, levels=c(0, 2, 3, 255), labels=multipleBirthLabels)

Links79Pair <- Links79PairExpanded %>% 
  dplyr::select(ExtendedID, SubjectTag_S1, SubjectTag_S2, R, RelationshipPath)

save(Links79Pair, file=pathOutputLinkTrim, compress="xz")
save(Links79PairExpanded, file=pathOutputLinkExpanded, compress="xz")

###############################################################
###  SubjectDetails
SubjectDetails79 <- read.csv(pathInputSubjectDetails, stringsAsFactors=TRUE)

vectorOfTwins <- sort(unique(unlist(Links79PairExpanded[Links79PairExpanded$IsMz=="Yes", c("SubjectTag_S1", "SubjectTag_S2")])))

SubjectDetails79 <- SubjectDetails79 %>% 
  dplyr::mutate(
    Gender          = factor(Gender, levels=1:2, labels=c("Male", "Female")),
    RaceCohort      = factor(RaceCohort, levels=1:3, labels=c("Hispanic", "Black", "Nbnh")), #R02147.00 $ C00053.00
    IsMz            = (SubjectTag %in% vectorOfTwins),
    Mob             = as.Date(as.character(Mob))
  ) %>% 
  dplyr::select(
    -IsDead,          #This isn't finished yet.
    -DeathDate        #This isn't finished yet.
  )

save(SubjectDetails79, file=pathOutputSubjectDetails, compress="xz")

###############################################################
###  SurveyDate
SurveyDate <- read.csv(pathInputSurveyDate, stringsAsFactors=FALSE)

SurveyDate$SurveySource <- factor(SurveyDate$SurveySource, levels=0:3, labels=c("NoInterview", "Gen1", "Gen2C", "Gen2YA"))
SurveyDate$SurveyDate <- as.Date(SurveyDate$SurveyDate)
SurveyDate$Age <- ifelse(!is.na(SurveyDate$AgeCalculateYears), SurveyDate$AgeCalculateYears, SurveyDate$AgeSelfReportYears)

sapply(SurveyDate, class)
save(SurveyDate, file=pathOutputSurveyDate, compress="xz")
