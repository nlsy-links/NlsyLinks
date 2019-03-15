## Description
This submission is a continuation of yesterday's submission (which corresponded to the new version of testthat --one of the tests catching a failing condition needed to change).

Kurt asked, "Would it be possible to put some of the data sets into a separate package which changes less frequently than code and docs?" I'll gladly defer to your judgment and recommendations, but I see two reasons to retain a united package.  

First, our primary target audience is Behavior Genetics researchers, who typically are much less familar with R than other fields.  There have been at least 3 BG researchers who have requested SAS data files, because they weren't even comfortable reading vanilla CSV files into SAS.  I'd like to avoid another step/package for them to consider, even if the dataset-only package was a dependency.  

Second, assuming our grant proposal is funded, the datasets won't stay stagnant.  The NLSY has three cohorts that are surveyed every two years.  This will be only the [second CRAN submission since Dec 2013](https://cran.rstudio.com/src/contrib/Archive/NlsyLinks/), and most of those changes [were to stay current updated CRAN policies](https://cran.rstudio.com/web/packages/NlsyLinks/NEWS).  The dataset-package would have needed to change too, and therefore increase the demands on CRAN maintainers (because both packages might required updates).

However, I'm happy to split this package if that's what you feel is best for CRAN and R users.  -Will Beasley

Test environments
-----------------------------------------------

* Local Ubuntu 14.04 LTS
* [win-builder (version="R-devel")](http://win-builder.r-project.org/68aDSl8xhbGq)
* [Travis CI, Ubuntu 12.04 LTS](https://travis-ci.org/LiveOak/NlsyLinks/)
* [AppVeyor, Windows Server 2012](https://ci.appveyor.com/project/wibeasley/nlsylinks)


R CMD check results
-----------------------------------------------

* No ERRORs or WARNINGs on any builds.
* One notable NOTE:
    1. The package size has a few large data files; the data size is around 4Mb.  I believe the size is justified because it drastically reduces the code needed for the package user to start incorporating their outcomes on to the larger familial framework we've build.  (One of the package's cornerstones is how we've linked the 24,000 participants within the 5,160 extended families.)
        a. The (uncompressed) CSV is needed for an important example how to incorporate the CSVs downloaded from the NLSY database.  I've used only the necessary columns.
        b. The compressed RDA files have important participant data the allows the package user to incoporate
* No other unexplainable NOTEs.  The AppVeyor bulid complains about the vingette, but I think that's something specific to that test environment, and not to the package.

## Downstream dependencies
No other packages depend/import this one.
