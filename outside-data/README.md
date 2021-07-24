## Dataset Sources

The following files come from the [NlsyLinksDetermination](https://github.com/nlsy-links/nlsy-links-determination-2017) code written in C#.  Developers looking only at this package won't have access to this code.  This documentation is intended to make our research more reproducible.

###  CSVs in `/data/`
 * **outside-data/links-2011-vxx.csv**: This linking file is primary output of the grant.  It has one row per pair (pairs are "single-entered" and show up only once).  It can be refreshed by running [AssembleRelatedValues.R](https://github.com/nlsy-links/nlsy-links-determination-2017blob/master/ForDistribution/Links/AssembleRelatedValues.R).
 
 * **outside-data/subject-details-vxx.csv**: This dataset has one row per subject, and it primarily contains plumbing variables (ie, variables that help assemble larger datasets, like number of siblings and the year of their last completed survey).  It can be refreshed by running [AssembleSubjectDetails.R](https://github.com/nlsy-links/nlsy-links-determination-2017blob/master/ForDistribution/SubjectDetails/AssembleSubjectDetails.R).
 
 * **outside-data/extra-outcomes-79.csv**: This dataset has one row per subject, and contains primarily outcome measures, intended to be used in examples and demonstrations.  It can be refreshed by running [OutcomesAssembly.R](https://github.com/nlsy-links/nlsy-links-determination-2017blob/master/ForDistribution/Outcomes/OutcomesAssembly.R).

 * **outside-data/survey-time.csv**: This dataset has one row per subject per year.  This very general dataset can be useful to any BG or non-BG project.  It can be refreshed by running [SurveyTimeAssembly.R](https://github.com/nlsy-links/nlsy-links-determination-2017blob/master/ForDistribution/SurveyTime/SurveyTimeAssembly.R).
 
    If the subject did not answer a year's survey the `ExtractSource` variable will be `0`.  

### CSVs in `/inst/extdata/`
 * **gen1-life-course.csv**: This dataset comes straight from the [NLSY Investigator](https://www.nlsinfo.org/investigator/).  The tagset, which defines the variables to extract, can be downloaded from the repository file, [Gen1Documentation_LifeCourse.NLSY79](https://github.com/nlsy-links/nlsy-links-determination-2017blob/master/Extracts/Tagsets/Gen1Documentation_LifeCourse.NLSY79).
 
 * **gen2-birth.csv**: This dataset comes straight from the [NLSY Investigator](https://www.nlsinfo.org/investigator/).  The tagset, which defines the variables to extract, can be downloaded from the repository file, [Gen2Documentation_Birth.CHILDYA](https://github.com/nlsy-links/nlsy-links-determination-2017blob/master/Extracts/Tagsets/Gen2Documentation_Birth.CHILDYA).
