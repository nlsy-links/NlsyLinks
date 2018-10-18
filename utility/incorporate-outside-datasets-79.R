 #This isn't part of the build process.  They should be executed infrequently, not for every build.
#   Run it when there's a chance the extract data is different, or there's been a new version frrom NlsyLinksDetermination

# knitr::stitch_rmd(script="./manipulation/te-ellis.R", output="./stitched-output/manipulation/te-ellis.md") # dir.create("./stitched-output/manipulation/", recursive=T)
# For a brief description of this file see the presentation at
#   - slides: https://rawgit.com/wibeasley/RAnalysisSkeleton/master/documentation/time-and-effort-synthesis.html#/
#   - code: https://github.com/wibeasley/RAnalysisSkeleton/blob/master/documentation/time-and-effort-synthesis.Rpres
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
directoryDatasetsCsv <- "./outside-data/nlsy-79" #These CSVs are in the repository, but not in the build.
directoryDatasetsRda <- "./data" #These RDAs are derived from the CSV, and included in the build as compressed binaries.
algorithmVersion     <- 85L

pathInputLinks              <- file.path(directoryDatasetsCsv, paste0("links-2011-v"     , algorithmVersion, ".csv"))
pathInputSubjectDetails     <- file.path(directoryDatasetsCsv, paste0("subject-details-v", algorithmVersion, ".csv"))
pathInputSurvey79           <- file.path(directoryDatasetsCsv, paste0("survey-79.csv"))
pathInputExtraOutcomes79    <- file.path(directoryDatasetsCsv, "extra-outcomes-79.csv")

pathOutputExtraOutcomes     <- file.path(directoryDatasetsRda, "ExtraOutcomes79.rda")
pathOutputLinkTrim          <- file.path(directoryDatasetsRda, "Links79Pair.rda")
pathOutputLinkExpanded      <- file.path(directoryDatasetsRda, "Links79PairExpanded.rda")
pathOutputSubjectDetails    <- file.path(directoryDatasetsRda, "SubjectDetails79.rda")
pathOutputSurvey79          <- file.path(directoryDatasetsRda, "Survey79.rda")

col_types_pair <- readr::cols_only(
  ExtendedID                    = readr::col_integer(),
  SubjectTag_S1                 = readr::col_integer(),
  SubjectTag_S2                 = readr::col_integer(),
  RelationshipPath              = readr::col_integer(),
  EverSharedHouse               = readr::col_integer(),
  R                             = readr::col_double(),
  RFull                         = readr::col_double(),
  MultipleBirthIfSameSex        = readr::col_integer(),
  IsMz                          = readr::col_integer(),
  LastSurvey_S1                 = readr::col_integer(),
  LastSurvey_S2                 = readr::col_integer(),
  RImplicitPass1                = readr::col_double(),
  RImplicit                     = readr::col_double(),
  RImplicit2004                 = readr::col_double(),
  RImplicitDifference           = readr::col_double(),
  RExplicit                     = readr::col_double(),
  RExplicitPass1                = readr::col_double(),
  RPass1                        = readr::col_double(),
  RExplicitOlderSibVersion      = readr::col_double(),
  RExplicitYoungerSibVersion    = readr::col_double(),
  RImplicitSubject              = readr::col_double(),
  RImplicitMother               = readr::col_double(),
  Generation_S1                 = readr::col_integer(),
  Generation_S2                 = readr::col_integer(),
  SubjectID_S1                  = readr::col_integer(),
  SubjectID_S2                  = readr::col_integer()
)
col_types_outcomes <- readr::cols_only(
  SubjectTag                  = readr::col_integer(),
  SubjectID                   = readr::col_integer(),
  Generation                  = readr::col_integer(),
  HeightZGenderAge            = readr::col_double(),
  WeightZGenderAge            = readr::col_double(),
  AfqtRescaled2006Gaussified  = readr::col_double(),
  Afi                         = readr::col_integer(),
  Afm                         = readr::col_integer(),
  MathStandardized            = readr::col_double()
)

col_types_subject_details <- readr::cols_only(
  SubjectTag                = readr::col_integer(),
  ExtendedID                = readr::col_integer(),
  Generation                = readr::col_integer(),
  Gender                    = readr::col_integer(),
  RaceCohort                = readr::col_integer(),
  SiblingCountInNls         = readr::col_integer(),
  BirthOrderInNls           = readr::col_integer(),
  SimilarAgeCount           = readr::col_integer(),
  HasMzPossibly             = readr::col_integer(),
  KidCountBio               = readr::col_integer(),
  KidCountInNls             = readr::col_integer(),
  Mob                       = readr::col_date(format = ""),
  LastSurveyYearCompleted   = readr::col_integer(),
  AgeAtLastSurvey           = readr::col_double(),
  IsDead                    = readr::col_integer(),
  DeathDate                 = readr::col_date(format = "")
)

col_types_survey <- readr::cols_only(
  SubjectTag          = readr::col_integer(),
  SurveySource        = readr::col_integer(),
  SurveyYear          = readr::col_integer(),
  SurveyDate          = readr::col_date(format = ""),
  AgeSelfReportYears  = readr::col_double(),
  AgeCalculateYears   = readr::col_double()
)

# ---- load-data ---------------------------------------------------------------
dsLinks79PairWithoutOutcomes  <- readr::read_csv(pathInputLinks              , col_types=col_types_pair)
ExtraOutcomes79               <- readr::read_csv(pathInputExtraOutcomes79    , col_types=col_types_outcomes)
SubjectDetails79              <- readr::read_csv(pathInputSubjectDetails     , col_types=col_types_subject_details)
Survey79                      <- readr::read_csv(pathInputSurvey79           , col_types=col_types_survey)

# ---- tweak-data --------------------------------------------------------------

# ---- Groom ExtraOutcomes79 ---------------------------------------------------------
ExtraOutcomes79 <- ExtraOutcomes79 %>%
  as.data.frame()

# ---- Groom Links79PairExpanded and Links79Pair -------------------------------------
dsLinks79PairWithoutOutcomes <-
  dsLinks79PairWithoutOutcomes %>%
  dplyr::select(-MultipleBirthIfSameSex, -RImplicitSubject, -RImplicitMother)

ExtraOutcomes79WithTags <-
  ExtraOutcomes79 %>%
  dplyr::mutate(
    SubjectTag = NlsyLinks::CreateSubjectTag(subjectID=SubjectID, generation=Generation)
  ) %>%
  as.data.frame()

remaining           <- setdiff(colnames(dsLinks79PairWithoutOutcomes),  c("SubjectTag_S1", "SubjectTag_S2"))
relationshipLabels  <- c("Gen1Housemates","Gen2Siblings","Gen2Cousins","ParentChild", "AuntNiece")

Links79PairExpanded <-
  c("MathStandardized", "HeightZGenderAge") %>%
  NlsyLinks::CreatePairLinksSingleEntered(
    outcomeNames      = .,
    outcomeDataset    = ExtraOutcomes79WithTags,
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
  dplyr::arrange(ExtendedID, SubjectTag_S1, SubjectTag_S2) %>%
  as.data.frame()

# multipleBirthLabels <- c("No", "Twin", "Triplet", "DoNotKnow")
# Links79PairExpanded$MultipleBirth <- factor(Links79PairExpanded$MultipleBirth, levels=c(0, 2, 3, 255), labels=multipleBirthLabels)

Links79Pair <-
  Links79PairExpanded %>%
  dplyr::select(ExtendedID, SubjectTag_S1, SubjectTag_S2, R, RelationshipPath) %>%
  as.data.frame()

# ---- Groom SubjectDetails ----------------------------------------------------------
vectorOfTwins <- sort(unique(unlist(Links79PairExpanded[Links79PairExpanded$IsMz=="Yes", c("SubjectTag_S1", "SubjectTag_S2")])))

SubjectDetails79 <-
  SubjectDetails79 %>%
  dplyr::mutate(
    Gender          = factor(Gender, levels=1:2, labels=c("Male", "Female")),
    RaceCohort      = factor(RaceCohort, levels=1:3, labels=c("Hispanic", "Black", "Nbnh")), #R02147.00 $ C00053.00
    IsMz            = (SubjectTag %in% vectorOfTwins),
    Mob             = as.Date(as.character(Mob))
  ) %>%
  dplyr::select(
    -IsDead,          #This isn't finished yet.
    -DeathDate        #This isn't finished yet.
  ) %>%
  as.data.frame()

# ---- Groom Survey79 --------------------------------------------------------------
Survey79 <-
  Survey79 %>%
  dplyr::mutate(
    SurveySource  = factor(SurveySource, levels=0:3, labels=c("NoInterview", "Gen1", "Gen2C", "Gen2YA")),
    SurveyDate    = as.Date(SurveyDate),
    Age           = ifelse(!is.na(AgeCalculateYears), AgeCalculateYears, AgeSelfReportYears)
  ) %>%
  dplyr::arrange(SubjectTag, SurveySource, SurveyYear) %>%
  as.data.frame()

# ---- verify-values -----------------------------------------------------------

checkmate::assert_data_frame(ExtraOutcomes79      , min.rows=100)
checkmate::assert_data_frame(Links79Pair          , min.rows=100)
checkmate::assert_data_frame(Links79PairExpanded  , min.rows=100)
checkmate::assert_data_frame(SubjectDetails79     , min.rows=100)
checkmate::assert_data_frame(Survey79             , min.rows=100)

# ---- save-to-disk ------------------------------------------------------------
save(ExtraOutcomes79            , file=pathOutputExtraOutcomes      , compress="xz")
save(Links79Pair                , file=pathOutputLinkTrim           , compress="xz")
save(Links79PairExpanded        , file=pathOutputLinkExpanded       , compress="xz")
save(SubjectDetails79           , file=pathOutputSubjectDetails     , compress="xz")
save(Survey79                   , file=pathOutputSurvey79           , compress="xz")
