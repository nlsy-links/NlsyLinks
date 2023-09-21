---
title: 'BGmisc: An R Package for Extended Behavior Genetics Analysis'
output:
  rmarkdown::html_vignette:
    keep_md: TRUE
tags:
  - R
  - pedigrees
  - behavior genetics
authors:
  - name: S. Mason Garrison
    orcid: 0000-0002-4804-6003
    affiliation: 1
  - name: Michael D. Hunter
    orcid: 0000-0002-3651-6709
    affiliation: 2
  - name: Xuanyu Lyu
    orcid: 0000-0002-2841-5529
    affiliation: "1, 3, 4" # (Multiple affiliations must be quoted)
  - name: Jonathan D. Trattner
    orcid: 0000-0002-1097-7603
    affiliation: 1  
  - name: S. Alexandra Burt
    orcid: 0000-0001-5538-7431
    affiliation: 5
affiliations:
 - name: Department of Psychology, Wake Forest University, North Carolina, USA
   index: 1
 - name:  Department of Human Development and Family Studies, Pennsylvania State University, Pennsylvania, USA
   index: 2
 - name: Institute for Behavioral Genetics, University of Colorado at Boulder, Boulder, USA 
   index: 3
 - name: Department of Psychology & Neuroscience, University of Colorado at Boulder, Boulder, USA
   index: 4
 - name: Department of Psychology, Michigan State University, Michigan, USA
   index: 5
date: "19 September, 2023"
bibliography: paper.bib
vignette: >
  %\VignetteEncoding{UTF-8}
  %\VignetteIndexEntry{modelingandrelatedness}
  %\VignetteIndexEntry{pedigree}
  %\VignetteEngine{knitr::rmarkdown}
---




<!--Guidance 
JOSS welcomes submissions from broadly diverse research areas. For this reason, we require that authors include in the paper some sentences that explain the software functionality and domain of use to a non-specialist reader. We also require that authors explain the research applications of the software. The paper should be between 250-1000 words. Authors submitting papers significantly longer than 1000 words may be asked to reduce the length of their paper.
Your paper should include:

A list of the authors of the software and their affiliations, using the correct format (see the example below).
A summary describing the high-level functionality and purpose of the software for a diverse, non-specialist audience.
A Statement of need section that clearly illustrates the research purpose of the software and places it in the context of related work.
A list of key references, including to other software addressing related needs. Note that the references should include full names of venues, e.g., journals and conferences, not abbreviations only understood in the context of a specific discipline.
Mention (if applicable) a representative set of past or ongoing research projects using the software and recent scholarly publications enabled by it.
Acknowledgment of any financial support.
-->

# Summary

<!--  A summary describing the high-level functionality and purpose of the software for a diverse, non-specialist audience. -->

The field of behavior genetics focuses on illuminating genetic and environmental influences on individual differences.
Traditionally, twin studies have been at the forefront of this discipline. However, research has moved beyond the classical twin design to embrace more complex family structures such as children of twins (CoT) [@DOnofrio2003], mother-daughter-aunt-niece (MDAN) [@rodgers_mdan], and other extended family designs. These expansions allow for a deeper, more nuanced exploration of genetic and environmental influences, but it also introduces challenges, particularly in data structuring and modeling. In particular, the data structures inherent in these more complicated family designs are orders of magnitude larger than traditional designs. In the classical twin study, for example, a family will consist of a single pair of twins (i.e., two people), whereas in the MDAN design, a family consists of two mother-daughter pairs (i.e., four people). This problem quickly becomes intractable when applied to very extended family pedigrees, where a single family can be of any size.  The `BGmisc` package addresses this gap by offering a comprehensive suite of functions for structuring and modeling extended family pedigree data.


# Statement of need
<!-- A Statement of need section that clearly illustrates the research purpose of the software and places it in the context of related work. -->

As behavior genetics delves into more complex data structures like extended pedigrees, the limitations of current tools become evident. Understandably, packages like `OpenMx` [@Neale2016], `EasyMx` [@easy], and `kinship2` [@kinship2; @kinship2R]  were built for  smaller families and classical designs. In contrast, the `BGmisc` R package was specifically developed to structure and model extended family pedigree data.

Two widely-used R packages in genetic modeling are `OpenMx` [@Neale2016] and `kinship2` [@kinship2; @kinship2R]. The `OpenMx` [@Neale2016] package is a general-purpose software for structural equation modeling that is popular among behavior geneticists [@Garrison2018] for its unique features, like the `mxCheckIdentification()` function. This function checks whether a model is identified, determining if there is a unique solution to estimate the model's parameters based on the observed data. In addition, `EasyMx` [@easy] is a more user-friendly package that streamlines the process of building and estimating structural equation models. It seamlessly integrates with `OpenMx`'s infrastructure. Its functionalities range from foundational matrix builders like `emxCholeskyVariance` and `emxGeneticFactorVariance` to more specialized functions like `emxTwinModel` designed for classical twin models. Despite their strengths, `EasyMx` and `OpenMx` have limitations when handling extended family data. Notably, they lack functions for handling modern molecular designs [@kirkpatrick_combining_2021], modeling complex genetic relationships, inferring relatedness, and simulating pedigrees.

Although not a staple in behavior genetics, the `kinship2` [@kinship2] package provides core features to the broader statistical genetics scientific community, such as plotting pedigrees and computing genetic relatedness matrices. It uses the Lange algorithm [@lange_genetic_2002] to compute relatedness coefficients. This recursive algorithm is discussed in great detail elsewhere, laying out several boundary conditions and recurrence rules. The `BGmisc` package extends the capabilities of `kinship2` by introducing an alternative algorithm to calculate the relatedness coefficient based on network models. By applying classic path-tracing rules to the entire network, this new method is computationally more efficient by eliminating the need for a multi-step recursive approach.

## Features

The `BGmisc` package offers features tailored for extended behavior genetics analysis. These features are grouped under two main categories, mirroring the structure presented in our vignettes.

### Modeling and Relatedness:

-   Model Identification: `BGmisc` evaluates whether a variance components model is identified and fits the model's estimated variance components to observed covariance data. The technical aspects related to model identification have been described by @hunter_analytic_2021.

-   Relatedness Coefficient Calculation: Using path tracing rules first described by @Wright1922 and formalized by @mcardleRAM, `BGmisc` calculates the (sparse) relatedness coefficients between all pairs of individuals in extended pedigrees based solely on mother and father identifiers. 

-   Relatedness Inference: `BGmisc` infers the relatedness between two groups based on their observed total correlation, given additive genetic and shared environmental parameters.


### Pedigree Analysis and Simulation:

-   Pedigree Conversion: `BGmisc` converts pedigrees into various relatedness matrices, including additive genetics, mitochondrial, common nuclear, and extended environmental relatedness matrices.

-   Pedigree Simulation: `BGmisc` simulates pedigrees based on parameters including the number of children per mate, generations, sex ratio of newborns, and mating rate.



<!-- Mention (if applicable) a representative set of past or ongoing research projects using the software and recent scholarly publications enabled by it.-->

Collectively, these tools provide a valuable resource for behavior geneticists and others who work with extended family data. They were developed as part of a grant and have been used in several ongoing projects [@lyu_statistical_power_2023; @hunter_modeling_2023; @garrison_analyzing_2023; @burt_mom_genes_2023] and theses [@lyu_masters_thesis_2023].

# Availability

The `BGmisc` package is open-source and available on both GitHub at [https://github.com/R-Computing-Lab/BGmisc](https://github.com/R-Computing-Lab/BGmisc) and the Comprehensive R Archive Network (CRAN) at [https://cran.r-project.org/package=BGmisc](https://cran.r-project.org/package=BGmisc). It is licensed under the GNU General Public License.

# Acknowledgments

The current research is supported by the National Institute on Aging (NIA), RF1-AG073189. We want to acknowledge assistance from Carlos Santos.

# References
