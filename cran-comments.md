## Description
This submission updates & improves various small things.  Many changes are to keep up with CRAN policy changes since April 2014. For instance, a shorter title, and using `requireNamespace()` instead of `require()`.  Please tell me if there's something else I should do for CRAN.

-Will Beasley

## Test environments
* Local Win8, R 3.2.2 patched
* win-builder (version="R-devel"); http://win-builder.r-project.org/6m63wUFP9hI9
* Travis CI, Ubuntu 12.04 LTS; https://travis-ci.org/LiveOak/NlsyLinks/
* AppVeyor, Windows Server 2012; https://ci.appveyor.com/project/wibeasley/nlsylinks

## R CMD check results
* No ERRORs or WARNINGs on any builds.
* One NOTEs on win-builder.
    1. The package size has a few large data files; the data size is around 4Mb.  I believe the size is justified because it drastically reduces the code needed for the package user to start incorporating their outcomes on to the larger familial framework we've build.  (One of the package's cornerstones is how we've linked the 24,000 participants within the 5,160 extended families.)
        a. The (uncompressed) CSV is needed for an important example how to incorporate the CSVs downloaded from the NLSY database.  I've used only the necessary columns.
        b. The compressed RDA files have important participant data the allows the package user to incoporate
* No other unexplainable NOTEs on the other builds.

## Downstream dependencies
No other packages depend/import this one.
