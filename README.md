
<!-- README.md is generated from README.Rmd. Please edit that file -->
oddwater
========

We propose a framework to detect anomalies in water quality sensor data.

This package is still under development and this repository contains a development version of the R package *oddwater*.

Installation
------------

You can install oddwater from github with:

``` r
# install.packages("devtools")
devtools::install_github("pridiltal/oddwater")
```

Example
-------

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


# Change time format
sandy_creek$Timestamp <- lubridate::dmy_hm(sandy_creek$Timestamp)
```

### Visualize time gap

`sandy_creek` data is an irregular time series

``` r
data <- sandy_creek[,c("Timestamp", "Lsonde_Cond_uscm", "Lsonde_Turb_NTU",      
                       "Lsonde_Level_m","type")] %>% drop_na()
plot_time_gap(data)
```

### Transform data

``` r
data <- sandy_creek[,c("Timestamp", "Lsonde_Cond_uscm", "Lsonde_Turb_NTU",      
                       "Lsonde_Level_m")] %>% drop_na()
trans_data <-transform_data(data)
#> Warning in log(data_var): NaNs produced
head(trans_data)
#> # A tibble: 6 x 17
#>   Timestamp           Lsonde_Cond_uscm Lsonde_Turb_NTU Lsonde_Level_m
#>   <dttm>                         <dbl>           <dbl>          <dbl>
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

### Visualize original data

``` r
plot_var <- dplyr::left_join(trans_data, sandy_creek, by = "Timestamp")

plot_var <- trans_data[, c("Timestamp", "type", "Lsonde_Cond_uscm",   
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

Further Details
---------------

``` r
?oddwater
```
