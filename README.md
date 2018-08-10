
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

[![Last-changedate](https://img.shields.io/badge/last%20change-2018--08--10-yellowgreen.svg)](/commits/master)

[![Build
Status](https://travis-ci.org/pridiltal/oddwater.svg?branch=master)](https://travis-ci.org/pridiltal/oddwater)

<!-- README.md is generated from README.Rmd. Please edit that file -->

# oddwater

We propose a framework to detect anomalies in water quality sensor data.

This package is still under development and this repository contains a
development version of the R package *oddwater*.

## Installation

You can install oddwater from github with:

``` r
# install.packages("devtools")
devtools::install_github("pridiltal/oddwater")
```

## Example

### Data Preprocessing. These outliers were confirmed by DES

``` r
library(oddwater)
library(tidyverse)
#Label data
# Outliers confirmed by DES
outliers <- c("22-03-17 10:00", "05-04-17 7:20", "13-06-17 4:50", "03-11-17 7:50", "26-07-17 16:00")
# Neighbours of those outliers
neighbours <- c("22-03-17 11:10", "05-04-17 8:50", "13-06-17 6:20", "26-07-17 15:00", "03-11-17 9:20")
# label points as outliers or typical
sandy_creek$type <- ifelse( (sandy_creek$Timestamp  %in% outliers ), "outlier", "typical")
neighbour <- which(sandy_creek$Timestamp  %in% neighbours )
sandy_creek$type[neighbour] <- "neighbour"


# Change time format
sandy_creek$Timestamp <- lubridate::dmy_hm(sandy_creek$Timestamp)
```

### Visualize time gap

`sandy_creek` data is an irregular time
series

``` r
data <- sandy_creek[,c("Timestamp", "Lsonde_Cond_uscm", "Lsonde_Turb_NTU",      
                       "Lsonde_Level_m","type")] %>% drop_na()
plot_time_gap(data)
#> Warning: Removed 1 rows containing missing values (geom_path).
```

![](README-time_gap-1.png)<!-- -->

### Transform data

``` r
data <- sandy_creek[,c("Timestamp", "Lsonde_Cond_uscm", "Lsonde_Turb_NTU",      
                       "Lsonde_Level_m","type")] %>% drop_na()
trans_data <- oddwater::transform_data(data)
#> Warning in log(data_var): NaNs produced
```

### Visualize original data

``` r
plot_var <- trans_data[, c("Timestamp", "type", "Lsonde_Cond_uscm",   
                           "Lsonde_Turb_NTU", "Lsonde_Level_m" )] %>% drop_na()
oddwater::plot_series(plot_var, title = "original series") 
```

![](README-vis_orig%20-1.png)<!-- -->

``` r
oddwater::plot_pairs(plot_var)
```

![](README-vis_orig%20-2.png)<!-- -->

### Visualize transformed data

``` r
plot_var <- trans_data[, c("Timestamp", "type", "neg_der_log_bounded_turb",
                           "pos_der_log_bounded_cond", "neg_der_log_bounded_level")] %>% drop_na()
colnames(plot_var) <- abbreviate(colnames(plot_var), minlength=20)
oddwater::plot_series(plot_var, title = "Non linear transformation - one side log derivatives (bounded")
```

![](README-vis_trans%20-1.png)<!-- -->

``` r
oddwater::plot_pairs(plot_var)
```

![](README-vis_trans%20-2.png)<!-- -->

### Compute performance metrics

``` r
# Generate a toy dataset
true_labels <- c("out", "out", "normal", "out", "normal", "normal", "normal", "normal", "normal", "normal")
output <-  c("out", "normal", "normal", "normal", "out", "out", "normal", "normal", "normal", "normal")
# Compute performance metrics 
out<- calc_performance_metrics(y_truth = true_labels, y_output = output, pos_label = "out", neg_label = "normal")
#>                      Value
#> TN                  5.0000
#> FN                  2.0000
#> FP                  2.0000
#> TP                  1.0000
#> Accuracy            0.6000
#> Error_Rate          0.4000
#> Sensitivity         0.3333
#> Specificity         0.7143
#> Precision           0.3333
#> Recall              0.1667
#> F_Measure           0.2222
#> Optimised_Precision 0.2364
```

Compute Means square Error

``` r
clac_MSE(true_y, pred_y)
```

## Further Details

``` r
?oddwater
```
