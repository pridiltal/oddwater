#' Apply different transformations to the original series
#'
#' @description This function apply different transformations to the original variables.
#' This data preprocessing step was incorporated with the aim of highlighting  different
#' types of anomalies such as sudden isolated spikes, sudden isolated drops, sudden shifts,
#' impossible values (negative values) and out of range values etc
#' @param data A dataframe. This dataframe contains a seperate column for Timestamp, in addition
#' to the variables that need to be transformed
#' @param time_col A quoted string to specify the column name of the timestamp
#' @param time_bound A positive constant. This is to reduce the effect coming from too
#' small time gaps when calculating derivatives.
#' @param regular Regular time interval (TRUE) or irregular (FALSE)
#' @return A tsibble object with the original and the transformed series
#' @author Priyanga Dilini Talagala
#' @export
#' @importFrom lubridate dmy_hm is.Date
#' @importFrom tsibble as_tsibble
#' @examples
#' data <- data_sandy_anom[,c("Timestamp", "Cond", "Tur", "Level")]
#' data <- tidyr::drop_na(data)
#' trans_data <- oddwater::transform_data(data)
transform_data <- function(data,  time_bound = 90, regular = FALSE, time_col = "Timestamp")
{
  if(!(lubridate::is.Date(data[[time_col]]) | lubridate::is.POSIXct(data[[time_col]]) ))
  { data[time_col] <- lubridate::dmy_hm((data[[time_col]]) )}

  n <- nrow(data)
  data_var <- as.matrix(data[ , !(names(data) %in% time_col)])

  # apply log transformation
  log_series <- log(data_var)
  colnames(log_series) <- paste("log_", colnames(log_series), sep = "")
  data <- cbind(data, log_series)

  # take the first difference of the log series
  diff_log_series <- rbind( rep(NA, ncol(data_var)), diff(log_series))
  colnames(diff_log_series) <- paste("diff_", colnames(diff_log_series), sep = "")
  data <- cbind(data, diff_log_series)

  # take the derivative of the log series (time bounded)
  time <- as.numeric(data$Timestamp[2:n] - data$Timestamp[1:(n-1)])
  time_bound <- ifelse( time >= time_bound, time, time_bound) # to reduce the effect coming from the too small time gaps
  der_log_bounded <- rbind( rep(NA, ncol(data_var)), diff_log_series[2:n, ] / as.numeric(time_bound))
  colnames(der_log_bounded) <- paste("der_log_bound_", colnames(data_var), sep = "")
  data <- cbind(data, der_log_bounded)
  time <- c(NA, time)

  # take non linear transformation - one sided (negative) log derivatives (time bounded)
  neg_der_log_bounded <- ifelse(der_log_bounded <= 0, der_log_bounded, 0)
  colnames(neg_der_log_bounded) <- paste("neg_der_log_bound_", colnames(data_var), sep = "")
  neg_der_log_bounded <- rbind( rep(NA, ncol(data_var)), neg_der_log_bounded[-1,])
  data <- cbind(data, neg_der_log_bounded, time)

  # take non linear transformation - one sided (positive) log derivatives (time bounded)
  pos_der_log_bounded <- ifelse(der_log_bounded >= 0, der_log_bounded, 0)
  colnames(pos_der_log_bounded) <- paste("pos_der_log_bound_", colnames(data_var), sep = "")
  pos_der_log_bounded <- rbind(rep(NA, ncol(data_var)), pos_der_log_bounded[-1,])
  data <- cbind(data, pos_der_log_bounded)

  # rate of change
  rc_series <- rbind( rep(NA, ncol(data_var)), (data_var[2:n,] - data_var[1:(n-1),]) / data_var[1:(n-1),])
  colnames(rc_series) <- paste("rc_", colnames(data_var), sep = "")
  data <- cbind(data, rc_series)

  # Ratio
  ratio_series <- rbind( rep(NA, ncol(data_var)), data_var[2:n,] / data_var[1:(n-1),])
  colnames(ratio_series) <- paste("ratio_", colnames(data_var), sep = "")
  data <- cbind(data, ratio_series)

  # Relative difference (log)
  relative_series <- rbind( rep(NA, ncol(data_var)), (log_series[2:(n-1),] - (1/2)*(log_series[1:(n-2),] +log_series[3:n,]  )),
                            rep(NA, ncol(data_var)))
  colnames(relative_series) <- paste("rdifflog_", colnames(data_var), sep = "")
  data <- cbind(data, relative_series)

  # Relative difference (original)
  relative_series_o <- rbind( rep(NA, ncol(data_var)), (data_var[2:(n-1),] - (1/2)*(data_var[1:(n-2),] +data_var[3:n,]  )),
                            rep(NA, ncol(data_var)))
  colnames(relative_series_o) <- paste("rdiff_", colnames(data_var), sep = "")
  data <- cbind(data, relative_series_o)

  data <- tsibble::as_tsibble(data, index = time_col , regular = regular)

  return(data)
}
