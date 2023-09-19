# Using SAS with the NlsyLinks R Package

## Authors
 * [Michael D. Hunter](https://acquia-prod.hhd.psu.edu/contact/michael-hunter), University of Oklahoma Health Sciences Center, OKC
 * [William Howard Beasley](http://scholar.google.com/citations?user=ffsJTC0AAAAJ), Howard Live Oak LLC, Norman
 * [Joseph Lee Rodgers](https://www.vanderbilt.edu/psychological_sciences/bio/joe-rodgers), Vanderbilt University, Nashville
 * [David Bard](https://medicine.ouhsc.edu/Academic-Departments/Pediatrics/Sections/Developmental-Behavioral-Pediatrics/Faculty/david-e-bard-phd), University of Oklahoma Health Sciences Center, OKC
 * [Kelly Meredith](http://www.okcu.edu/admin/academic-affairs/staff/bio/item-id-77), Oklahoma City University, OKC
 
## Abstract
We describe how to use the R package [`NlsyLinks`](https://cran.r-project.org/package=NlsyLinks) with the SAS program.  This is a replication of the analyses from the [ACE Models with the NLSY](https://nlsy-links.github.io/NlsyLinks/articles/nlsy-ace.html) vignette section called "Example: DF analysis with a univariate outcome from a Gen2 Extract".

## Import Links to SAS, Perform Data Manipulation, and Return to R
SAS Code:
```
/*import csv */
DATA  LinksFromRPackage;
  INFILE  "E:/links.csv" DSD LRECL=1024 DLM=',' FIRSTOBS=2;
    LENGTH RelationshipPath $14;
    INPUT ExtendedID Subject1Tag Subject2Tag R RelationshipPath $;
    IF RelationshipPath="Gen2Siblings" THEN OUTPUT;
RUN;
```

Note that for this to run missing values must be `.` as SAS specifies them not `NA`, the default R missing value code.  The file `links.csv` with the path `E:/links.csv` can be downloaded from [GitHub](https://github.com/nlsy-links/NlsyLinks/raw/master/UtilityScripts/SasExample/links.csv) or exported from the [`NlsyLinks`](https://cran.r-project.org/package=NlsyLinks) R package with the following R code.

```
### Begin R Code to export links
 library(NlsyLinks)
 dlink <- subset(Links79Pair, RelationshipPath="Gen2Siblings")
 fp <- file.path(path.package("NlsyLinks"), "extdata", "gen2-birth.csv")
 getwd() # Run this line to find out where files were saved
 dout <- ReadCsvNlsy79Gen2(fp)
 write.csv(dout, file="outs.csv", row.names=FALSE, na=".")
 write.csv(dlink, file="links.csv", row.names=FALSE, na=".", quote=FALSE)
### End R code to export links
```

Once the linking file has been exported from R, the SAS code mentioned previously can be run to read the linking data into SAS.  The next few lines of SAS code read in the outcome data.  Some outcome data can be obtained from the [`NlsyLinks`](https://cran.r-project.org/package=NlsyLinks) package, but usually the NLS Investigator website will be the source of the outcome data.

```
DATA  OutcomesFromRPackageOrYou;
  INFILE "E:/outs.csv"
		DSD LRECL=1024 DLM=',' FIRSTOBS=2;
	INPUT SubjectTag SubjectID ExtendedID Generation SubjectTagOfMother
		C0005300 C0005400 C0005700 C0328000 BirthWeightInOunces C0328800;
	IF BirthWeightInOunces < 0 THEN BirthWeightInOunces = .;
	IF BirthWeightInOunces NE . AND BirthWeightInOunces > 200
		THEN BirthWeightInOunces = 200;
RUN;
```

The user could change the `INFILE` to something like the following where these example NLSY data are stored in the R package.

```
INFILE  "C:/Program Files/R/R-2.14.2/library/NlsyLinks/extdata/gen2-birth.csv"
```
Other data manipulations in SAS could then be done, followed by saving the desired data as csv and finally running analyses in R after reading in this new csv made from SAS.

## Import Links to SAS, Perform Data Manipulation, and DF Analysis

<!---**Mike, I think the Markdown above has all the examples you use later, except for output.  It probably makes sense to use the same code block formatting, just as if it were input code.** --->

SAS Output:
```
                                      The SAS System       16:23 Sunday, January 19, 2014   8
                                       Merge by ID2

                                    The REG Procedure
                                      Model: MODEL1
                       Dependent Variable: BirthWeightInOunces_1c

                  Number of Observations Read                      22176
                  Number of Observations Used                      17440
                  Number of Observations with Missing Values        4736


                   NOTE: No intercept in model. R-Square is redefined.

                                   Analysis of Variance

                                          Sum of           Mean
      Source                   DF        Squares         Square    F Value    Pr > F

      Model                     2        1349821         674911    1583.84    <.0001
      Error                 17438        7430721      426.12230
      Uncorrected Total     17440        8780542


                   Root MSE             20.64273    R-Square     0.1537
                   Dependent Mean       -0.09445    Adj R-Sq     0.1536
                   Coeff Var              -21855


                                   Parameter Estimates

                                           Parameter       Standard
Variable                          DF       Estimate          Error    t Value    Pr > |t|

BirthWeightInOunces_2c             1        0.17766        0.02308       7.70      <.0001
R_times_BirthWeightInOunces_2c     1        0.50416        0.05313       9.49      <.0001
```
This concludes the vignette on using the SAS with the [`NlsyLinks`](https://cran.r-project.org/package=NlsyLinks) package.
