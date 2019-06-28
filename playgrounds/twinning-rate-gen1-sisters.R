# If necessary: remotes::install_github("nlsy-links/NlsyLinks")
library(NlsyLinks)
library(magrittr)

count_pretty <- function( d ) {
  message(
    nrow(d),
    " links among ",
    dplyr::n_distinct(d$ExtendedID),
    " distinct families."
  )
}

ds_gen1_link_sisters <-
  Links79PairExpanded %>%
  tibble::as_tibble() %>%
  dplyr::filter(RelationshipPath == "Gen1Housemates") %>%
  dplyr::left_join(
    NlsyLinks::SubjectDetails79 %>%
      dplyr::select(
        SubjectTag,
        Gender_S1       = Gender,
        KidCountBio_S1  = KidCountBio
      ),
    by = c("SubjectTag_S1" = "SubjectTag")
  ) %>%
  dplyr::left_join(
    NlsyLinks::SubjectDetails79 %>%
      dplyr::select(
        SubjectTag,
        Gender_S2       = Gender,
        KidCountBio_S2  = KidCountBio
      ),
    by = c("SubjectTag_S2" = "SubjectTag")
  ) %>%
  # dplyr::filter(R == 1) %>%
  dplyr::filter(Gender_S1 == "Female") %>%
  dplyr::filter(Gender_S2 == "Female") %>%
  dplyr::select(
    SubjectTag_S1,
    SubjectTag_S2,
    ExtendedID,
    R,
    IsMz,
    KidCountBio_S1,
    KidCountBio_S2
  )

# Q1: How many Gen1 sister pairs
# A1: 1289 links among 865 distinct families
count_pretty(ds_gen1_link_sisters)


# Q2a: How many Gen1 sister pairs where we know if they've had kids.  (There's a small chance the woman dropped out of study before offspring began to be tracked in the early 1980s)
# A2a: 1289 links among 865 distinct families.
ds_gen1_link_sisters_kid_count_nonmissing <-
  ds_gen1_link_sisters %>%
  tidyr::drop_na(KidCountBio_S1) %>%
  tidyr::drop_na(KidCountBio_S2)

count_pretty(ds_gen1_link_sisters_kid_count_nonmissing)

# Q2b: Of these, how many sister pairs where both sisters have 1+ biological kids.
# A2b: 832 links among 607 distinct families.

ds_gen1_link_sisters_kid_count_positive <-
  ds_gen1_link_sisters_kid_count_nonmissing %>%
  dplyr::filter(1L <= KidCountBio_S1)%>%
  dplyr::filter(1L <= KidCountBio_S2)

count_pretty(ds_gen1_link_sisters_kid_count_positive)

# NlsyLinks::SubjectDetails79 %>% tibble::as_tibble()

# ds_gen2_offspring <-
#   Links79PairExpanded %>%
#   tibble::as_tibble() %>%
#   dplyr::filter(RelationshipPath == "Gen2Siblings") %>%
#   dplyr::filter(ExtendedID %in% unique(ds_gen1_multiples$ExtendedID))
#
# table(ds_gen2_offspring[, c("R", "IsMz")])

# > table(ds_gen2_offspring[, c("R", "IsMz")])
#        IsMz
# R       No Yes DoNotKnow
#   0.375  1   0         0
#   0.5   42   0         0
#   1      0   1         0
