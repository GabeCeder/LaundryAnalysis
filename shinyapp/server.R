
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
  
  # reactive function to determine min value for y-axis scale
  r1 <- reactive({
    
    d <- switch(input$day,
                "Sunday" = 0,
                "Monday" = 1,
                "Tuesday" = 2,
                "Wednesday" = 3,
                "Thursday" = 4,
                "Friday" = 5,
                "Saturday" = 6)
    
    dist <- subset(full, day == d & location == input$location)
    
    # return min avg_avail times 0.8
    min(dist[,3]) * 0.8
    
  })
  
  # reactive function to determine max value for y-axis scale
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
    
    # return max avg_avail times 1.2
    max(dist[,3]) * 1.2
    
  })
  
  r3 <- reactive({
    d <- switch(input$day1,
                "Sunday" = 0,
                "Monday" = 1,
                "Tuesday" = 2,
                "Wednesday" = 3,
                "Thursday" = 4,
                "Friday" = 5,
                "Saturday" = 6)
    
    dat <- subset(full_data, day == d & location == input$location1) %>% 
      group_by(time) %>% 
      summarise(total = n())
    
    e <- subset(full_data, day == d & location == input$location1) %>% 
      mutate(at_least_one_w = ifelse(avail_wash >= input$numMachines, 1, 0)) %>% 
      group_by(time, at_least_one_w) %>% 
      summarise(at_least_1_w = n()) %>% 
      filter(at_least_one_w == 1) %>% 
      ungroup() %>% 
      select(at_least_1_w)
    
    bound_data <- cbind(dat, e) 
    
    bound_data <- bound_data %>% 
      mutate(proportion_w = at_least_1_w/total) %>% 
      mutate(w = case_when(proportion_w == 1 ~ 0.99, TRUE ~ proportion_w))
      
    q <- ggplot(bound_data, aes(x = time, y = w, fill = w)) +
      geom_col() + 
      labs(title = "Likelihood of At Least 1 Washing Machine Being Open", y = "Likelihood", x = "Time")
    
    ggplotly(q, height = 700)
    
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
      coord_cartesian(ylim = c(r1(), r2()))
    
    # produce plot
    ggplotly(p, height = 700)
    
  })
  
  output$washers <- renderPlotly({
    r3()
  })
  
  # produce summary
  output$summary <- renderPrint({
    summary(r())
  })
  
}
