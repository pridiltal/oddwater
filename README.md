
[![Project Status: WIP ? Initial development is in progress, but there
has not yet been a stable, usable release suitable for the
public.](https://www.repostatus.org/badges/latest/wip.svg)](https://www.repostatus.org/#wip)
[![Licence](https://img.shields.io/badge/licence-GPL--3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0.en.html)

-----

[![minimal R
version](https://img.shields.io/badge/R%3E%3D-3.4.0-6666ff.svg)](https://cran.r-project.org/)
[![CRAN\_Status\_Badge](http://www.r-pkg.org/badges/version/oddwater)](https://cran.r-project.org/package=oddwater)
[![packageversion](https://img.shields.io/badge/Package%20version-0.1.0-orange.svg?style=flat-square)](commits/master)

-----

[![Last-changedate](https://img.shields.io/badge/last%20change-2019--02--13-yellowgreen.svg)](/commits/master)

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
