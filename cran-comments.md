Description
-----------------------------------------------

This minor update  (2.2.3) fixes a few minor bugs, and updates the package documentation.


Test environments
-----------------------------------------------

1. **GitHub Actions**:  
    - [Link](https://github.com/nlsy-links/NlsyLinks/actions/runs/17328325261/job/49199075177)
    - macOS (latest version) with the latest R release.
    - Windows (latest version) with the latest R release.
    - Ubuntu (latest version) with:
        - The development version of R.
        - The latest R release.
        - The penultimate release of R.
2. **Others**:
    - Local Windows 11 x64 (build 26120), 4.5.1 (2025-06-13 ucrt)

R CMD check results
-----------------------------------------------
Duration: 56.5s

0 errors ✔ | 0 warnings ✔ | 0 notes ✔

R CMD check succeeded

* One possible NOTE, depending on the build:
    1. The package size has a few large data files; the data size is around 4Mb.  I believe the size is justified because it drastically reduces the code needed for the package user to start incorporating their outcomes on to the larger familial framework we've build.  (One of the package's cornerstones is how we've linked the 24,000 participants within the 5,160 extended families.)
        a. The (uncompressed) CSV is needed for an important example how to incorporate the CSVs downloaded from the NLSY database.  I've used only the necessary columns.
        b. The compressed RDA files have important participant data the allows the package user to incorporate



Downstream dependencies
-----------------------------------------------
No other packages depend/import this one.
