Description
-----------------------------------------------

This is a revival (re)submission of a package archived from April of 2021. I (Mason Garrison) am taking over as the maintainer from Will Beasley. As part of that process, I am reviving this package. My first goal is getting this united package back on CRAN, so that folks in the field of behavior genetics can have access to the tools and data. After the package is revived, I fully plan to split up the packages into a data package. I have already begun that process [here](https://github.com/R-Computing-Lab/NlsyLinksData), but it will take some time to do that as I need to dive deeper into the older source code. Below are Will's initial notes about the current package size. 

I've addressed the broken urls, which I think was the only thing that failed the incoming checks automatically.


> Regarding package size ("the installed size is 6.0Mb"): A few years ago Kurt asked, "Would it be possible to put some of the data sets into a separate package which changes less frequently than code and docs?" I'll gladly defer to your judgment and recommendations, but I see two reasons to retain a united package.  First, our primary target audience is Behavior Genetics researchers, who typically are much less familiar with R than other fields.  There have been at least 3 BG researchers who have requested SAS data files, because they weren't even comfortable reading vanilla CSV files into SAS.  I'd like to avoid another step/package for them to consider, even if the dataset-only package was a dependency.  Second, the datasets change every few years because the NLSY's three current cohorts are surveyed every two years.  This will be only the [third CRAN submission since Dec 2013](https://cran.rstudio.com/src/contrib/Archive/NlsyLinks/), and most of those changes [were to stay current updated CRAN policies](https://cran.rstudio.com/web/packages/NlsyLinks/NEWS).  The dataset-package would have needed to change too, and therefore increase the demands on CRAN maintainers (because both packages might required updates).
>
> However, I'm happy to split this package if that's what you feel is best for CRAN and R users.  -Will Beasley

Test environments
-----------------------------------------------

1. **GitHub Actions**:  
    - [Link](https://github.com/nlsy-links/NlsyLinks/actions/runs/6187596399)
    - macOS (latest version) with the latest R release.
    - Windows (latest version) with the latest R release.
    - Ubuntu (latest version) with:
        - The development version of R.
        - The latest R release.
        - The penultimate release of R.

2. **R-hub**:
    - [Ubuntu Linux 20.04 LTS, R-release, GCC](https://builder.r-hub.io/status/NlsyLinks_2.0.9.9001.tar.gz-af51fce5ccb14c11a0e6052ff081ed80)
    - [Fedora Linux, R-devel, clang, gfortran](https://builder.r-hub.io/status/NlsyLinks_2.0.9.9001.tar.gz-356245764a0544d892f40e076b7e60c8)
    - [Windows Server 2022, R-oldrel, 32/64 bit](https://builder.r-hub.io/status/NlsyLinks_2.2.1.tar.gz-63181f5449e4894d43178e22a7287300) (*Successful build for NlsyLinks 2.2.1*)
    - [Windows Server](https://builder.r-hub.io/status/NlsyLinks_2.0.9.9001.tar.gz-00b649ba8e9e4b34ad6362d81e6cd0b0)

3. **Others**:
    - Local Ubuntu, R 4.1.0 patched
    - Local Win8, R 4.1.0 patched
    - Local Win10, R 4.3.1 patched
    - [win-builder](https://win-builder.r-project.org/NgcbF52Z5bOZ/00check.log), development version.
    - [GiHub Actions](https://github.com/OuhscBbmc/REDCapR/actions), Ubuntu 20.04 LTS

R CMD check results
-----------------------------------------------

* No ERRORs or WARNINGs on any builds.

* Three possible NOTEs, depending on the build:
    1. This is a new submission of a package that is currently archived.
    2. The package size has a few large data files; the data size is around 4Mb.  I believe the size is justified because it drastically reduces the code needed for the package user to start incorporating their outcomes on to the larger familial framework we've build.  (One of the package's cornerstones is how we've linked the 24,000 participants within the 5,160 extended families.)
        a. The (uncompressed) CSV is needed for an important example how to incorporate the CSVs downloaded from the NLSY database.  I've used only the necessary columns.
        b. The compressed RDA files have important participant data the allows the package user to incorporate
    3. The R-hub calls to "https://www.bls.gov/" have some SSL/TLS handshake problem.  But it works fine with the other environments and when I pasted the url into several browsers.
    
* No other unexplainable NOTEs.  The Ubuntu R-hub build complains about some images in a vignette, but I think that's something specific to that test environment, and not to the package.  The other builds (including the other two R-hub builds) don't throw the same warning.

Downstream dependencies
-----------------------------------------------
No other packages depend/import this one.
