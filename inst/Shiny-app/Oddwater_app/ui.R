#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(plotly)
library(lubridate)
library(ggplot2)
library(tidyverse)
library(tidyr)
library(pcaPP)
library(oddwater)

data("data_sandy_anom")
# Define UI for application that draws a histogram
shinyUI(fluidPage(
  tabsetPanel(
    tabPanel("Individual Time Series",
      fluid = TRUE,
      sidebarLayout(
        sidebarPanel(
          selectInput("site",
            label = "Select Site:",
            choices = c("Sandy Creek", "Pioneer"),
            selected = "Sandy Creek"
          ),
          selectInput("Parameter",
            label = "Select Parameter:",
            choices = colnames(data_sandy_anom[, 2:4]),
            selected = "Tur"
          ),
          checkboxInput("outliers", "Mark Outliers", FALSE),
          width = 3
        ),

        # Show a plot of the generated distribution
        mainPanel(
          plotlyOutput("individual", width = "110%", height = "100%")
        )
      )
    ),

    tabPanel("Multivariate TS plots",
      fluid = TRUE,
      sidebarLayout(
        sidebarPanel(
          selectInput("site",
            label = "Select Site:",
            choices = c("Sandy Creek", "Pioneer"),
            selected = "Sandy Creek"
          ),
          checkboxGroupInput(
            "variables", "Variables to show:",
            colnames(data_sandy_anom[, 2:4])
          ),
          width = 2
        ),
        mainPanel(
          plotlyOutput("multi", width = "110%", height = "140%")
        )
      )
    )
  )
))
