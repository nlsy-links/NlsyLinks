# If necessary: remotes::install_github("nlsy-links/NlsyLinks")
library(NlsyLinks)
library(magrittr)

count_pretty <- function( d ) {
  message(
    nrow(d),
    " links among ",
    dplyr::n_distinct(c(d$SubjectTag_S1, d$SubjectTag_S2)),
    " distinct people and ",
    dplyr::n_distinct(d$ExtendedID),
    " distinct families."
  )

  d %>%
    dplyr::group_by(ExtendedID) %>%
    dplyr::summarize(
      LinkCountWithinFamily = dplyr::n(),
      # SisterCountWithinFamily = dplyr::recode(LinkCountWithinFamily, `1`=2, `3`=3, `6`=4, `10`=5),
      PersonCountWithinFamily = as.integer(round(uniroot(function(k) k*(k-1) - 2 * LinkCountWithinFamily, c(0.5, 100))$root))
    ) %>%
    dplyr::ungroup() %>%
    dplyr::count(LinkCountWithinFamily, PersonCountWithinFamily) %>%
    dplyr::rename(FamilyCount = n) %>%
    knitr::kable( )
}
# k(k-1)/2 = a
# k*k  - k = 2a
# k*k  - k - 2 = 2a -2
# (k-2)(k+1) = 2a - 2
# k =


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
# A1: 1289 links among 1926 distinct people and 865 distinct families.
#     Each link immediately below represents one Gen1 sister pair.
count_pretty(ds_gen1_link_sisters)


# Q2a: How many Gen1 sister pairs where we know if they've had Gen2 kids.  (There's a small chance the woman dropped out of study before offspring began to be tracked in the early 1980s)
# A2a: 1289 links among 1926 distinct people and 865 distinct families.
#      Each link immediately below represents one Gen1 sister pair.
ds_gen1_link_sisters_kid_count_nonmissing <-
  ds_gen1_link_sisters %>%
  tidyr::drop_na(KidCountBio_S1) %>%
  tidyr::drop_na(KidCountBio_S2)

count_pretty(ds_gen1_link_sisters_kid_count_nonmissing)

# Q2b: Of these, how many sister pairs where both Gen1 sisters have 1+ biological Gen2 kids.
# A2b: 832 links among 1321 distinct people and 607 distinct families.
#      Each link immediately below represents one Gen1 sister pair.
ds_gen1_link_sisters_kid_count_positive <-
  ds_gen1_link_sisters_kid_count_nonmissing %>%
  dplyr::filter(1L <= KidCountBio_S1) %>%
  dplyr::filter(1L <= KidCountBio_S2)

count_pretty(ds_gen1_link_sisters_kid_count_positive)
# sum(ds_gen1_link_sisters_kid_count_positive$KidCountBio_S1)
# sum(ds_gen1_link_sisters_kid_count_positive$KidCountBio_S2)

# NlsyLinks::SubjectDetails79 %>% tibble::as_tibble()


# Q3a: from these Gen1 *moms*, how many kids does each have?
# A3a: 3218 links among 2917 distinct people and 575 distinct families.
#      Each link immediately below represents a Gen2Sibling pair

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
  ) %>%
  dplyr::left_join(
    NlsyLinks::SubjectDetails79 %>%
      dplyr::select(
        SubjectTag,
        mob_s1          = Mob
      ),
    by = c("SubjectTag_S1" = "SubjectTag")
  ) %>%
  dplyr::left_join(
    NlsyLinks::SubjectDetails79 %>%
      dplyr::select(
        SubjectTag,
        mob_s2          = Mob
      ),
    by = c("SubjectTag_S2" = "SubjectTag")
  ) %>%
  dplyr::mutate(
    mob_difference  = as.integer(difftime(mob_s2, mob_s1, units = "days")),
    is_dz_maybe   = (abs(mob_difference) < 45) & (IsMz != "Yes")
  ) %>%
  dplyr::select(
    ExtendedID,
    MomTag,
    SubjectTag_S1,
    SubjectTag_S2,
    RFull,
    IsMz,
    mob_s1,
    mob_s2,
    # mob_difference,
    is_dz_maybe
  )
count_pretty(ds_gen2_link)


# Q3b: from these Gen1 *sisters*(ie, mom-pairs), how many kids does each (in the sister pair) have?
ds_gen1_link_sisters_kid_count_positive %>%
  dplyr::count(KidCountBio_S1, KidCountBio_S2)
table(ds_gen1_link_sisters_kid_count_positive[, c("KidCountBio_S1", "KidCountBio_S2")])

# Q3c: Among the Gen1 sister pairs where each had 1+ kids, how many MZs were born
# A3c: 7 MZs were born to these Gen1 moms.  0 of the MZs' moms were sisters.
ds_gen1_mom <-
  ds_gen2_link %>%
  dplyr::group_by(ExtendedID, MomTag) %>%
  dplyr::summarize(
    gen2_link_count   = dplyr::n(),
    gen2_offspring    = dplyr::n_distinct(c(SubjectTag_S1, SubjectTag_S2)),
    mz_link_count     = sum(IsMz == "Yes"),
    is_dz_maybe_count = sum(is_dz_maybe, na.rm=T)
  ) %>%
  dplyr::ungroup()

ds_gen1_mom_with_twins <-
  ds_gen1_mom %>%
  dplyr::filter(
    1L <= mz_link_count
    |
    1L <= is_dz_maybe_count
  )

table(table(ds_gen1_mom_with_twins$ExtendedID))
ds_gen1_mom_with_twins %>%
  print(n = 50)


# Q3?: like before, but add dimensions of MZ count and DZ count
# count_pretty(ds_gen2_link)

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
