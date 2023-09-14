Version 2.2.1 (2023-09-14)
------------------------------------------------------------------------------
Updates:
* Minor updates to revive package


Version 2.2.0 (2021-07-25)
------------------------------------------------------------------------------
Updates:
* [pkgdown](https://pkgdown.r-lib.org/) documentation
* Incorporate more Nlsy97 info
* Rename dataset `SurveyDate` to `Survey79`.
* In `Survey79`, expose only one age variable to save space to stay under CRAN's size limit.


Version 2.0.5 (2016-03-17)
------------------------------------------------------------------------------
Updates:
* Small updates to meet new testthat version.

Version 2.0.1 (2015-08-16)
------------------------------------------------------------------------------
Updates:
* SurveyDate dataset contains survey details for each subject, for each year.
* Small updates to meet newer CRAN guidelines.

Version 1.4005 (2015-01-15)
------------------------------------------------------------------------------
Updates:
* Small updates to vignettes and documentation.
* Small updates to meet newer CRAN guidelines about title & description format.
* Checked with R Tools 3.2.

Version 1.300 (2013-11-21)
------------------------------------------------------------------------------
New Features:
* A more complete version of the Gen1 links are included.  95% of all Gen1 Housemates have been linked.

Updates:
* `R` now has missing values for Gen1 pairs if the 1979 roster (eg, R00001.51) doesn't indicate they're the same generation.  If this value is desirable for your research, their R values are still available in `RFull`.
* The naming scheme for the `Links79Pair` and `Links79PairExpanded` datasets are more consistent across variables.  For variables that are measured separately for both subjects (eg, Gender), the subjects' variable name will have an `_S1` or `_S2` appended to it.  For instance, the variables `LastSurvey_S1` and `LastSurvey_S2` correspond to the last surveys completed by the pair's first and second subject, respectively.
* Similarly, the functions `CreatePairLinksDoubleEntered` and `CreatePairLinksSingleEntered` now by default append `_S1` and `_S2`, instead of `_1` and `_2`.  However this can be modified using the `subject1Qualifier` and `subject2Qualifier` parameters.
* Added function `ReadCsvNlsy79Gen1()`
* Updated reference manual, ACE vignette, and FAQ.

Version 1.200 (2012-12-18)
------------------------------------------------------------------------------
Updates:
* Renamed `R` to `RFull`.  `RFull` contains all the _R_ values we have.  `R` excludes _R_ values in Gen1Housemates if they're 0, .375, or .75.  The associated relationships (ie, Gen2Cousins and AuntNieces) become null for _R_, but not for _RFull_.

Version 1.017 (2012-11-29)
------------------------------------------------------------------------------
Updates:
* Removed code that assigned all unassigned siblings to .375.  This doesn't make sense for Gen1, and was mostly an internal experiment (and wasn't released on CRAN).

Version 1.015 (2012-11-10)
------------------------------------------------------------------------------
Updates:
* Added outcome variables for Gen1.  Renamed some outcome variables for Gen2.

Version 1.014 (2012-11-09)
------------------------------------------------------------------------------
Updates:
* Based on geocode variables, five Gen1 ambiguous twin was demoted to R=0 (two were R=.5; three were R=NULL).

Version 1.013 (2012-11-08)
------------------------------------------------------------------------------
Updates:
* Rebuilt For R2.15.2 with with RTools216.exe.

Version 1.012 (2012-10-11)
------------------------------------------------------------------------------
Updates:
* Small documentation updates

Version 1.011 (2012-10-11)
------------------------------------------------------------------------------
Updates:
* Gen1 Links are more thorough (but still in a beta state)
* Gen1 and Gen2 information uses the NLSY 2010 survey wave (released this Spring 2012)

Version 1.010 (2012-10-11)
------------------------------------------------------------------------------
* Refreshing after development interrupt to make sure everything builds and tests correctly

Version 1.007 (2012-06-08)
------------------------------------------------------------------------------
Updates:
* Added material to appendices of the NlsyAce vignette.
* Removed 'stringr' package from Depends list.  It's no longer used creating lavaan syntax.

Version 1.004 (2012-06-07)
------------------------------------------------------------------------------
New Features:
* Added ParentChild links.
* Added Gen1 links (using only Explicit items).  There will be much more work to these relationship in the next few months.
* Added Gen2Cousins & AuntNieces.  These will change as the Gen1 links are filled out with implicit information.

Version 1.003 (2012-05-21)
------------------------------------------------------------------------------
Updates:
* Additional Documentation.

Version 1.001 (2012-05-04)
------------------------------------------------------------------------------
Updates:
* Started a FAQ (as a vignette).

Version 1.0 (2012-04-27)
------------------------------------------------------------------------------
Updates:
* Additional documentation and unit tests.
* Changed R-Forge development status from "Beta" to "Production/Stable"

Version 0.29 (2012-04-22)
------------------------------------------------------------------------------
Updates:
* Modified some function signatures to be make package more consistent.
* Additional lavaan example in ACE vignette.

Version 0.26 (2012-04-20)
------------------------------------------------------------------------------
New Features:
* The new function 'AceLavaanGroup' uses the 'lavaan' package to estimate a multigroup SEM ACE model.

Version 0.24 (2012-04-16)
------------------------------------------------------------------------------
New Features:
* The S4 class 'AceEstimate' is returned by the 'Ace' function.
* Methods & functions associated with the AceEstimate class.
* SubjectDetails79 dataset for Gen2.
* ReadCsvNlsy79 function.
* Validation functions: (a) OutcomeDataset
* Column Utilities: (a) VerifyColumnExists, (c) RenameNlsyColumn

Version 0.19 (2012-03-10)
------------------------------------------------------------------------------
New Features:
* NLS Investigator vignette
* ACE vignette
* Generalized AceUnivariate function that wraps DeFriesFulkerMethod1 and DeFriesFulkerMethod3.
* ExtraOutcomes79 dataset
* Links79PairExpanded dataset
* Validation functions: (a) OutcomeDataset, (b) PairLinks, (c) PairLinksAreSymmetric
* Create functions for (a) SpatialNeighbours, (b) PairLinks, (c) SubjectTag

Version 0.10 (2012-01-16)
------------------------------------------------------------------------------
* Initial submission to CRAN
* Contains Nlsy79 Gen2 sibling links

# GitHub Commits and Releases
* For a detailed change log, please see https://github.com/nlsy-links/NlsyLinks/commits/master.
* For a list of the major releases, please see https://github.com/nlsy-links/NlsyLinks/releases.
