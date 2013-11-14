## Dataset Sources

The following files come from the [NlsyLinksDetermination](https://github.com/LiveOak/NlsyLinksDetermination) code written in C#.  Developers looking only at this package won't have access to this code.  This documentation is intended to make our research more reproducible.

###  CSVs in `/data/`
 * **OutsideData/Links2011Vxx.csv**: This linking file is primary output of the grant.  It has one rowIt can be refreshed by running [AssembleRelatedValues.R](https://github.com/LiveOak/NlsyLinksDetermination/blob/master/ForDistribution/Links/AssembleRelatedValues.R).
 
 * **OutsideData/SubjectDetails79Vxx.csv**: This dataset has one row per subject, and it primarily contains plumbing variables (ie, variables that help assemble larger datasets, like number of siblings and the year of their last completed survey).  It can be refreshed by running [AssembleSubjectDetails.R](https://github.com/LiveOak/NlsyLinksDetermination/blob/master/ForDistribution/SubjectDetails/AssembleSubjectDetails.R).
 
 * **OutsideData/ExtraOutcomes79.csv**: This dataset has one row per subject, and contains primarily outcome measures, intended to be used in examples and demonstrations.  It can be refreshed by running [OutcomesAssembly.R](https://github.com/LiveOak/NlsyLinksDetermination/blob/master/ForDistribution/Outcomes/OutcomesAssembly.R).

### CSVs in `/inst/extdata/`
 * **Gen1LifeCourse.csv**: This dataset comes straight from the [NLSY Investigator](https://www.nlsinfo.org/investigator/).  The tagset, which defines the variables to extract, can be downloaded from the repository file, [Gen1Documentation_LifeCourse.NLSY79](https://github.com/LiveOak/NlsyLinksDetermination/blob/master/Extracts/Tagsets/Gen1Documentation_LifeCourse.NLSY79).
 
 * **Gen1LifeCourse.csv**: This dataset comes straight from the [NLSY Investigator](https://www.nlsinfo.org/investigator/).  The tagset, which defines the variables to extract, can be downloaded from the repository file, [Gen2Documentation_Birth.CHILDYA](https://github.com/LiveOak/NlsyLinksDetermination/blob/master/Extracts/Tagsets/Gen2Documentation_Birth.CHILDYA).
 