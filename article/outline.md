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

The NlsyLinks package offers two types of datasets: topical and structural.  *Topical datasets* contain  predictor and outcome variables typically used to test a focused hypotheses.  For instance, the NLSY79 Gen2 variables Rqqq.qq and Rqqq.qq are critical when studying the relationship between conduct disorder and fertility (eg, Rodgers et al, 2013?), but are not relevant to many hypotheses outside this area.

In contrast, variables in *structural datasets* are not typically directly stated in the hypotheses, yet are essential to many NLSY-related investigations including:
* familial relationships (*e.g.*, Subjects 301 and 302 are half-brothers; Subjects 506 and 507 are second-cousins siblings),
* subject characteristics (*e.g.*, Subject 301 is a Native American female; Subject 607 died from heart disease in 2005; Subject 802 is part of the military over-sample), and
* subject-survey characteristics (*e.g.*, Subject 301 was 15 years old for the 1981 Survey; Subject 301 did not respond to the 1990 survey; Subject 702 completed the NLSY-C survey in 1996 and the NLSY-YA survey in 1998).

The NlsyLinks includes small topical datasets which allows the vignettes and examples to be reproducible and more realistic.  The structural datasets are intended to be the authoritative representations, and are the product of two NIH grants (for a complete history of the familial relationships, see Rodgers et al., 2017).

### Terminology

The package pertains to multiple generations of the 'Nlsy79' and multiple generations of the 'Nlsy97'.  Because NlsyLinks package structures information within and between generations of the NLSY simultaneously, it requires slightly unconventional NLSY terminology to reduce ambiguity.  

The 'Nlsy79 sample' refers to both the original 12,686 subjects interviewed in 1979, and their 11k children (termed 'Nlsy79 Gen1' and 'Nlsy79 Gen2', respectively).  Data for the 'Nlsy79 Gen1' comes from the [original NLSY79 stydy](http://www.bls.gov/nls/nlsy79.htm), while data for the 'Nlsy Gen2' comes from both the [NLSY-C study]() and the [NLSY-YA study]() ('C' stands for children, and 'YA' stands for young adult).  More specifically, the [Gen2 subjects](http://www.bls.gov/nls/nlsy79ch.htm) are the biological offspring of the Gen1 mothers; they initially completed the NLSY-C survey until roughly age 14, and then completed the NLSY-YA survey (the oldest 'Young Adult' respondent was QQ in the 2016 survey).  Although the NLSY does not interview 'Nlsy79 Gen0' (the parents of Gen1) or 'Nlsy79 Gen3' (the children of Gen2), it does contain direct and indirect information about them,

The terminology for the 'Nlsy97' sample is similar yet simpler than the 'Nlsy79',  because the explicit respondents come from a single generation (*i.e.*, the 'Nlsy97 Gen1').  A few variables reflect Gen0 and Gen2.  In contrast to the Nlsy79, the Nlsy97 contains more information about the housemates.

They both are nationally-representative samples, 

Standard terminology is to refer second generation subjects as `children' when they are younger than age 15 (NSLYC), and as `young adults' when they are 15 and older (NLSY79-YA); though they are the same respondents, different funding mechanisms and different survey items necessitate the distinction.  This cohort is sometimes abbreviated as `NLSY79-C', `NLSY79C', `NLSY-C' or `NLSYC'. This packages uses `Gen2' to refer to subjects of this generation, regardless of their age at the time of the survey.

* Ambiguous Siblings
* Ambiguous Twins
----------------------------------------------------

# Retrieving Data with the NLS Investigator
* This will use much of the existing `NlsyInvestigator` vignette.

Once a researcher has has a research idea, we suggest to then explore what the NLSY study can offer by poking around the (a) vast online documentation and (b) NLS Investigator.  The documentation online (www.qqq), and has general information (*e.g.*, how to connect the nationally representative sample was collected), topical information (*e.g.*, what medical and health information has been collected across survey waves and subject ages), and descriptive summaries (*e.g.*, attrition over time for different race and ethnic groups).  This material has helpful suggestions which variables are available and appropriate.

With these hints, it's time to turn to select and download the specific variables from the NLS Investigator.  The NLS Investigator is described briefly here (see the [NLS Investigator](https://github.com/LiveOak/NlsyLinks/blob/master/inst/doc/NlsInvestigator.pdf) vignette for more detailed instruction).  Unless you need only a handful of variables, researches new to the NLSY should expect round trips as they iteratively improve and complete their variable set.  First select the 'Study'


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
eyJoaXN0b3J5IjpbMTE3Njc1Mzg4MywtNjM3MDE2MDAzLDgxOD
E1OTU2MF19
-->