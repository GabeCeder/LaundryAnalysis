
function(input, output) {
  
  # reactive function to produce summary stats (washers)
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
  
  # reactive function to determine min value for y-axis scale (washers)
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
  
  # reactive function to determine max value for y-axis scale (washers)
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
  
  # probability graph (washers)
  r3 <- reactive({
    d <- switch(input$day1,
                "Sunday" = 0,
                "Monday" = 1,
                "Tuesday" = 2,
                "Wednesday" = 3,
                "Thursday" = 4,
                "Friday" = 5,
                "Saturday" = 6)
    
    num <- as.character(input$numMachines)
    
    t <- paste("Likelihood of at Least",num, "Machine(s) Open" )
    
    dat <- subset(full_data, day == d & location == input$location1) %>% 
      group_by(time) %>% 
      summarise(total = n())
    
    e <- subset(full_data, day == d & location == input$location1) %>% 
      filter(avail_wash >= input$numMachines) %>% 
      group_by(time) %>% 
      summarise(prop = n())
    
    bound_data <- inner_join(dat,e) %>% 
       mutate(proportion_w = prop/total) %>% 
       mutate(w = case_when(
         proportion_w == 1 ~ 0.99,
         TRUE ~ proportion_w
       ))
      
     q <- ggplot(bound_data, aes(x = time, y = w, fill = w)) +
       geom_col() + 
       labs(title = t, y = "Likelihood", x = "Time") +
       theme(
         legend.position = "none"
       )
     
     ggplotly(q, height = 600)

  })
  
  # probabiliy graph (dryers)
  r4 <- reactive({
    d <- switch(input$day1,
                "Sunday" = 0,
                "Monday" = 1,
                "Tuesday" = 2,
                "Wednesday" = 3,
                "Thursday" = 4,
                "Friday" = 5,
                "Saturday" = 6)
    
    num <- as.character(input$numMachines)
    
    t <- paste("Likelihood of at Least",num, "Machine(s) Open" )
    
    dat <- subset(full_data, day == d & location == input$location1) %>% 
      group_by(time) %>% 
      summarise(total = n())
    
    e <- subset(full_data, day == d & location == input$location1) %>% 
      filter(avail_dryers >= input$numMachines) %>% 
      group_by(time) %>% 
      summarise(prop = n())
    
    bound_data <- inner_join(dat,e) %>% 
      mutate(proportion_d = prop/total) %>% 
      mutate(dr = case_when(
        proportion_d == 1 ~ 0.99,
        TRUE ~ proportion_d
      ))
    
    q <- ggplot(bound_data, aes(x = time, y = dr, fill = dr)) +
      geom_col() + 
      labs(title = t, y = "Likelihood", x = "Time") +
      theme(
        legend.position = "none"
      )
    
    ggplotly(q, height = 600)
    
  })
  
  # reactive function to produce summary stats (dryers)
  r5 <- reactive({
    
    # switch day of week to numeric value originally assigned in data
    d <- switch(input$day,
                "Sunday" = 0,
                "Monday" = 1,
                "Tuesday" = 2,
                "Wednesday" = 3,
                "Thursday" = 4,
                "Friday" = 5,
                "Saturday" = 6)
    
    # subset full1.Rdata on day of week and location selected
    dist <- subset(full1, day == d & location == input$location)
    
    # return third column (avg_avail)
    dist[,3]
    
  })
  
  # reactive function to determine min value for y-axis scale (washers)
  r6 <- reactive({
    
    d <- switch(input$day,
                "Sunday" = 0,
                "Monday" = 1,
                "Tuesday" = 2,
                "Wednesday" = 3,
                "Thursday" = 4,
                "Friday" = 5,
                "Saturday" = 6)
    
    dist <- subset(full1, day == d & location == input$location)
    
    # return min avg_avail times 0.8
    min(dist[,3]) * 0.8
    
  })
  
  # reactive function to determine max value for y-axis scale (washers)
  r7 <- reactive({
    
    d <- switch(input$day,
                "Sunday" = 0,
                "Monday" = 1,
                "Tuesday" = 2,
                "Wednesday" = 3,
                "Thursday" = 4,
                "Friday" = 5,
                "Saturday" = 6)
    
    dist <- subset(full1, day == d & location == input$location)
    
    # return max avg_avail times 1.2
    max(dist[,3]) * 1.2
    
  })
  
  # produce plot (washers)
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
    ggplotly(p, height = 600)
    
  })
  
  # produce plot (dryers)
  output$plot1 <- renderPlotly({
    
    d <- switch(input$day,
                "Sunday" = 0,
                "Monday" = 1,
                "Tuesday" = 2,
                "Wednesday" = 3,
                "Thursday" = 4,
                "Friday" = 5,
                "Saturday" = 6)
    
    dist <- subset(full1, day == d & location == input$location)
    
    # characteristics for plot, center bars, label axes, set y-axis limits
    p <- ggplot(dist, aes(x = time, y = avg_avail, fill = avg_avail)) +
      geom_col(position = "dodge") +
      labs(x = "Hour", y = "Average Number of Available Dryers") +
      coord_cartesian(ylim = c(r6(), r7()))
    
    # produce plot
    ggplotly(p, height = 600)
    
  })
  
  output$washers <- renderPlotly({
    r3()
  })
  
  output$dryers <- renderPlotly({
    r4()
  })
  
  # produce summary (washers)
  output$summary <- renderPrint({
    summary(r())
  })
  
  # produce summary (dryers)
  output$summary1 <- renderPrint({
    summary(r5())
  })
  
}
