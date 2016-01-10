---
title: "Software and Support"
---

***
## NlsyLinks and Examples for R

The [`NlsyLinks`](http://cran.r-project.org/web/packages/NlsyLinks/) [R](http://en.wikipedia.org/wiki/R_%28programming_language%29) package contains utilities and kinship information for behavior genetics and developmental research using the [NLSY](http://www.bls.gov/nls/).  The development (and directions for installing it) are located in a [GitHub](https://github.com/LiveOak/NlsyLinks) repository.

For beginners, the most helpful documents are:

 * [Package documentation](http://cran.r-project.org/web/packages/NlsyLinks/NlsyLinks.pdf)
 * [Vignette of estimating ACE models with the NlsyLinks package](http://cran.r-project.org/web/packages/NlsyLinks/vignettes/NlsyAce.pdf)
 * [Vignette for extracting NLSY data](http://cran.r-project.org/web/packages/NlsyLinks/vignettes/NlsInvestigator.pdf)
 * [NlsyLinks FAQ](http://cran.r-project.org/web/packages/NlsyLinks/vignettes/Faq.pdf)

[![DOI](https://zenodo.org/badge/4971/LiveOak/NlsyLinks.png)](http://dx.doi.org/10.5281/zenodo.12519) Package DOI

[![DOI](https://zenodo.org/badge/doi/10.5281/zenodo.12425.png)](http://dx.doi.org/10.5281/zenodo.12425) Website DOI

***
## Examples for [SAS](http://en.wikipedia.org/wiki/SAS_%28software%29)
Because the links are distributed in a variety of file formats (including as non-proprietary CSVs), the are accessible by all statistical software.  The NLSY and BG concepts and basic programming are fairly consistent across languages, so the R examples should be roughly translatable into different statistical platforms.  

Here's a SAS example that covers the basics.  If you have a need for a different example, or a different language, feel free to request it in the ['Other Software' section in our forums](https://r-forge.r-project.org/forum/forum.php?forum_id=4316&group_id=1330).  We would like to know what examples of platforms are the most useful to the potential users of the links.

* [SAS Example](https://github.com/LiveOak/NlsyLinks/blob/master/NlsyLinks/UtilityScripts/SasExample/SasExample.md)

***
## NlsyLinksDetermination in C\#
The [`NlsyLinksDetermination` repository](https://github.com/LiveOak/NlsyLinksDetermination/) contains the [C#](http://en.wikipedia.org/wiki/C_Sharp_%28programming_language%29) code that manipulates the NLSY data to produce the relatedness values.  If you're only interested in the R package (and not how the relatedness coefficients were determined), then please see the [`NlsyLinks`](./research_software_and_support.html#nlsylinks-and-examples-for-r) package described above.

[![DOI](https://zenodo.org/badge/doi/10.5281/zenodo.12518.png)](http://dx.doi.org/10.5281/zenodo.12518) Algorithm DOI

***
## Support Forums
Our [support forums](https://r-forge.r-project.org/forum/?group_id=1330) are intended to cover all aspects of this project, not just software.  The top-level forums are:

 * [Open Discussion](https://r-forge.r-project.org/forum/forum.php?forum_id=4266&group_id=1330): General discussion
 * [Package Development](https://r-forge.r-project.org/forum/forum.php?forum_id=4268&group_id=1330): Discussion & questions about *developing* the [NlsyLinks](http://cran.r-project.org/web/packages/NlsyLinks/) package
 * [Applied Research](https://r-forge.r-project.org/forum/forum.php?forum_id=4314&group_id=1330): BG and other applied research, including downloading kinship links
 * [Package Usage](https://r-forge.r-project.org/forum/forum.php?forum_id=4315&group_id=1330): Discussion & questions about *using* the [NlsyLinks](http://cran.r-project.org/web/packages/NlsyLinks/) package
 * [Other Software](https://r-forge.r-project.org/forum/forum.php?forum_id=4316&group_id=1330): Discussion of using the links in SAS, Mplus, OpenMx, etc
