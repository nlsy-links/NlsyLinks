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

  d %>%
    dplyr::group_by(ExtendedID) %>%
    dplyr::summarize(
      LinkCountWithinFamily = dplyr::n(),
      # SisterCountWithinFamily = dplyr::recode(LinkCountWithinFamily, `1`=2, `3`=3, `6`=4, `10`=5),
      SisterCountWithinFamily = as.integer(round(uniroot(function(k) k*(k-1) / 2 - LinkCountWithinFamily, c(0.5, 100))$root))
    ) %>%
    dplyr::ungroup() %>%
    dplyr::count(LinkCountWithinFamily, SisterCountWithinFamily) %>%
    dplyr::rename(FamilyCount = n) %>%
    knitr::kable( )
}
# k(k-1)/2 = a
# k*k  - k = 2a
# k*k  - k - 2 = 2a -2
# (k-2)(k+1) = 2a - 2
# k =
# a <- c(0)
# uniroot(function(k) k*(k-1) / 2 - a, c(.5, 100))$root
# as.integer(round(uniroot(function(k) k*(k-1) / 2 - a, c(.5, 100))$root))
#
# a <- c(0, 1, 3, 6, 10)
# a %>%
#   purrr::map_int(
#     .,
#     ~as.integer(round(uniroot(function(k) k*(k-1) / 2 - ., c(.5, 100))$root))
#   )


#  k  a
#  1  0
#  2  1
#  3  3
#  4  6
#  5 10

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




# Q2a: How many Gen1 sister pairs where we know if they've had Gen2 kids.  (There's a small chance the woman dropped out of study before offspring began to be tracked in the early 1980s)
# A2a: 1289 links among 865 distinct families.
ds_gen1_link_sisters_kid_count_nonmissing <-
  ds_gen1_link_sisters %>%
  tidyr::drop_na(KidCountBio_S1) %>%
  tidyr::drop_na(KidCountBio_S2)

count_pretty(ds_gen1_link_sisters_kid_count_nonmissing)

# Q2b: Of these, how many sister pairs where both Gen1 sisters have 1+ biological Gen2 kids.
# A2b: 832 links among 607 distinct families.

ds_gen1_link_sisters_kid_count_positive <-
  ds_gen1_link_sisters_kid_count_nonmissing %>%
  dplyr::filter(1L <= KidCountBio_S1) %>%
  dplyr::filter(1L <= KidCountBio_S2)

count_pretty(ds_gen1_link_sisters_kid_count_positive)
sum(ds_gen1_link_sisters_kid_count_positive$KidCountBio_S1)
sum(ds_gen1_link_sisters_kid_count_positive$KidCountBio_S2)

# NlsyLinks::SubjectDetails79 %>% tibble::as_tibble()

ds_gen2_link <-
  Links79PairExpanded %>%
  tibble::as_tibble() %>%
  dplyr::filter(RelationshipPath == "Gen2Siblings") %>%
  # dplyr::filter(ExtendedID %in% unique(ds_gen1_link_sisters_kid_count_positive$ExtendedID)) %>%
  dplyr::mutate(
    MomTag  = as.integer(as.integer(SubjectTag_S1 / 100) * 100)
  ) %>%
  dplyr::filter(
    MomTag %in% unique(c(
      ds_gen1_link_sisters_kid_count_positive$SubjectTag_S1,
      ds_gen1_link_sisters_kid_count_positive$SubjectTag_S2
    ))
  )

# Q3a: from these Gen1 moms, how many in which 0, 1, 2 Gen1 sisters
#      who are mothers of twins ( if possible with zygositynfor their offspring)
count_pretty(ds_gen2_link)

# ds_gen2_link %>%
#   dplyr::group_by(MomTag) %>%
#   dplyr::summarize(
#     IsMzCount     = sum(IsMz == "Yes")
#   ) %>%
#   dplyr::ungroup()

# table(ds_gen2_offspring[, c("R", "IsMz")])

# > table(ds_gen2_offspring[, c("R", "IsMz")])
#        IsMz
# R       No Yes DoNotKnow
#   0.375  1   0         0
#   0.5   42   0         0
#   1      0   1         0
