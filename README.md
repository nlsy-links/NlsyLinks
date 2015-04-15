NlsyLinks
================

Travis-CI on Ubuntu 12.04 LTS: [![Build Status](https://travis-ci.org/LiveOak/NlsyLinks.svg?branch=master)](https://travis-ci.org/LiveOak/NlsyLinks);
AppVeyor on Windows Server 2012: [![Build status](https://ci.appveyor.com/api/projects/status/fo1oeqn9734dhhmu/branch/master?svg=true)](https://ci.appveyor.com/project/wibeasley/nlsylinks/branch/master)

Independently-hosted Archive: [![DOI](https://zenodo.org/badge/4971/LiveOak/NlsyLinks.png)](http://dx.doi.org/10.5281/zenodo.12519). Coveralls: [![Coverage Status](https://coveralls.io/repos/LiveOak/NlsyLinks/badge.svg?branch=master)](https://coveralls.io/r/LiveOak/NlsyLinks?branch=master)

## Description

Utilities and kinship information for behavior genetics and
developmental research using the National Longitudinal Survey of Youth
([NLSY](http://www.bls.gov/nls/))

## Installing 

The *release* version of `NlsyLinks` can be installed from [CRAN](http://cran.r-project.org/web/packages/NlsyLinks/).

```r
install.packages("NlsyLinks")
```

The latest *development* version of `NlsyLinks` can be installed from [GitHub](https://github.com/LiveOak/NlsyLinks/) after installing the `devtools` package.

```r
install.packages("devtools")
devtools::install_github(repo="LiveOak/NlsyLinks")
```

## Locations for Help and Development

This repository contains the code used in the [NlsyLinks](http://cran.r-project.org/web/packages/NlsyLinks/) R package.  For additional information about the package and using it in NLSY research, please see http://liveoak.github.io/NlsyLinks/

We now use  [this GitHub repository](https://github.com/LiveOak/NlsyLinksStaging) as our primary way of managing, tracking, and build-checking versions of the source code.  We continue to use the [R-Forge site](https://r-forge.r-project.org/projects/nlsylinks/) to make sure the most recent version builds on the different OS platforms, and passes the associated checks.  The stable releases (intended for most researchers) is available on the package's  [CRAN site](http://cran.r-project.org/web/packages/NlsyLinks/).

The help forums remain on the package's [R-Forge](https://r-forge.r-project.org/forum/?group_id=1330).  

## Thanks to Funders
The current work on the NLSY Kinship links has been supported by NIH Grant R01-HD065865 ([Joe Rodgers](http://www.vanderbilt.edu/psychological_sciences/bio/joe-rodgers), PI). 

