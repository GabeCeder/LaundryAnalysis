
navbarPage("Laundry Analysis",

  tabPanel("Number of Washers Available",
           
    # use fluid Bootstrap layout
    fluidPage(    
      
      # give page title
      titlePanel(
        h1("Number of Washers Available"),
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
  ),
  
  tabPanel("Number of Dryers Available",
           
           # use fluid Bootstrap layout
           fluidPage(    
             
             # give page title
             titlePanel(
               h1("Number of Dryers Available"),
               windowTitle = "LaundryView Data"
             ),
             
             # produce sidebar
             sidebarLayout(      
               
               sidebarPanel(
                 selectInput("day2", "Day of Week:", c("Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday")),
                 selectInput("location2", "Location:", vars),
                 hr(),
                 helpText("LaundryView Data, March-April 2018")
               ),
               
               # main panel for plot
               mainPanel(
                 
                 # produce tabs and output
                 tabsetPanel(type = "tabs",
                             tabPanel("Plot", plotlyOutput("plot1")),
                             tabPanel("Summary", verbatimTextOutput("summary1")))
               ) # end tabsetPanel
             ) # end mainPanel
             
           ) # end fluidPage
  ),

  tabPanel("Probability of Machines Available",
           fluidPage(
             
             titlePanel(
               h1("Probability of Machines Available"),
               windowTitle = "LaundryView Data"
             ),
             
             sidebarLayout(
               
               sidebarPanel(
                 selectInput("day1", "Day of Week:", c("Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday")),
                 selectInput("location1", "Location:", vars),
                 selectInput("numMachines", "Number of Open Machines Desired", c(1,2,3,4,5)),
                 hr(),
                 helpText("LaundryView Data, March-April 2018")
               ),
             
               mainPanel(
                  tabsetPanel(type = "tabs",
                             tabPanel("Washing Machines", plotlyOutput("washers")),
                             tabPanel("Dryer Machines", plotlyOutput("dryers"))
                             ) # end tabsetPanel
               ) # end mainPanel
             ) # end sidebarLayout
          ) # end fluidPage
    ) # end tabPanel
) # end navbarPage


