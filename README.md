
[![Project Status: WIP ? Initial development is in progress, but there
has not yet been a stable, usable release suitable for the
public.](https://www.repostatus.org/badges/latest/wip.svg)](https://www.repostatus.org/#wip)
[![Licence](https://img.shields.io/badge/licence-GPL--3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0.en.html)

-----

[![minimal R
version](https://img.shields.io/badge/R%3E%3D-3.4.0-6666ff.svg)](https://cran.r-project.org/)
[![CRAN\_Status\_Badge](http://www.r-pkg.org/badges/version/oddwater)](https://cran.r-project.org/package=oddwater)
[![packageversion](https://img.shields.io/badge/Package%20version-0.5.0.9000-orange.svg?style=flat-square)](commits/master)
[![DOI](https://zenodo.org/badge/143960804.svg)](https://zenodo.org/badge/latestdoi/143960804)

-----

[![Last-changedate](https://img.shields.io/badge/last%20change-2019--05--10-yellowgreen.svg)](/commits/master)

[![Build
Status](https://travis-ci.org/pridiltal/oddwater.svg?branch=master)](https://travis-ci.org/pridiltal/oddwater)

<!-- README.md is generated from README.Rmd. Please edit that file -->

# oddwater

Outliers due to technical errors in water-quality data from in situ
sensors can reduce data quality and have a direct impact on inference
drawn from subsequent data analysis. Here, we proposed an automated
framework that provides early detection of outliers in water-quality
data from in situ sensors **caused by technical issues**. The framework
was used first to identify the data features that differentiate outlying
instances from typical behaviours. Then statistical transformations were
applied to make the outlying instances stand out in transformed data
space. Unsupervised outlier scoring techniques were then applied to the
transformed data space and an approach based on extreme value theory was
used to calculate a threshold for each potential outlier.

[In this
work](https://www.monash.edu/__data/assets/pdf_file/0007/1645027/wp01-2019.pdf)
we showed that our proposed framework, with carefully selected data
transformation methods derived from data features, can greatly assist in
increasing the performance of a range of existing outlier detection
algorithms.

This package is still under development and this repository contains a
development version of the R package *oddwater*.

## Installation

You can install oddwater from github with:

``` r
# install.packages("devtools")
devtools::install_github("pridiltal/oddwater")
```

### Illustrative Example

#### Data obtained from in situ sensors at Sandy Creek.

``` r
library(tidyverse)
library(oddwater)
data("data_sandy_anom")
head(data_sandy_anom)
#>         Timestamp Level   Cond   Tur label_Level label_Cond label_Tur
#> 1 12/03/2017 1:00 0.636 326.34 34.47           0          0         0
#> 2 12/03/2017 2:30 0.636 326.63 34.06           0          0         0
#> 3 12/03/2017 4:00 0.635 327.00 33.39           0          0         0
#> 4 12/03/2017 5:30 0.633 327.31 32.61           0          0         0
#> 5 12/03/2017 7:00 0.634 327.81 33.34           0          0         0
#> 6 12/03/2017 8:30 0.631 328.70 32.22           0          0         0
#>   type_Level type_Cond type_Tur
#> 1          0         0        0
#> 2          0         0        0
#> 3          0         0        0
#> 4          0         0        0
#> 5          0         0        0
#> 6          0         0        0
```
