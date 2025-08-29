# Version 2.2.3

**Released:** 2025-08-29

## Updates

- Rebuilding vignettes to be compatible with packagedown.
- Minor copyediting and efficiency updates.
- Added more roxygen2 tags to functions.

# Version 2.2.2

**Released:** 2024-10-07

## Updates

- Refreshing tests to meet new CRAN guidelines.

# Version 2.2.1

**Revived:** 2023-09-14

## Updates

- Minor updates to revive package.

# Version 2.2.0

**Released:** 2021-07-25


## New Features
- [pkgdown](https://pkgdown.r-lib.org/) documentation.

## Updates
- Incorporate more Nlsy97 info.
- Rename dataset `SurveyDate` to `Survey79`.
- In `Survey79`, expose only one age variable to save space to stay under CRAN's size limit.

# Version 2.0.5

**Released:** 2016-03-17

## Updates

- Small updates to meet new `testthat` version.

# Version 2.0.1

**Released:** 2015-08-16

## Updates

- `SurveyDate` dataset contains survey details for each subject, for each year.
- Small updates to meet newer CRAN guidelines.

# Version 1.4005

**Released:** 2015-01-15

## Updates

- Small updates to vignettes and documentation. 
- Small updates to meet newer CRAN guidelines about title & description format.
- Checked with R Tools 3.2.

# Version 1.300

**Released:** 2013-11-21

## New Features

- A more complete version of the Gen1 links are included.  95% of all Gen1 Housemates have been linked.
- Added function `ReadCsvNlsy79Gen1()`.

## Updates

- `R` now has missing values for Gen1 pairs if the 1979 roster (e.g., `R00001.51`) doesn't indicate they're the same generation.
- The naming scheme for the `Links79Pair` and `Links79PairExpanded` datasets is more consistent across variables.  For variables that are measured separately for both subjects (eg, Gender), the subjects' variable name will have an `_S1` or `_S2` appended to it. For instance, the variables `LastSurvey_S1` and `LastSurvey_S2` correspond to the last surveys completed by the pair's first and second subject, respectively.
- The functions `CreatePairLinksDoubleEntered` and `CreatePairLinksSingleEntered` now append `_S1` and `_S2` instead of `_1` and `_2`, by default. However this can be modified using the `subject1Qualifier` and `subject2Qualifier` parameters.
- Updated reference manual, ACE vignette, and FAQ.


# Version 1.200

**Released:** 2012-12-18

## Updates

- Renamed `R` to `RFull`.
- `RFull` contains all the _R_ values we have. `R` excludes _R_ values in `Gen1Housemates` if they're 0, .375, or .75.

# Version 1.017

**Released:** 2012-11-29

## Updates

- Removed code that assigned all unassigned siblings to .375.

# Version 1.015

**Released:** 2012-11-10

## Updates

- Added outcome variables for Gen1.
- Renamed some outcome variables for Gen2.

# Version 1.014

**Released:** 2012-11-09

## Updates

- Based on geocode variables, five Gen1 ambiguous twins were demoted to `R=0`.

# Version 1.013

**Released:** 2012-11-08

## Updates

- Rebuilt for R 2.15.2 with `RTools216.exe`.

# Version 1.012

**Released:** 2012-10-11

## Updates

- Small documentation updates.

# Version 1.011

**Released:** 2012-10-11

## Updates

- Gen1 links are more thorough (still in a beta state).
- Gen1 and Gen2 information uses the NLSY 2010 survey wave.

# Version 1.010

**Released:** 2012-10-11

## Updates

- Refreshing after development interrupt to ensure everything builds and tests correctly.

# Version 1.007

**Released:** 2012-06-08

## Updates

- Added material to appendices of the `NlsyAce` vignette.
- Removed `stringr` package from `Depends` list.

# Version 1.004

**Released:** 2012-06-07

## New Features

- Added `ParentChild` links.
- Added Gen1 links using only explicit items.
- Added `Gen2Cousins` & `AuntNieces`.

# Version 1.003

**Released:** 2012-05-21

## Updates

- Additional documentation.

# Version 1.001

**Released:** 2012-05-04

## New Features

- Started an FAQ (as a vignette).

# Version 1.0

**Released:** 2012-04-27

## Updates

- Additional documentation and unit tests.
- Changed R-Forge development status from "Beta" to "Production/Stable."

# Version 0.29

**Released:** 2012-04-22

## Updates

- Modified some function signatures to make the package more consistent.
- Additional `lavaan` example in ACE vignette.

# Version 0.26

**Released:** 2012-04-20

## New Features

- Added function `AceLavaanGroup` for estimating a multigroup SEM ACE model.

# Version 0.24

**Released:** 2012-04-16

## New Features

- Introduced S4 class `AceEstimate` returned by the `Ace` function.
- Methods and functions associated with the `AceEstimate` class.
- Added `SubjectDetails79` dataset for Gen2.
- Introduced `ReadCsvNlsy79` function.
- Added validation functions: `OutcomeDataset`.
- Column utilities: `VerifyColumnExists`, `RenameNlsyColumn`.

# Version 0.19

**Released:** 2012-03-10

## New Features

- `NLS Investigator` vignette.
- `ACE` vignette.
- `AceUnivariate` function wrapping `DeFriesFulkerMethod1` and `DeFriesFulkerMethod3`.
- `ExtraOutcomes79` dataset.
- `Links79PairExpanded` dataset.
- Validation functions: `OutcomeDataset`, `PairLinks`, `PairLinksAreSymmetric`.
- Creation functions: `SpatialNeighbours`, `PairLinks`, `SubjectTag`.

# Version 0.10

**Released:** 2012-01-16

## New Features

- Initial submission to CRAN.
- Contains `Nlsy79` Gen2 sibling links.

---

## GitHub Commits and Releases

- For a detailed change log, see [GitHub Commits](https://github.com/nlsy-links/NlsyLinks/commits/master).
- For a list of major releases, see [GitHub Releases](https://github.com/nlsy-links/NlsyLinks/releases).
- For the latest release, see the [CRAN page](https://cran.r-project.org/package=NlsyLinks).
