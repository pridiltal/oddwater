globalVariables(c("Parameter", "Timestamp", "Value", "type"))

#' Plot Multivariate time series
#'
#' @description Plot multivariate time series and mark anomalous point in red colour and
#' neighbouring points in green colour
#' @param data A dataframe. "Timestamp" column give the timestamps and "type" column gives
#' types of the data points (outlier, neighbour, typical).
#' @param title A character string. This sis the main title of the plot
#' @return A graphical representation of the multivariate time series
#' @export
#' @import ggplot2
#' @importFrom tidyr gather
#' @importFrom scales pretty_breaks
#' @author Priyanga Dilini Talagala
plot_series<- function(data, title)
{
  plot_data <- tidyr::gather(data, Parameter, Value, -c(Timestamp, type))

  remove <- c("Timestamp", "type")
  var <- colnames(data)

  plot_data$Parameter <- factor(plot_data$Parameter, levels = var[!var %in% remove])
  p1 <- ggplot2::ggplot(plot_data, aes(x = Timestamp, y = Value, label = Timestamp)) +
    geom_line()+
    geom_point(data= plot_data, aes(x = Timestamp, y = Value, colour= type, size= type),
               alpha = 1)+
    scale_colour_manual(name="Type", values = c("outlier"="red", "typical"="black",
                                                "neighbour" = "green"))+
    scale_size_manual (values= c("outlier" = 4, "typical" = 1, "neighbour" =4)) +
    facet_grid(Parameter ~ ., scales = "free") +
    xlab("Time") +
    scale_y_continuous(breaks = scales::pretty_breaks(n = 4))+
    ggtitle(title)
  print(p1)
}


#' Make a matrix of plots with a given data set
#'
#' @description provide a matrix plot and mark anomalous point in red colour and
#' neighbouring points in green colour
#' @param data A dataframe. "Timestamp" column give the timestamps and "type" column gives
#' types of the data points (outlier, neighbour, typical).
#' @return A graphical representation of the matrix plot
#' @export
#' @import ggplot2
#' @importFrom GGally ggpairs
#' @author Priyanga Dilini Talagala
#'
plot_pairs<- function(data)
{
  remove <- c("Timestamp", "type")
  var <- colnames(data)
  p2 <- GGally::ggpairs(data, columns = which(!var %in% remove),
                        ggplot2::aes(colour= type, shape= type, label = Timestamp ))
  print(p2)
}


#' Plot the time gap
#'
#' @description Provide graphical representation of time gap. Useful when dealing
#' with irregular time series
#' @param data A dataframe of one or more than two colums."Timestamp" column give the timestamps.
#' @return A graphical representation of the time gaps
#' @export
#' @import ggplot2
#' @importFrom lubridate ymd_hms
#' @author Priyanga Dilini Talagala
#'
plot_time_gap<- function(data)
{
  n <- nrow(data)
  time <- c(NA, as.numeric(lubridate::ymd_hms(data$Timestamp[2:n]) - lubridate::ymd_hms(data$Timestamp[1:(n-1)])))
  time_gap_data <- data.frame(Timestamp = data$Timestamp , time)
  p <- ggplot(time_gap_data, aes(x= Timestamp, y= time))+
      geom_line()+
      ylab("time (minutes)")
  print(p)
}

