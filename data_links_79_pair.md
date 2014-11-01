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
 * [R Binary](https://github.com/LiveOak/NlsyLinks/blob/master/NlsyLinks/data/Links79PairExpanded.rda), after navigating to the page, click on the 'View Raw' button to download it.
 * *SAS* (coming soon.)

***
# Data Dictionary
The dataset indicates a county's characteristics, with the following fields:

| Variable Name | Type | Variable Description |
| :------------ | :--- | :------------------- |
| ExtendedID | integer | Identity of the extended family of the pair; it corresponds to the HHID in the NLSY79.  See References below. |
| SubjectTag_S1 | integer | Identity of the pair's first subject.  See Details below. |
| SubjectTag_S2 | integer | Identity of the pair's second subject.  See Details below. |
| RelationshipPath | integer | Specifies the relationship category of the pair.  This variable is a factor, with levels `Gen1Housemates`=1, `Gen2Siblings`=2, `Gen2Cousins`=3, `ParentChild`=4, `AuntNiece`=5. |
| R | float | The pair's Relatedness coefficient.  See Details below. |
| RFull | float | This is a superset of `R`.  This includes all the *R* values we estimated, while *R* (i.e., the variable above) excludes values like *R*=0 for `Gen1Housemates`, and the associated relationships based on this *R* value (i.e., `Gen2Cousin`s and `AuntNiece`s).
| EverSharedHouse | integer | Indicate if the pair likely live in the same house.  This is `TRUE` for `Gen1Housemates`, `Gen2Siblings`, and `ParentChild`. This is `FALSE` for `AuntNiece` and `Gen2Cousins`
| IsMz | integer | Indicates if the pair is from the same zygote (ie, they are identical twins/triplets). This variable is a factor, with levels `No`=0, `Yes`=1, `DoNotKnow`=255. |
| LastSurvey_S1 | integer | The year of Subject1's most recently completed survey. This may be different that the survey's administration date. |
| LastSurvey_S2 | integer | The year of Subject2's most recently completed survey. This may be different that the survey's administration date. |
| RImplicitPass1 | float | The pair's *R* coefficient, using only implicit information.  Interpolation was NOT used. |
| RImplicit | float | The pair's *R* coefficient, using only implicit information.  Interpolation was used. |
| RImplicit2004 | float | The pair's *R* coefficient released in our previous projects (**need reference**).  This variable is provided primarily for previous users wishing to replicate previous analyses. |
| RExplicitPass1 | float | The pair's *R* coefficient, using only explicit information.  Interpolation was NOT used. |
| RExplicit | float | The pair's *R* coefficient, using only explicit information.  Interpolation was used. |
| RExplicitOlderSibVersion | float | The pair's *R* coefficient, according to the explicit item responses of the older sibling. |
| RExplicitYoungerSibVersion | float | The pair's *R* coefficient, according to the explicit item responses of the younger sibling. |
| RPass1 | float | The pair's estimated *R* coefficient, using both implicit and explicit information.  Interpolation was NOT used.  The variable `R` is identically constructed, but it did use interpolation. |
| Generation_S1 | integer | The generation of the first subject.  Values for Gen1 and Gen2 are `1` and `2`, respectively. |
| Generation_S2 | integer | The generation of the second subject.  Values for Gen1 and Gen2 are `1` and `2`, respectively. |
| SubjectID_S1 | integer | The ID value assigned by NLS to the first subject.  For Gen1 Subjects, this is their "CaseID" (ie, R00001.00).  For Gen2 subjects, this is their "CID" (ie, C00001.00). |
| SubjectID_S2 | integer | The ID value assigned by NLS to the second subject. |
| MathStandardized_S1 | float | The PIAT-Math score for Subject1.  See [`ExtraOutcomes79`](./data_extra_outcomes_79.html) for more information about its source. |
| MathStandardized_S2 | float | The PIAT-Math score for Subject2. |
| HeightZGenderAge_S1 | float | The early adult height for Subject1.  See [`ExtraOutcomes79`](./data_extra_outcomes_79.html) for more information about its source. |
| HeightZGenderAge_S2 | float | The early adult height for Subject2. |

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
However the variable `RFull` contains all *R* values.
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

`RelationshipPath` variable.  Code written using this dataset should
NOT assume it contains only Gen2 sibiling pairs.  See below for an example of
filtering the relationship category in the in `Links79Pair`
documentation.

The specific steps to determine the *R* coefficient will be described
in an upcoming publication.  The following information may influence the
decisions of an applied researcher.


A distinction is made between `Explicit' and `Implicit' information.
Explicit information comes from survey items that directly address the
subject's relationships.  For instance in 2006, surveys asked if the
sibling pair share the same biological father (eg, Y19940.00 and
T00020.00).  Implicit information comes from items where the subject
typically isn't aware that their responses may be used to determine genetic
relatedness.  For instance, if two siblings have biological fathers with
the same month of death (eg, R37722.00 and R37723.00), it may be reasonable
to assume they share the same biological father.

`Interpolation' is our lingo when other siblings are used to leverage
insight into the current pair.  For example, assume Subject 101, 102, and
103 have the same mother.  Further assume 101 and 102 report they share a
biological father, and that 101 and 103 share one too.  Finally, assume
that we don't have information about the relationship between 102 and 103.
If we are comfortable with our level of uncertainty of these
determinations, then we can interpolate/infer that 102 and 103 are
full-siblings as well.

The math and height scores are duplicated from
[`ExtraOutcomes79`](./data_extra_outcomes_79.html), but are included here to make some examples
more concise and accessible.

***
### Example in R
```r
library(NlsyLinks) #Load the package into the current R session.
summary(Links79Pair)  #Summarize the five variables.
hist(Links79Pair$R)  #Display a histogram of the Relatedness coefficients.
table(Links79Pair$R)  #Create a table of the Relatedness coefficients for the whole sample.

#Create a dataset of only Gen2 sibs, and display the distribution of R.
gen2Siblings <- subset(Links79Pair, RelationshipPath=='Gen2Siblings')
table(gen2Siblings$R)  #Create a table of the Relatedness coefficients for the Gen2 sibs.
```