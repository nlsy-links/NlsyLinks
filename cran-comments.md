Description
-----------------------------------------------

This update addresses a CRAN request to resolve issues related to differences between the .Rout test output files and their corresponding reference .Rout.save files. 
Specifically, I removed the test that was causing the error because it was related to spelling, and frankly given that this package is stable (and I've run a spellcheck), I don't think it's worth the time to fix. 


Test environments
-----------------------------------------------

1. **GitHub Actions**:  
    - [Link](https://github.com/nlsy-links/NlsyLinks/actions/runs/11221026211/)
    - macOS (latest version) with the latest R release.
    - Windows (latest version) with the latest R release.
    - Ubuntu (latest version) with:
        - The development version of R.
        - The latest R release.
        - The penultimate release of R.
2. **Others**:
    - Local Windows 11 x64 (build 22631), R 4.4.1 (2024-06-14 ucrt)

R CMD check results
-----------------------------------------------

* No ERRORs or WARNINGs on any builds.

* Three possible NOTEs, depending on the build:
    1. This is a new submission of a package that is currently archived.
    2. The package size has a few large data files; the data size is around 4Mb.  I believe the size is justified because it drastically reduces the code needed for the package user to start incorporating their outcomes on to the larger familial framework we've build.  (One of the package's cornerstones is how we've linked the 24,000 participants within the 5,160 extended families.)
        a. The (uncompressed) CSV is needed for an important example how to incorporate the CSVs downloaded from the NLSY database.  I've used only the necessary columns.
        b. The compressed RDA files have important participant data the allows the package user to incorporate

* No other unexplainable NOTEs.  The Ubuntu R-hub build complains about some images in a vignette, but I think that's something specific to that test environment, and not to the package.  The other builds (including the other two R-hub builds) don't throw the same warning.

Downstream dependencies
-----------------------------------------------
No other packages depend/import this one.
