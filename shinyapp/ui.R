
# use fluid Bootstrap layout
fluidPage(    
  
  # give page title
  titlePanel(
    h1("Laundry: Washers Available"),
    windowTitle = "LaundryView Data"
  ),
  
  # produce sidebar
  sidebarLayout(      
    
    sidebarPanel(
      selectInput("day", "Day of Week:", c("Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday")),
      selectInput("location", "Location:", vars),
      hr(),
      helpText("LaundryView Data, March-April 2018")
  ),
    
  # main panel for plot
  mainPanel(

      # produce tabs and output
      tabsetPanel(type = "tabs",
                  tabPanel("Plot", plotlyOutput("plot")),
                  tabPanel("Summary", verbatimTextOutput("summary")))
      ) # end tabsetPanel
  ) # end mainPanel
  
) # end fluidPage