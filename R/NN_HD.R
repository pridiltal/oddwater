#' NN-HD algorithm
#'
#' @description This algorithm is inspired by the HDoutliers algorithm
#'  which is an unsupervised outlier
#'  detection algorithm that searches for outliers in high dimensional
#'  data assuming there is a large distance between outliers and the
#'  typical data.  Nearest neighbor distances between
#'  points are used to detect outliers. However, variables with large
#'  variance can bring disproportional influence on Euclidean distance
#' calculation. Therefore, the columns of the data sets are first
#' normalized such that the data are bounded by the unit hyper-cube.
#' The nearest neighbor distances are then calculated for each
#' observation.  In contrast to the implementation of HDoutliers
#' algorithm available in the \code{\link[HDoutliers]{HDoutliers}}
#' package, NN_HD now generates outlier scores instead of labels for
#' each observation.
#' @param dataset A multivariate dataset containing numerical variables
#' @export
#' @importFrom dbscan kNN
#' @author Priyanga Dilini Talagala
#' @references
#' Wilkinson, L. (2016). Visualizing outliers. \url{https://www.cs.uic.edu/~wilkinson/Publications/outliers.pdf}
#'
NN_HD <- function(dataset) {

  dataset <- as.matrix(dataset)

  if (!is.numeric(dataset)) {
    stop("dataset input is not numeric")
  }

  nn_hd <- dbscan::kNN(dataset, 1)$dist
  return(nn_hd)
}
