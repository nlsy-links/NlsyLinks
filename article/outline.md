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
In addition to functions, the NlsyLinks package contains two types of information: topical and structural.  The *topical information* refers to the  predictor and outcome variables conventionally used to test a focused hypotheses.  For instance, the NLSY79 Gen2 variables Rqqq.qq and Rqqq.qq are critical when studying the relationship between conduct disorder and fertility (eg, Rodgers et al, 2013?), but are not relevant to many hypotheses outside this area.

In contrast, the *structural information* is not typically directly stated in the hypotheses, yet is essential to many types of NLSY-related investigations including:
* familial relationships (*e.g.*, Subjects 301 and 302 are half-brothers; Subjects 506 and 507 are second-cousins siblings),
* subject characteristics (*e.g.*, Subject 301 is a Native American female; Subject 607 died from heart disease in 2005; Subject 802 is part of the military over-sample), and
* subject-survey characteristics (*e.g.*, Subject 301 was 15 years old for the 1981 Survey; Subject 301 did not respond to the 1990 survey; Subject 702 completed the NLSY-C survey in 1996mi
   and the NLSY-YA survey in 1998).

The NlsyLinks includes small topical datasets which allows the that vignettes and examples to be reproducible and more realistic.  The structural datasets are intended to be the authoritative representations, and are the product of two NIH grants (for a complete history of the familial relationships, see Rodgers et al., 2017).

### Terminology

Because NlsyLinks package structures information within and between generations of the NLSY simultaneously, it uses slightly unconventional NLSY terminology to reduce ambiguity.  The package pertains to multiple generations of the 'Nlsy 79' and multiple generations of the 'Nlsy 97'.

The 'Nlsy79' refers to both the original subjects interviewed in 1979, and their children (termed 'Nlsy79 Gen1' and 'Nlsy79 Gen2', respectively).  Data for the 'Nlsy79 Gen1' comes from the [original NLSY79 sample](http://www.bls.gov/nls/nlsy79.htm), while data for the 'Nlsy Gen2' comes from both the [NLSY-C sample]() and the [NLSY-YA sample]() ('C' stands for children, and 'YA' stands for young adult).  More specifically, the [Gen2 subjects](http://www.bls.gov/nls/nlsy79ch.htm) are the biological offspring of the Gen1 mothers; they initially complete the NLSY-C survey until roughly age 14, and  then complete the NLSY-YA survey for the next 3+ decades.  Although NLSY does not focus on the parents of Gen1 or the children of Gen2, it does contain direct and indirect information about them, and we refer to them as 'Nlsy79 Gen0' and 'Nlsy79 Gen3'.

The terminology for the 'Nlsy97' is similar to the 'Nlsy79', yet simpler because their offspring are not explicit respondents.  They both are nationally-representative samples, yet only the explicit

This package considers both generations of the NLSY79.  The first generation (\emph{ie}, `Gen1') refers to subjects in the original NLSY79 sample (\url{http://www.bls.gov/nls/nlsy79.htm}).  The second generation (\emph{ie}, `Gen2') of subjects are the biological offspring of the original females -\emph{i.e.}, those in the NLSY79 Children and Young Adults sample ( \url{http://www.bls.gov/nls/nlsy79ch.htm}).  The NLSY97 is a third dataset that can be used for behavior genetic research (\url{http://www.bls.gov/nls/nlsy97.htm}), although this vignette focuses on the two generations in the NLSY79.

Standard terminology is to refer second generation subjects as `children' when they are younger than age 15 (NSLYC), and as `young adults' when they are 15 and older (NLSY79-YA); though they are the same respondents, different funding mechanisms and different survey items necessitate the distinction.  This cohort is sometimes abbreviated as `NLSY79-C', `NLSY79C', `NLSY-C' or `NLSYC'. This packages uses `Gen2' to refer to subjects of this generation, regardless of their age at the time of the survey.


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
* 
Downloadable from qqq.-qqqq

----------------------------------------------------

# Additional Resources

----------------------------------------------------

# References
<!--stackedit_data:
eyJoaXN0b3J5IjpbODE4MTU5NTYwLC01OTQ1MjY3NDksLTE4Nj
A4NTgwNjJdfQ==
-->