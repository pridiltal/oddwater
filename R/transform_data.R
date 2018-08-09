#' Apply different transformations to the original series
#'
#' @description This function apply different transformations to the original variables.
#' This data preprocessing step was incorporated with the aim of highlighting  different
#' types of anomalies such as sudden isolated spikes, sudden isolated drops, sudden shifts,
#' impossible values (negative values) and out of range values etc
#' @param data A dataframe. This dataframe contains two columns: Timestamp, type in addition
#' to the variables that need to be transformed
#' @param time_bound A positive constant. This is to reduce the effect coming from too
#' small time gaps when calculating derivatives.
#' @return a dataframe with the original and transformed series
#' @author Priyanga Dilini Talagala
#' @export
#' @importFrom lubridate ymd_hms
transform_data <- function(data,  time_bound = 90)
{
  n <- nrow(data)
  remove <- c("Timestamp", "type")
  var <- colnames(data)
  data_var <- as.matrix(data[ , var[!var %in% remove]])

  # apply log transformation
  log_series <- log(data_var)
  colnames(log_series) <- paste("log_", colnames(log_series), sep = "")
  data <- cbind(data, log_series)

  # take the first difference of the log series
  diff_log_series <- rbind( rep(NA, 3), diff(log_series))
  colnames(diff_log_series) <- paste("diff_", colnames(diff_log_series), sep = "")
  data <- cbind(data, diff_log_series)

  # take the derivative of the log series (time bounded)
  time <- as.numeric(lubridate::ymd_hms(data$Timestamp[2:n]) - lubridate::ymd_hms(data$Timestamp[1:(n-1)]))
  time_bound <- ifelse( time >= time_bound, time, time_bound) # to reduce the effect coming from the too small time gaps
  der_log_bounded <- rbind( rep(NA, 3), diff_log_series[2:n, ] / as.numeric(time_bound))
  colnames(der_log_bounded) <- paste("der_log_bound_", colnames(data_var), sep = "")
  data <- cbind(data, der_log_bounded)
  time <- c(NA, time)

  # take non linear transformation - one sided log derivatives (time bounded)
  neg_der_log_bounded_turb <- ifelse(der_log_bounded[, "der_log_bound_Lsonde_Turb_NTU" ] <= 0,
                                     der_log_bounded[, "der_log_bound_Lsonde_Turb_NTU" ], 0)
  pos_der_log_bounded_cond <- ifelse(der_log_bounded[, "der_log_bound_Lsonde_Cond_uscm"] >= 0,
                                     der_log_bounded[, "der_log_bound_Lsonde_Cond_uscm"], 0)
  neg_der_log_bounded_level <- ifelse(der_log_bounded[, "der_log_bound_Lsonde_Level_m"  ] <= 0,
                                      der_log_bounded[, "der_log_bound_Lsonde_Level_m"  ], 0)
  data <- cbind(data, neg_der_log_bounded_turb, pos_der_log_bounded_cond,
                neg_der_log_bounded_level, time)

  return(data)
}
