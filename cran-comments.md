## Description
This submission corresponds to the new version of testthat.  One of the tests catching a failing condition needed to change.  -Will Beasley

Test environments
-----------------------------------------------

* Local Ubuntu 14.04 LTS
* [win-builder (version="R-devel")](http://win-builder.r-project.org/68aDSl8xhbGq)
* [Travis CI, Ubuntu 12.04 LTS](https://travis-ci.org/LiveOak/NlsyLinks/)
* [AppVeyor, Windows Server 2012](https://ci.appveyor.com/project/wibeasley/nlsylinks)
<!-- * [Werker, Docker](https://app.wercker.com/#applications/5590d20a4fea05eb7a02e590) -->

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
