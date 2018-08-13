
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

[![Last-changedate](https://img.shields.io/badge/last%20change-2018--08--13-yellowgreen.svg)](/commits/master)

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
library(tidyverse)
library(oddwater)
#Label data
# Outliers confirmed by DES
outliers <- c("22-03-17 10:00", "05-04-17 7:20", "13-06-17 4:50", "03-11-17 7:50", "26-07-17 16:00")
# Neighbours of those outliers
neighbours <- c("22-03-17 11:10", "05-04-17 8:50", "13-06-17 6:20", "26-07-17 15:00", "03-11-17 9:20")
# label points as outliers or typical
sandy_creek$type <- ifelse( (sandy_creek$Timestamp  %in% outliers ), "outlier", "typical")
neighbour <- which(sandy_creek$Timestamp  %in% neighbours )
sandy_creek$type[neighbour] <- "neighbour"
```

### Transform data

``` r
data <- sandy_creek[,c("Timestamp", "Lsonde_Cond_uscm", "Lsonde_Turb_NTU",      
                       "Lsonde_Level_m")] %>% drop_na()
trans_data <-oddwater::transform_data(data)
#> Warning in log(data_var): NaNs produced
head(trans_data)
#> # A tsibble: 6 x 17 [!]
#>   Timestamp           Lsonde_Cond_uscm Lsonde_Turb_NTU Lsonde_Level_m
#> * <dttm>                         <dbl>           <dbl>          <dbl>
#> 1 2017-03-12 01:00:00             326.            34.5          0.636
#> 2 2017-03-12 02:30:00             327.            34.1          0.636
#> 3 2017-03-12 04:00:00             327             33.4          0.635
#> 4 2017-03-12 05:30:00             327.            32.6          0.633
#> 5 2017-03-12 07:00:00             328.            33.3          0.634
#> 6 2017-03-12 08:30:00             329.            32.2          0.631
#> # ... with 13 more variables: log_Lsonde_Cond_uscm <dbl>,
#> #   log_Lsonde_Turb_NTU <dbl>, log_Lsonde_Level_m <dbl>,
#> #   diff_log_Lsonde_Cond_uscm <dbl>, diff_log_Lsonde_Turb_NTU <dbl>,
#> #   diff_log_Lsonde_Level_m <dbl>, der_log_bound_Lsonde_Cond_uscm <dbl>,
#> #   der_log_bound_Lsonde_Turb_NTU <dbl>,
#> #   der_log_bound_Lsonde_Level_m <dbl>, neg_der_log_bounded_turb <dbl>,
#> #   pos_der_log_bounded_cond <dbl>, neg_der_log_bounded_level <dbl>,
#> #   time <dbl>
```

### Visualize time gap

`sandy_creek` data is an irregular time series

``` r
trans_data <- trans_data %>% drop_na()
p <- ggplot(trans_data, aes(x= Timestamp, y= time))+
      geom_line()+
      ylab("time (minutes)")
print(p)
```

![](README-time_gap-1.png)<!-- -->

### Visualize original data

``` r
plot_var <- dplyr::left_join(trans_data, sandy_creek, by = "Timestamp")

plot_var <- trans_data[, c("Timestamp", "Lsonde_Cond_uscm",   
                           "Lsonde_Turb_NTU", "Lsonde_Level_m" )] %>% drop_na()
oddwater::plot_series(plot_var, title = "original series") 
oddwater::plot_pairs(plot_var)
```

### Visualize transformed data

``` r
plot_var <- trans_data[, c("Timestamp", "type", "neg_der_log_bounded_turb",
                           "pos_der_log_bounded_cond", "neg_der_log_bounded_level")] %>% drop_na()
colnames(plot_var) <- abbreviate(colnames(plot_var), minlength=20)
oddwater::plot_series(plot_var, title = "Non linear transformation - one side log derivatives (bounded")
oddwater::plot_pairs(plot_var)
```

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
