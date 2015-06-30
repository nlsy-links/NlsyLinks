---
title: "SubjectDetails79"
---

***
# Description

> Dataset containing further details of the Gen1 and Gen2 subjects.

These variables are useful to many types of analyses (not just behavior genetics), and are provided to save users time.

***
# Formats
The dataset is available in the following formats:

 * [CSV](https://raw.githubusercontent.com/LiveOak/NlsyLinks/master/OutsideData/SubjectDetailsV85.csv) is our recommendation.
 * [R Binary](https://github.com/LiveOak/NlsyLinks/blob/master/data/SubjectDetails79.rda), after navigating to the page, click on the 'View Raw' button to download it.
 * *SAS* (coming soon.)

***
# Data Dictionary

A data frame with 24,181 observations on the following 12 variables.  

| Variable Name | Type | Variable Description |
| :------------ | :--- | :------------------- |
| SubjectTag | integer | see the variable of the same name in [Links79Pair](./data_subject_details_79.html) |
| ExtendedID | integer | see the variable of the same name in [Links79Pair](./data_subject_details_79.html) |
| Generation | integer | Indicates if the subject is in generation `1` or `2`. | 
| Gender | integer | Indicates if the subject is `Male`=1 or `Female`=2. |
| RaceCohort | integer | Indicates if the race cohort is `Hispanic`=1, `Black`=2, or `Nbnh`=3 (*ie*, Non-black, non-hispanic).  This comes from the Gen1 variable `R02147.00` and Gen2 variable `C00053.00`. |
| SiblingCountInNls | integer | The number of the subject's siblings, including himself/herself (a singleton has a value of one).  This considers only the siblings in the NLSY.  For Gen1, this can exclude anyone outside the age range.  For Gen2, this excludes anyone who doesn't share the same mother. |
| BirthOrderInNls | integer | Indicates the subject's birth order among the NLSY siblings. | 
| SimilarAgeCount | integer | The number of children who were born within roughly 30 days of the subject's birthday, including the subject (for instance, even an only child will have a value of 1).  For Gen2 subjects, this should reflect how many children the Gen1 mother gave birth to at the same time (1: singleton; 2: twins, 3: triplets).  For Gen1 subjects, this is less certain, because the individual might have been living with a similarly-aged housemate, born to a different mother. |
| HasMzPossibly | integer | Indicates if the subject *might* be a member of an MZ twin/triplet. This will be true if there is a sibling with a DOB within a month, and they are the same gender. |
| IsMz | boolean | Indicates if the subject has been identified as a member of an MZ twin/triplet. |
| KidCountBio | integer | The number of biological children known to the NLSY (but not necessarily interviewed by the NLSY. |
| KidCountInNls | integer | The number of children who belong to the NLSY. This is nonnull for only Gen1 subjects. |
| Mob | date | The subject's month of birth, as [YYYY-MM-DD](http://xkcd.com/1179/).  The exact day is not available to the public.  By default, we set their birthday to the 15th day of the month. |
| LastSurveyYearCompleted | integer | The year of the most recently completed survey. |
| AgeAtLastSurvey | integer | The subject's age at the most recently completed survey. |
| IsDead | boolean | *This variable is not available yet* Indicates if the subject was alive for the last attempted survey. |
| DeathDate | date | *This variable is not available yet* The subject's month of death, as YYYY-MM-DD.  The exact day is not available to the public. By default, we set their birthday to the 15th day of the month. |

***
# Details
Gen1 information comes from the Summer 2013 release of the [NLSY79](http://www.bls.gov/nls/nlsy79.htm).  Gen2 information comes from the Summer 2013 release of the [NLSY79 Children and Young Adults sample](http://www.bls.gov/nls/nlsy79ch.htm).  Data were extracted with the [NLS Investigator](https://www.nlsinfo.org/investigator).

***
# Example in R
```r
library(NlsyLinks) #Load the package into the current R session. #Update with `devtools::install_github("LiveOak/NlsyLinks")`

summary(SubjectDetails79)

oldPar <- par(mfrow=c(3,2), mar=c(2,2,1,.5), tcl=0, mgp=c(1,0,0))
hist(SubjectDetails79$SiblingCountInNls, main="",
     breaks=seq(from=0, to=max(SubjectDetails79$SiblingCountInNls, na.rm=TRUE), by=1)
)
hist(SubjectDetails79$BirthOrderInNls, main="",
     breaks=seq(from=0, to=max(SubjectDetails79$BirthOrderInNls, na.rm=TRUE), by=1)
)
hist(SubjectDetails79$SimilarAgeCount, main="",
     breaks=seq(from=0, to=max(SubjectDetails79$SimilarAgeCount, na.rm=TRUE), by=1)
)
hist(SubjectDetails79$KidCountBio, main="",
     breaks=seq(from=0, to=max(SubjectDetails79$KidCountBio, na.rm=TRUE), by=1)
)
hist(SubjectDetails79$KidCountInNls, main="",
     breaks=seq(from=0, to=max(SubjectDetails79$KidCountInNls, na.rm=TRUE), by=1)
)
par(oldPar)
```
