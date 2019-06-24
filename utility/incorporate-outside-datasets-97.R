#This isn't part of the build process.  They should be executed infrequently, not for every build.
#   Run it when there's a chance the extract data is different, or there's been a new version frrom NlsyLinksDetermination

rm(list=ls(all=TRUE))  #Clear the variables from previous runs.
if( any(search()=="package:NlsyLinks") ) detach("package:NlsyLinks") #So the lazy-loaded datasets aren't available

# ---- load-sources ------------------------------------------------------------
# if( any(.packages(all.available=TRUE) == "NlsyLinks") ) remove.packages("NlsyLinks") #system("R CMD REMOVE NlsyLinks") #This shouldn't be necesary.
library(magrittr)
# require(NlsyLinks) #Don't load' the lazy-loaded datasets shouldn't be accessible

requireNamespace("readr"        )
requireNamespace("tidyr"        )
requireNamespace("dplyr"        )

# ---- declare-globals ---------------------------------------------------------
directoryDatasetsCsv <- "./outside-data/nlsy-97" #These CSVs are in the repository, but not in the build.
directoryDatasetsRda <- "./data" #These RDAs are derived from the CSV, and included in the build as compressed binaries.
algorithmVersion     <- 11L

pathInputLinks              <- file.path(directoryDatasetsCsv, paste0("links-2017-97.csv"))
# pathInputLinks              <- file.path(directoryDatasetsCsv, paste0("links-2017-97-v"  , algorithmVersion, ".csv"))
# pathInputSubjectDetails     <- file.path(directoryDatasetsCsv, paste0("subject-details-v", algorithmVersion, ".csv"))
# pathInputSurvey97           <- file.path(directoryDatasetsCsv, paste0("survey-time.csv"))
# pathInputExtraOutcomes79    <- file.path(directoryDatasetsCsv, "extra-outcomes-79.csv")

# pathOutputExtraOutcomes     <- file.path(directoryDatasetsRda, "ExtraOutcomes79.rda")
pathOutputLinkTrim          <- file.path(directoryDatasetsRda, "Links97Pair.rda")
pathOutputLinkExpanded      <- file.path(directoryDatasetsRda, "Links97PairExpanded.rda")
# pathOutputSubjectDetails    <- file.path(directoryDatasetsRda, "SubjectDetails79.rda")
# pathOutputSurvey97          <- file.path(directoryDatasetsRda, "Survey97.rda")

col_types_links <- readr::cols_only(
  ExtendedID                     = readr::col_integer(),
  SubjectTag_S1                  = readr::col_integer(),
  SubjectTag_S2                  = readr::col_integer(),
  SubjectID_S1                   = readr::col_integer(),
  SubjectID_S2                   = readr::col_integer(),
  RelationshipPath               = readr::col_integer(),
  EverSharedHouse                = readr::col_logical(),
  R                              = readr::col_double(),
  RFull                          = readr::col_double(),
  MultipleBirthIfSameSex         = readr::col_integer(),
  IsMz                           = readr::col_integer(),
  LastSurvey_S1                  = readr::col_integer(),
  LastSurvey_S2                  = readr::col_integer(),
  # RImplicitPass1                 = readr::col_double(),
  # RImplicit                      = readr::col_double(),
  # RExplicit                      = readr::col_double(),
  # RExplicitPass1                 = readr::col_double(),
  RPass1                         = readr::col_double()
  # RExplicitOlderSibVersion       = readr::col_double(),
  # RExplicitYoungerSibVersion     = readr::col_double(),
  # RImplicitSubject               = readr::col_double(),
  # RImplicitMother                = readr::col_double()
)

# ---- load-data ---------------------------------------------------------------
# readr::spec_csv(pathInputLinks)
dsLinksWithoutOutcomes          <- readr::read_csv(pathInputLinks       , col_types=col_types_links)
# ExtraOutcomes79               <- read.csv(pathInputExtraOutcomes79   , stringsAsFactors=TRUE )
# SubjectDetails79              <- read.csv(pathInputSubjectDetails    , stringsAsFactors=TRUE )
# Survey97                      <- read.csv(pathInputSurvey97          , stringsAsFactors=FALSE)

rm(pathInputLinks, col_types_links)

# ---- tweak-data --------------------------------------------------------------

# # ---- Groom ExtraOutcomes97 ---------------------------------------------------------
# ExtraOutcomes79 <- ExtraOutcomes79 %>%
#   as.data.frame()

# ---- Groom Links79PairExpanded and Links79Pair -------------------------------------
# dsLinksWithoutOutcomes <- dsLinksWithoutOutcomes %>%
#   dplyr::select(-MultipleBirthIfSameSex, -RImplicitSubject, -RImplicitMother)

# ExtraOutcomes79WithTags <- ExtraOutcomes79 %>%
#   dplyr::mutate(
#     SubjectTag = NlsyLinks::CreateSubjectTag(subjectID=SubjectID, generation=Generation)
#   )

# remaining           <- setdiff(colnames(dsLinksWithoutOutcomes),  c("SubjectTag_S1", "SubjectTag_S2"))
#
# Links79PairExpanded <- c("MathStandardized", "HeightZGenderAge") %>%
#   NlsyLinks::CreatePairLinksSingleEntered(
#     outcomeNames      = .,
#     outcomeDataset    = ExtraOutcomes79WithTags,
#     linksPairDataset  = dsLinksWithoutOutcomes,
#     linksNames        = remaining
#   ) %>%
#   dplyr::filter(SubjectTag_S1 < SubjectTag_S2) %>%
#   dplyr::mutate(
#     RelationshipPath  = factor(RelationshipPath, levels=seq_along(relationshipLabels), labels=relationshipLabels),
#     IsMz              = factor(IsMz            , levels=c(0, 1, 255), labels=c("No", "Yes", "DoNotKnow")),
#     EverSharedHouse   = as.logical(EverSharedHouse)
#   ) %>%
#   dplyr::select(-RImplicitDifference) %>%
#   dplyr::arrange(ExtendedID, SubjectTag_S1, SubjectTag_S2) %>%
#   as.data.frame()
Links97PairExpanded <-
  dsLinksWithoutOutcomes %>%
  dplyr::mutate(
    RelationshipPath  = factor(RelationshipPath, levels=c(1L)           , labels=c("Housemates")),
    IsMz              = factor(IsMz            , levels=c(0L, 1L, 255L) , labels=c("No", "Yes", "DoNotKnow"))
  ) %>%
  dplyr::select(
    ExtendedID,
    SubjectTag_S1,
    SubjectTag_S2,
    R,
    RFull,
    RelationshipPath,
    EverSharedHouse,
    IsMz,
    LastSurvey_S1,
    LastSurvey_S2,
    # RImplicitPass1,
    # RImplicit,
    # RImplicit2004,
    # RExplicitPass1,
    # RExplicit,
    # RExplicitOlderSibVersion,
    # RExplicitYoungerSibVersion,
    RPass1,
    SubjectID_S1,
    SubjectID_S2
  ) %>%
  dplyr::arrange(ExtendedID, SubjectTag_S1, SubjectTag_S2) %>%
  as.data.frame()


# multipleBirthLabels <- c("No", "Twin", "Triplet", "DoNotKnow")
# Links79PairExpanded$MultipleBirth <- factor(Links79PairExpanded$MultipleBirth, levels=c(0, 2, 3, 255), labels=multipleBirthLabels)

Links97Pair <-
  Links97PairExpanded %>%
  dplyr::select(ExtendedID, SubjectTag_S1, SubjectTag_S2, R, RelationshipPath) %>%
  as.data.frame()

# # ---- Groom SubjectDetails ----------------------------------------------------------
# vectorOfTwins <- sort(unique(unlist(Links79PairExpanded[Links79PairExpanded$IsMz=="Yes", c("SubjectTag_S1", "SubjectTag_S2")])))
#
# SubjectDetails79 <- SubjectDetails79 %>%
#   dplyr::mutate(
#     Gender          = factor(Gender, levels=1:2, labels=c("Male", "Female")),
#     RaceCohort      = factor(RaceCohort, levels=1:3, labels=c("Hispanic", "Black", "Nbnh")), #R02147.00 $ C00053.00
#     IsMz            = (SubjectTag %in% vectorOfTwins),
#     Mob             = as.Date(as.character(Mob))
#   ) %>%
#   dplyr::select(
#     -IsDead,          #This isn't finished yet.
#     -DeathDate        #This isn't finished yet.
#   ) %>%
#   as.data.frame()
#
# # ---- Groom Survey97 --------------------------------------------------------------
# Survey97 <- Survey97 %>%
#   dplyr::mutate(
#     SurveySource  = factor(SurveySource, levels=0:3, labels=c("NoInterview", "Gen1", "Gen2C", "Gen2YA")),
#     Survey97      = as.Date(Survey97),
#     Age           = ifelse(!is.na(AgeCalculateYears), AgeCalculateYears, AgeSelfReportYears)
#   ) %>%
#   dplyr::arrange(SubjectTag, SurveySource, SurveyYear) %>%
#   as.data.frame()

# ---- verify-values -----------------------------------------------------------

# checkmate::assert_data_frame(ExtraOutcomes79      , min.rows=100)
checkmate::assert_data_frame(Links97Pair          , min.rows=100)
checkmate::assert_data_frame(Links97PairExpanded  , min.rows=100)

# ---- save-to-disk ------------------------------------------------------------
# save(ExtraOutcomes79            , file=pathOutputExtraOutcomes      , compress="xz")
save(Links97Pair                , file=pathOutputLinkTrim           , compress="xz")
save(Links97PairExpanded        , file=pathOutputLinkExpanded       , compress="xz")
