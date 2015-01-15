This release is in response to check notes found by Hadley as he prepared the next devtools release.  I've changed how internal datasets are referenced in two places.  I also made some updates to reflect newer CRAN policies (eg, a shorter title, and using `requireNamespace()` instead of `require()`).

I've checked it on four local machines (one Win8, two Ubuntus, and one Red Hat server), a Linux build on Travis-CI (https://travis-ci.org/LiveOak/NlsyLinks) and Uwe's win-builder (http://win-builder.r-project.org/dwz98k4DUC0Q/).  Please tell me if there's something else I should do for CRAN.

-Will Beasley
