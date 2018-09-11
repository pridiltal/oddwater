#' Compute performance metrics
#'
#' @description Computes various measure to evaluate the performance of an algorithm
#' @param y_truth A character vector containing the gorund truth
#' @param y_output a character vector containing the predicted labels from the algorithm
#' @param pos_label A character string. Label used to indicate the outliers in the original dataframe.
#' @param neg_label A character string. Label used to indicate the typical values in the original dataframe.
#' @param print_out If TRUE, output will be printed to console.
#' @return  A list with the following elements:
#' \item{TN}{True negatives}
#' \item{FN}{False negatives}
#' \item{FP}{False positives}
#' \item{TP}{True positives}
#' \item{Accuracy}{Accuracy}
#' \item{Error_Rate}{Error Rate}
#' \item{Sensitivity}{Sensitivity}
#' \item{Specificity}{Specificity}
#' \item{Precision}{Precision}
#' \item{Recall}{Recall}
#' \item{F_Measure}{F Measure}
#' \item{Optimised_Precision}{Optimised Precision}
#' \item{PPV}{Positive Predictive Value}
#' \item{NPV}{Negative Predictive Value}
#' @export
#' @author Priyanga Dilini Talagala
#' @examples
#' true_labels <- c("out", "out", "normal", "out", "normal", "normal",
#'                  "normal", "normal", "normal", "normal")
#' output <- c("out", "normal", "normal", "normal", "out", "out",
#'             "normal", "normal", "normal", "normal")
#' out<- calc_performance_metrics(y_truth = true_labels, y_output = output,
#'                               pos_label = "out", neg_label = "normal")
#'
calc_performance_metrics <- function(y_truth, y_output, pos_label, neg_label, print_out = TRUE) {
  # Recoding Data
  oldvalues <- c(pos_label, neg_label)
  newvalues <- c(1, 0)
  y_truth <- newvalues[ match(y_truth, oldvalues)]
  y_output <- newvalues[ match(y_output, oldvalues)]
  data <- data.frame(y_truth, y_output)

  # Get confusion matrix
  TN <- sum(data$y_truth == 0 & data$y_output == 0)
  FN <- sum(data$y_truth == 1 & data$y_output == 0)
  FP <- sum(data$y_truth == 0 & data$y_output == 1)
  TP <- sum(data$y_truth == 1 & data$y_output == 1)
  acc <- (TP + TN) / (TP + FP + TN + FN)
  err <- (FP + FN) / (TP + FP + TN + FN)
  sn <- TP / (TP + FN)
  sp <- TN / (TN + FP)
  p <- TP / (TP + FP)
  r <- TP / (TP + TN)
  FM <- (2 * p * r) / (p + r)
  GM <- sqrt(TP * TN)

  Nn <- (FP + TN) / (TP + FP + TN + FN)
  Np <- (TP + FN) / (TP + FP + TN + FN)
  P <- (sp * Nn + sn * Np)
  RI <- (abs(sp - sn) / (sp + sn))
  OP <- P - RI

  PPV <- TP / (TP + FP)
  NPV <- TN / (TN + FN)

  pm <- list(TN, FN, FP, TP, acc, err, sn, sp, p, r, FM, GM, OP, PPV, NPV)
  names(pm) <- c(
    "TN", "FN", "FP", "TP", "Accuracy", "Error_Rate", "Sensitivity",
    "Specificity", "Precision", "Recall", "F_Measure", "Geometric_mean",
    "Optimised_Precision", "PPV", "NPV"
  )

  if (print_out) {
    print(data.frame(Value = round(unlist(pm), 4)))
  }

  return(pm)
}

#' Compute mean squared error
#'
#' @description Compute mean squared error
#' @param y_truth A numeric vector containing the gorund truth
#' @param y_pred A numeric vector containing the estimated values
#' @export
#' @author Priyanga Dilini Talagala
#'
calc_MSE <- function(y_truth, y_pred) {
  MSE <- mean((y_truth - y_pred)^2)
  return(MSE)
}
