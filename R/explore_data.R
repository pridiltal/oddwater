#' Run Shiny Applications
#'
#' @description Launch Shiny application
#' @importFrom shiny runApp
#' @export
explore_data <- function() {
  appDir <- system.file("Shiny-app", "Oddwater_app", package = "oddwater")
  if (appDir == "") {
    stop("Could not find example directory. Try re-installing `oddwater`.", call. = FALSE)
  }

  shiny::runApp(appDir, display.mode = "normal")
}
