#' Water Quality Sensor data - Sandy_Creek
#'
#' A multivariate dataset containing the variables obtained using water quality
#' sensors from Sandy Creek. The characteristics of the different types of anomalies
#' are presented in detail in Leigh, et al. (2019). The anomaly types can be further
#' grouped into three general classes. Class 1 included anomalies described by a
#' sudden change in value from the previous observation (types A, D, I, and J).
#' Class 2 included those anomaly types that should be detectable by simple,
#' hard-coded classification rules, such as measurements outside the detectable
#' range of the sensor (types F, G and K).
#' Class 3 anomalies may require user intervention post hoc (i.e. after data
#' collection rather than in real time) to confirm observations as anomalous
#' or otherwise in combination with automated detection (types B, C, E, H and L).
#'
#' @format A data frame with 5402 rows and 10 variables:
#' \describe{
#' \item{Timestamp }{Time Stamps}
#' \item{Level }{Level}
#' \item{Cond}{Conductivity}
#' \item{Tur}{Turbidity}
#' \item{label_Level}{Whether individual data points are anomalous or not in the level series. 1 - outlier, 0 - typical}
#' \item{label_Cond}{Whether individual data points are anomalous or not in the conductivity series. 1 - outlier, 0 - typical}
#' \item{label_Tur}{Whether individual data points are anomalous or not in the tubidity series. 1 - outlier, 0 - typical}
#' \item{type_Level}{Type of the anomaly in the level series.
#' A - sudden large spikes, B - low variability including persistent values,
#' C- constant offsets, D - sudden shifts, E - high variability,
#' F - impossible values, G - out-of-sensor-range values, H - drift,
#' I- clusters of spikes, J - sudden small spikes, K - missing values
#'and L - other untrustworthy (not described by types A-K)  }
#' \item{type_Cond}{Type of the anomaly in the conductivity series.
#' A - sudden large spikes, B - low variability including persistent values,
#' C- constant offsets, D - sudden shifts, E - high variability,
#' F - impossible values, G - out-of-sensor-range values, H - drift,
#' I- clusters of spikes, J - sudden small spikes, K - missing values
#'and L - other untrustworthy (not described by types A-K)}
#' \item{type_Tur}{Type of the anomaly in the Turbidity series.
#' A - sudden large spikes, B - low variability including persistent values,
#' C- constant offsets, D - sudden shifts, E - high variability,
#' F - impossible values, G - out-of-sensor-range values, H - drift,
#' I- clusters of spikes, J - sudden small spikes, K - missing values
#'and L - other untrustworthy (not described by types A-K)}
#' }
#' @references {Leigh, C, O Alsibai, RJ Hyndman, S Kandanaarachchi, OC King,
#'  JM McGree, C Neelamraju, J Strauss, PD Talagala, RD Turner, K Mengersen &
#'  EE Peterson (2019). A framework for automated anomaly detection in high
#'  frequency water-quality data from in situ sensors. Science of the Total
#'  Environment 664, 885–898.}
"data_sandy_anom"


#' Water Quality Sensor data - Pioneer
#'
#' A multivariate dataset containing the variables obtained using water quality
#' sensors from Pioneer. The characteristics of the different types of anomalies
#' are presented in detail in Leigh, et al. (2019).  The anomaly types can be
#' further grouped into three general classes. Class 1 included anomalies described by a
#' sudden change in value from the previous observation (types A, D, I, and J).
#' Class 2 included those anomaly types that should be detectable by simple,
#' hard-coded classification rules, such as measurements outside the detectable
#' range of the sensor (types F, G and K).
#' Class 3 anomalies may require user intervention post hoc (i.e. after data
#' collection rather than in real time) to confirm observations as anomalous
#' or otherwise in combination with automated detection (types B, C, E, H and L).
#'
#' @format A data frame with 6303 rows and 10 variables:
#' \describe{
#' \item{Timestamp }{Time Stamps}
#' \item{Level }{Level}
#' \item{Cond}{Conductivity}
#' \item{Tur}{Turbidity}
#' \item{label_Level}{Whether individual data points are anomalous or not in the level series. 1 - outlier, 0 - typical}
#' \item{label_Cond}{Whether individual data points are anomalous or not in the conductivity series. 1 - outlier, 0 - typical}
#' \item{label_Tur}{Whether individual data points are anomalous or not in the tubidity series. 1 - outlier, 0 - typical}
#' \item{type_Level}{Type of the anomaly in the level series.
#' A - sudden large spikes, B - low variability including persistent values,
#' C- constant offsets, D - sudden shifts, E - high variability,
#' F - impossible values, G - out-of-sensor-range values, H - drift,
#' I- clusters of spikes, J - sudden small spikes, K - missing values
#'and L - other untrustworthy (not described by types A-K)  }
#' \item{type_Cond}{Type of the anomaly in the conductivity series.
#' A - sudden large spikes, B - low variability including persistent values,
#' C- constant offsets, D - sudden shifts, E - high variability,
#' F - impossible values, G - out-of-sensor-range values, H - drift,
#' I- clusters of spikes, J - sudden small spikes, K - missing values
#'and L - other untrustworthy (not described by types A-K)}
#' \item{type_Tur}{Type of the anomaly in the Turbidity series.
#' A - sudden large spikes, B - low variability including persistent values,
#' C- constant offsets, D - sudden shifts, E - high variability,
#' F - impossible values, G - out-of-sensor-range values, H - drift,
#' I- clusters of spikes, J - sudden small spikes, K - missing values
#'and L - other untrustworthy (not described by types A-K)}
#' }
#' @references {Leigh, C, O Alsibai, RJ Hyndman, S Kandanaarachchi, OC King,
#'  JM McGree, C Neelamraju, J Strauss, PD Talagala, RD Turner, K Mengersen &
#'  EE Peterson (2019). A framework for automated anomaly detection in high
#'  frequency water-quality data from in situ sensors. Science of the Total
#'  Environment 664, 885–898.}
"data_pioneer_anom"



