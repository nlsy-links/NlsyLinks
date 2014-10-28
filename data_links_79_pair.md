---
title: "Links79Pair"
---

***
# Description

> Kinship linking file for pairs of relatives in the NLSY79 and NLSY79 Children and Young Adults.  

This dataset specifies the relatedness coefficient `R` between subjects in the same extended family.  Each row represents a unique relationship pair.


***
# Formats
The dataset is available in the following formats:

 * [CSV](https://raw.githubusercontent.com/LiveOak/NlsyLinks/master/NlsyLinks/OutsideData/Links2011VLatest.csv) is our recommendation.
 * [R Binary](https://github.com/LiveOak/NlsyLinks/blob/master/NlsyLinks/data/Links79Pair.rda), after navigating to the page, click on the 'View Raw' button to download it.
 * *SAS* (coming soon.)
 * *SPSS* (coming soon.)

***
# Data Dictionary
The dataset indicates a county's characteristics, with the following fields:

| Variable Name | Type | Variable Description |
| :------------ | :--- | :------------------- |
| ExtendedID | integer | Identity of the extended family of the pair; it corresponds to the HHID in the NLSY79.  See References below. |
| SubjectTag_S1 | integer | Identity of the pair's first subject.  See Details below. |
| SubjectTag_S2 | integer | Identity of the pair's second subject.  See Details below. |
| R | float | The pair's Relatedness coefficient.  See Details below. |
| RelationshipPath | integer | Specifies the relationship category of the pair.  This variable is a factor, with levels `Gen1Housemates`=1, `Gen2Siblings`=2, `Gen2Cousins`=3, `ParentChild`=4, `AuntNiece`=5. |

***
# Details
The dataset contains Gen1 and Gen2 subjects.  "Gen1" refers to subjects in
the original [NLSY79 sample](http://www.bls.gov/nls/nlsy79.htm).
"Gen2" subjects are the biological children of the Gen1 females -ie, those
in the [NLSY79 Children and Young Adults](http://www.bls.gov/nls/nlsy79ch.htm) sample.

Subjects will be in the same extended family if either: [1] they are Gen1
housemates, [2] they are Gen2 siblings, [3] they are Gen2 cousins (ie, they
have mothers who are Gen1 sisters in the NLSY79, [4] they are mother and
child (in Gen1 and Gen2, respectively), or [5] they are aunt|uncle and
niece|nephew (in Gen1 and Gen2, respectively).

The variables `SubjectTag_S1` and `SubjectTag_S2` uniquely identify
subjects.  For Gen2 subjects, the SubjectTag is identical to their CID (ie,
C00001.00 -the SubjectID assigned in the NLSY79-Children files).  However
for Gen1 subjects, the SubjectTag is their CaseID (ie, R00001.00), with
"00" appended.  This manipulation is necessary to identify subjects
uniquely in inter-generational datasets.  A Gen1 subject with an ID of 43
has a `SubjectTag` of 4300.  The SubjectTags of her four children
remain 4301, 4302, 4303, and 4304.

Level 5 of `RelationshipPath` (ie, AuntNiece) is gender neutral.  The
relationship could be either Aunt-Niece, Aunt-Nephew, Uncle-Niece, or
Uncle-Nephew.  If there's a widely-accepted gender-neutral term, please
tell me.

An extended family with *k* subjects will have
*k*(*k*-1)/2 rows.  Typically, Subject1 is older while Subject2 is
younger.

MZ twins have *R*=1.  DZ twins and full-siblings have *R*=.5.
Half-siblings have *R*=.25. Typical first cousins have *R*=.125.
Unrelated subjects have *R*=0 (this occasionally happens for
`Gen1Housemates`).  Other *R* coefficients are possible. 

There are several other uncommon possibilities, such as half-cousins (*R*=.0625) and 
ambiguous aunt-nieces (*R*=.125). The variable coding for genetic relatedness, `R`, in `Links79Pair` contains
only the common values of *R* whose groups are likely to have stable estimates.  
However the variable `RFull` in `Links79PairExpanded` contains all *R* values.
We strongly recommend using `R` in this dataset.  Move to 
`RFull` (or some combination) only if you have a good reason, and are willing
to carefully monitor a variety of validity checks.  Some of these
excluded groups are too small to be estimated reliably.  

Furthermore, some of these groups have members who are more strongly genetically related than their 
items would indicate. For instance, there are 41 Gen1 pairs who explicitly claim they are not biologically related
(*ie*, `RExplicit`=0), yet their correlation for Adult Height is *R*=0.24.  This is
much higher than would be expected for two people sampled randomly; it is nearly identical to 
the *R*=0.26 we observed among the 268 Gen1 half-sibling pairs who claim they share exactly 1
biological parent.

The `LinksPair79` dataset contains columns necessary for a
basic BG analysis.  The `Links79PairExpanded` dataset contains
further information that might be useful in more complicated BG analyses.

A tutorial that produces a similar dataset is
http://www.nlsinfo.org/childya/nlsdocs/tutorials/linking_mothers_and_children/linking_mothers_and_children_tutorial.html.
It provides examples in SAS, SPSS, and STATA.

The current dataset (ie, `Links79Pair`) can be saved as a CSV file
(comma-separated file) and imported into in other programs and languages.
In the R console, type the following two lines of code:
