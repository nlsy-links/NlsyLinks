---
title: "Links97Pair"
---

***
# Description

> Kinship linking file for pairs of relatives in the NLSY97

This dataset specifies the relatedness coefficient `R` between subjects in the same extended family.  Each row represents a unique relationship pair.

***
# Formats
The dataset is available in the following formats:

* [CSV](https://github.com/LiveOak/NlsyLinks/blob/master/outside-data/nlsy-97/links-2017-97.csv?raw=true) (our recommendation).
* [R Binary](https://github.com/LiveOak/NlsyLinks/raw/master/data/Links97PairExpanded.rda).
* SAS -to be released.

# Data Dictionary
The dataset indicates a county's characteristics, with the following fields:

| Variable Name | Type | Variable Description |
| :------------ | :--- | :------------------- |
| ExtendedID | integer | Identity of the extended family of the pair; it corresponds to the [`[SIDCODE]`](https://www.nlsinfo.org/investigator/pages/search.jsp#R11930.00). See Details below. |
| SubjectTag_S1 | integer | Identity of the pair's first subject.  See Details below. |
| SubjectTag_S2 | integer | Identity of the pair's second subject.  See Details below. |
| RelationshipPath | integer | Specifies the relationship category of the pair.  This variable is a factor, with level `Housemates`=1. |
| R | float | The pair's Relatedness coefficient.  See Details below. |
| RFull | float | This is a superset of `R`.  This includes all the *R* values we estimated, while *R* (i.e., the variable above) excludes values like *R*=0 for `Gen1Housemates`, and the associated relationships based on this *R* value (i.e., `Gen2Cousin`s and `AuntNiece`s).
| EverSharedHouse | logical | Indicate if the pair likely live in the same house.  This is `TRUE` for all pairs in this NLSY97 dataset. |
| IsMz | integer | Indicates if the pair is from the same zygote (ie, they are identical twins/triplets). This variable is a factor, with levels `No`=0, `Yes`=1, `DoNotKnow`=255. |
| LastSurvey_S1 | integer | The year of Subject1's most recently completed survey. This may be different that the survey's administration date. |
| LastSurvey_S2 | integer | The year of Subject2's most recently completed survey. This may be different that the survey's administration date. |
| RPass1 | float | The pair's estimated *R* coefficient, using both implicit and explicit information.  Interpolation was NOT used.  The variable `R` is identically constructed, but it did use interpolation. |
| SubjectID_S1 | integer | The ID value assigned by NLS to the first subject, see [`[PUBID]`](https://www.nlsinfo.org/investigator/pages/search.jsp#R00001.00). |
| SubjectID_S2 | integer | The ID value assigned by NLS to the second subject, see [`[PUBID]`](https://www.nlsinfo.org/investigator/pages/search.jsp#R00001.00). |


***
# Details

The variable `ExtendedID` corresponds to the NLSY97 variable `[SIDCODE]`
(*e.g.*, [R11930.00](https://www.nlsinfo.org/investigator/pages/search.jsp#R11930.00)),
which uniquely identifies a *household* that may contain multiple NLSY97 subjects.

The variables `SubjectTag_S1` and `SubjectTag_S2` uniquely identify
subjects.  It corresponds to the NLSY97 variable `[PUBID]`,
(*e.g.*, [R00001.00](https://www.nlsinfo.org/investigator/pages/search.jsp#R00001.00)).

The `RelationshipPath` variable is not useful with this dataset,
but is included to be consistent with the [Links97Pair] dataset.

MZ twins have *R*=1.  DZ twins and full-siblings have *R*=.5.
Half-siblings have *R*=.25. Typical first cousins have *R*=.125.
Unrelated subjects have *R*=0 (this occasionally happens for
`Housemates`, but never for the other paths).
Other *R* coefficients are possible.

There are several other uncommon possibilities, such as half-cousins (*R*=.0625) and
ambiguous aunt-nieces (*R*=.125, which is an average of 1/4 and 0/4).
The variable coding for genetic relatedness,`R`, in [`Links79Pair`] contains
only the common values of *R* whose groups are likely to have stable estimates.
However the variable `RFull` in [`Links79PairExpanded`] contains all *R* values.
We strongly recommend using `R` in this [base::data.frame].  Move to
`RFull` (or some combination) only if you have a good reason, and are willing
to carefully monitor a variety of validity checks.  Some of these
excluded groups are too small to be estimated reliably.

***
# See Also
The `LinksPair97` dataset contains columns necessary for a
basic BG analysis.  The [Links97PairExpanded] dataset contains
further information that might be useful in more complicated BG analyses.

A tutorial that produces a similar dataset is
http://www.nlsinfo.org/childya/nlsdocs/tutorials/linking_mothers_and_children/linking_mothers_and_children_tutorial.html.
It provides examples in SAS, SPSS, and STATA.

The current dataset (ie, `Links97Pair`) can be saved as a CSV file
(comma-separated file) and imported into in other programs and languages.
In the R console, type the following two lines of code:

```r
library(NlsyLinks)
write.csv(Links97Pair, "C:/BGDirectory/Links97Pair.csv")
```

where `"C:/BGDirectory/"` is replaced by your preferred directory.
Remember to use forward slashes instead of backslashes; for instance, the
path `"C:\BGDirectory\Links97Pair.csv"` can be misinterpreted.

***
# References

For more information on *R* (*ie*, the Relatedness coefficient), please see

Rodgers, Joseph Lee, & Kohler, Hans-Peter (2005).
[Reformulating and simplifying the DF analysis model.](http://www.springerlink.com/content/n3x1v1q282583366/)
*Behavior Genetics, 35* (2), 211-217.

***
# Source
Information comes from the Summer 2018 release of the
[NLSY97 sample](https://www.bls.gov/nls/nlsy97.htm).
Data were extracted with the NLS Investigator
(https://www.nlsinfo.org/investigator/).


***
# Examples

```r
library(NlsyLinks)     # Load the package into the current R session.
summary(Links97Pair)   # Summarize the five variables.
hist(Links97Pair$R)    # Display a histogram of the Relatedness coefficients.
table(Links97Pair$R)   # Create a table of the Relatedness coefficients for the whole sample.

#Create a dataset of only monozygotic sibs.
mz_sibs <- subset(Links97Pair, R > .9)
summary(mz_sibs)       # Create a table MZ sibs.
```
