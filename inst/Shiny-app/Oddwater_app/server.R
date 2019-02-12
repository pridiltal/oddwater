#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  output$distPlot <- renderPlot({

    # generate bins based on input$bins from ui.R
    x <- faithful[, 2]
    bins <- seq(min(x), max(x), length.out = input$bins + 1)

    # draw the histogram with the specified number of bins
    hist(x, breaks = bins, col = "darkgray", border = "white")
  })

  output$individual <- renderPlotly({
    if (input$site == "Sandy Creek") {
      data <- data_sandy_anom
    }
    else {
      data <- data_pioneer_anom
    }

   # data <- input$site
    data$Timestamp <- lubridate::dmy_hm(data$Timestamp)
    selected <- data[, c("Timestamp", input$Parameter)] %>% drop_na(input$Parameter)

    p <- ggplot(selected, aes(x = selected[, 1], y = selected[, 2])) +
      # geom_line()+
      geom_point(data = selected, aes(x = selected[, 1], y = selected[, 2]), alpha = 1) +
      xlab("Time") +
      ylab(input$Parameter)

    if (input$outliers) {
      col <- paste("label_", input$Parameter, sep = "")

      selected <- data[, c("Timestamp", input$Parameter, col)] %>% drop_na()

      selected[, 3] <- as.factor(selected[, 3])
      levels(selected[, 3]) <- c("typical", "outlier")
      p <- p +
        geom_point(data = selected, aes(x = selected[, 1], y = selected[, 2], color = selected[, 3])) +
        scale_color_manual(values = c("outlier" = "red", "typical" = "black")) +
        theme(legend.title = element_blank())
    }


    ggplotly(p)
  })





  output$multi <- renderPlotly({

    if (input$site == "Sandy Creek") {
      data <- data_sandy_anom
    }
    else {
      data <- data_pioneer_anom
    }

    data$Timestamp <- lubridate::dmy_hm(data$Timestamp)


    if(!is.null(input$variables)){
      selected <- data[, c("Timestamp", input$variables)] %>% drop_na()

      plot_data <- gather(selected, Parameter, Value, -Timestamp)
      plot_data$Parameter <- factor(plot_data$Parameter, levels = colnames(selected[,-1]))

      p <- ggplot(plot_data, aes(x = Timestamp, y = Value, label1 = Timestamp)) +
        geom_point(size = 1, alpha = 0.5)+
        geom_line() +
        facet_grid(Parameter ~ ., scales = "free") +
        xlab("Time") +
        scale_y_continuous(breaks = scales::pretty_breaks(n = 4))+
        ylab("")
      ggplotly(p)


      }
  })
})
