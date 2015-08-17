## Description
This submission updates & improves various small things.  Many changes are to keep up with CRAN policy changes since April 2014. For instance, a shorter title, and using `requireNamespace()` instead of `require()`.  Please tell me if there's something else I should do for CRAN.

After my first submission last night, Kurt caught that the URL in the description field wasn't enclosed in <...>; that is now corrected.  

> I get
> 
```
Found the following (possibly) invalid URLs:
  URL: http://www.bls.gov/nls/nlsy79ch.htm)
    From: man/Links79Pair.Rd
    Status: 404
    Message: Not Found
```
> Can you pls fix?  (Remove the final paren from the URL).
> 
> In plain text (such as the Description field) it is recommended to enclode URLs in <...>

For some reason, that wasn't caught by the five remote test machines.  I'm open to any suggestions how to configure these builds so they mimic CRAN machines and prevent more of my mistakes slipping through to a human.  The five that I ran last night before my first submission were:

* [win-builder R-devel](http://win-builder.r-project.org/68aDSl8xhbGq/00check.log)
* [win-builder R-release](http://win-builder.r-project.org/WstV5xxuzI3F/00check.log)
* [Travis-CI `--as-cran`](https://travis-ci.org/LiveOak/NlsyLinks/builds/75873235#L1736)
* [AppVeyor `--as-cran`](https://ci.appveyor.com/project/wibeasley/nlsylinks/build/1.0.29#L218)
* [Werker](https://app.wercker.com/#buildstep/55d13044b006c1f91e048052)

-Will Beasley

## Test environments
* Local Win8, R 3.2.2 patched
* [win-builder (version="R-devel")](http://win-builder.r-project.org/2iJJ9Mu3J0cr)
* [Travis CI, Ubuntu 12.04 LTS](https://travis-ci.org/LiveOak/NlsyLinks/)
* [AppVeyor, Windows Server 2012](https://ci.appveyor.com/project/wibeasley/nlsylinks)
* [Werker, Docker](https://app.wercker.com/#applications/5590d20a4fea05eb7a02e590)

## R CMD check results
* No ERRORs or WARNINGs on any builds.
* One NOTEs on win-builder.
    1. The package size has a few large data files; the data size is around 4Mb.  I believe the size is justified because it drastically reduces the code needed for the package user to start incorporating their outcomes on to the larger familial framework we've build.  (One of the package's cornerstones is how we've linked the 24,000 participants within the 5,160 extended families.)
        a. The (uncompressed) CSV is needed for an important example how to incorporate the CSVs downloaded from the NLSY database.  I've used only the necessary columns.
        b. The compressed RDA files have important participant data the allows the package user to incoporate
* No other unexplainable NOTEs on the other builds.

## Downstream dependencies
No other packages depend/import this one.
