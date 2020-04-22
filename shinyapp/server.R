
function(input, output) {
  
  # reactive function to produce summary stats
  r <- reactive({
    
    # switch day of week to numeric value originally assigned in data
    d <- switch(input$day,
                "Sunday" = 0,
                "Monday" = 1,
                "Tuesday" = 2,
                "Wednesday" = 3,
                "Thursday" = 4,
                "Friday" = 5,
                "Saturday" = 6)
    
    # subset full.Rdata on day of week and location selected
    dist <- subset(full, day == d & location == input$location)
    
    # return third column (avg_avail)
    dist[,3]
    
  })
  
  # reactive function to determine value for adjusting y-axis scale
  r2 <- reactive({
    
    d <- switch(input$day,
                "Sunday" = 0,
                "Monday" = 1,
                "Tuesday" = 2,
                "Wednesday" = 3,
                "Thursday" = 4,
                "Friday" = 5,
                "Saturday" = 6)
    
    dist <- subset(full, day == d & location == input$location)
    
    # return max avg_avail times 1.5
    max(dist[,3]) * 1.5
    
  })

  # produce plot
  output$plot <- renderPlotly({
    
    d <- switch(input$day,
                "Sunday" = 0,
                "Monday" = 1,
                "Tuesday" = 2,
                "Wednesday" = 3,
                "Thursday" = 4,
                "Friday" = 5,
                "Saturday" = 6)
    
    dist <- subset(full, day == d & location == input$location)
    
    # characteristics for plot, center bars, label axes, set y-axis limits
    p <- ggplot(dist, aes(x = time, y = avg_avail, fill = avg_avail)) +
      geom_col(position = "dodge") +
      labs(x = "Hour", y = "Average Number of Available Washers") +
      ylim(NA, r2())
    
    # produce plot
    ggplotly(p, height = 700)
  
  })
  
  # produce summary
  output$summary <- renderPrint({
    summary(r())
  })
  
}
