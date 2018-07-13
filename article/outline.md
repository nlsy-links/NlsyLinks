Proposed Structure for manuscript (possibly submitted to JSS)

# NlsyLinks

----------------------------------------------------

# Authors & Affiliation
* William Howard Beasley (Howard Live Oak LLC, Norman)
* Michael D. Hunter (University of Oklahoma Health Sciences Center, OKC)
* David Bard (University of Oklahoma Health Sciences Center, OKC)
* Kelly Meredith (Oklahoma City University, OKC)
* S. Mason Garrison (Vanderbilt University, Nashville)
* Joseph Lee Rodgers (Vanderbilt University, Nashville)

----------------------------------------------------

# Abstract

----------------------------------------------------

# Introduction

* NLSY Structure
* Benefits of Accounting for Kinships  
    * BG
    * D'Onofrio-type research
* Terminology


### Structural and Topical information
The NlsyLinks package contains multiple datasets, which are classified in two types of information: topical and structural.  The *topical information* refers to the  predictor and outcome variables conventionally used to test a focused hypotheses.  For instance, the NLSY79 Gen2 variables Rqqq.qq and Rqqq.qq are critical when studying the relationship between conduct disorder and fertility (eg, Rodgers et al, 2013?), but are not relevant to many hypotheses outside this area.

In contrast, the *structural information* is not typically directly stated in the hypotheses, yet is essential to many types of NLSY-related investigations by helping augment or structure the:
* familial relationships (*e.g.*, Subjects 301 and 302 are half-brothers; Subjects 506 and 507 are second-cousins siblings),
* subject characteristics (*e.g.*, Subject 301 is a Native American female), or
* subject-survey characteristics (*e.g.*, Subject 301 was 15 for the 1981 Survey; Subject 301 did not respond to the 1990 survey)

The NlsyLink includes small topical datasets primarily for convenience so that examples and vignettes are more realistic.  The structural datasets are intended to be the authoritative representations, and are the direct product of two recent multi-year NIH grants (for a complete history, see Rodgers et al, 2017).

----------------------------------------------------

# Retrieving Data with the NLS Investigator
* This will use much of the existing `NlsyInvestigator` vignette.


----------------------------------------------------

# ACE DF Analysis of One Generation
* This very basic analysis that should provide an initial feel for the inputs, mechanics, and goals of the analysis.

----------------------------------------------------

# ACE SEM of Two Generations
* This is a more moderately difficult analysis with a more common estimation mechanism.
* Benefits of cross-generational analysis

----------------------------------------------------

# More Advanced ACE Analyses
*When the analysis grows beyond a single outcome at one time point, researchers are better off using the modeling software itself (eg, lavaan, Mplus) than then wrappers provided by `NlsyLinks`, or any other package.

----------------------------------------------------

# Data Manipulation and Non-Biometric Analyses
* Even if the investigation doesn't involve family structure, `NlsyLinks` functions and dataset can make the research can be more efficient.

----------------------------------------------------

# SAS Analogues
* The `NlsyLinks` datasets can be used in any statistical package, and we demonstrate that here with SAS.

----------------------------------------------------

# Additional Resources

----------------------------------------------------

# References
