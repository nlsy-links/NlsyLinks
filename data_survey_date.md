---
title: "SurveyDate"
---

***
# Description

> Dataset containing survey details for each subject, for each year.

Each row represents a survey that a subject completed (or didn't complete).  
It can be very helpful when restructuring the NLS investigator extracts into a 
longitudinal dataset that's aligned by age (instead of by survey wave).
The Age variables can help to align other response variables across subjects.
While the `SurveySource` indicates where to look for their responses.  

These variables are useful to many types of analyses (not just behavior genetics), and are
provided to save users time.

 
***
# Formats
The dataset is available in the following formats:

 * [CSV](https://github.com/LiveOak/NlsyLinks/blob/master/OutsideData/SurveyTime.csv) is our recommendation.  After navigating to the page, click on the 'View Raw' button to download it.
 * [R Binary](https://github.com/LiveOak/NlsyLinks/blob/master/data/SurveyDate.rda), after navigating to the page, click on the 'View Raw' button to download it.
 * *SAS* (coming soon.)

***
# Data Dictionary

A data frame with 580,752 observations on the following 7 variables. There is one row per subject per year.  

| Variable Name | Type | Variable Description |
| :------------ | :--- | :------------------- |
| SubjectTag | integer | see the variable of the same name in [`Links79Pair`](./data_links_79_pair.html) |
| SurveySource | factor | The location of that subject's survey responses that year.  Values are `NoInterview`, `Gen1`, `Gen2C` or `Gen2YA`. |
| SurveyYear | integer |The year/wave of the survey. |
| SurveyDate | date |The exact date of the administered survey. |
| AgeSelfReportYears | numeric | The subject's age, according to a their own response, or their mother's response. |
| AgeCalculateYears | numeric | The subject's age, calculated from subtracting their birthday from the interview date. |
| Age | numeric | The subject's age, which uses `AgeCalculateYears` or `AgeSelfReportYears` if it's not available. |

***
# Details
The `AgeSelfReportYears` and `AgeCalculateYears` variables usually agree, but not always.  The `Age` variable uses `AgeCalculateYears` (or `AgeSelfReportYears` when `AgeCalculateYears` is missing).

The exact *date* of birth isn't public (only the subject's *month* of birth).  To balance the downward bias of two weeks, their birthday is set to the 15th day of the month to produce *AgeCalculateYears*.  

In the Gen2 Child dataset, self-reported age is stated by month (eg, the child is 38 months old); a constant of 0.5 months has been added to balance the downward bias.  In the Gen2 YA and Gen1 datasets, self-reported age is stated by year (eg, the subject is 52 years old); a constant of 0.5 years has been added.

**Source**: Gen1 information comes from the Summer 2013 release of the [NLSY79 sample](http://www.bls.gov/nls/nlsy79.htm).  Gen2 information comes from the January 2015 release of the [NLSY79 Children and Young Adults sample](http://www.bls.gov/nls/nlsy79ch.htm).  Data were extracted with the [NLS Investigator](https://www.nlsinfo.org/investigator/).

***
# Example in R
```r
library(NlsyLinks) #Load the package into the current R session.

summary(SurveyDate)
table(SurveyDate$SurveyYear, SurveyDate$SurveySource)
table(is.na(SurveyDate$AgeSelfReportYears), is.na(SurveyDate$AgeCalculateYears))

ggplot(dsSourceYear, aes(x=SurveyYear, y=freq, color=SurveySource)) +
  geom_line(size=2) +
  geom_point(size=5, shape=21) +
  scale_color_brewer(palette = "Dark2") +
  theme_bw() +
  theme(legend.position=c(0,0), legend.justification=c(0,0))
  
ggplot(SurveyDate, aes(x=AgeSelfReportYears, y=AgeCalculateYears)) +
  geom_abline() +
  geom_point(shape=21) +
  theme_bw() 
```
