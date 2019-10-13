
ui <- dashboardPage( skin = "yellow",
    #Header ####
    dashboardHeader(
      title = "Border Entry to US", titleWidth = 300,
      tags$li(a(href="https://github.com/bee5633/ShinyProject", 
                img(src='github.png', title="Github Repository",height="19px")),class="dropdown")),
    #Sidebar ####
    dashboardSidebar(
      sidebarUserPanel(name = " Bee Kim", image = "bee.jpg"),
      sidebarMenu(
        menuItem("Introduction", tabName ="aboutdata",icon = icon("info")),
        menuItem("Border Ports", tabName = "borderport", icon=icon("map")),
        menuItem("Modes of Transportation", tabName="measure", icon = icon("car-side")),
        menuItem("States",tabName="chart2", icon=icon("flag")),
        menuItem("Trend by Year",tabName= "chart3",icon = icon("chart-line")),
        menuItem("Trend by Month", tabName= "chart4", icon=icon("chart-line")),
        menuItem("Data",tabName = "data",icon = icon("database")),
        menuItem("About Me", tabName="me", icon=icon("user-alt")))
    ),
    
    #menuSubItem("Border Map",tabName = "map", icon=icon("map")),
    #menuSubItem("By Border", tabName = "chart1")),
    
    
    
    #Body1 : About the Data ####
    dashboardBody(
      tabItems(
        tabItem(tabName="aboutdata",
                fluidPage(
                  h1("About Data"),
                  h5("This dataset is about Border Entry.")
                  )),
        
        
    #Body2 : Border Ports ####
        tabItem(tabName="borderport",
                fluidRow(
                  tabsetPanel(
                    tabPanel("Map of US Border Ports", 
                             fluidPage(
                               h1("Location of Border Ports"),
                               box(leafletOutput("borderMap"), height= 1000, width=1000)
                             )),
                    tabPanel("Number of Border Ports", 
                             fluidPage(
                               h1("Border Information"),
                               h3("Total Number of Border Ports: 116"),
                               box(title="Number of Border Ports in Each Border",
                                   plotOutput("plot1")),
                               infoBox("Canada", 89, icon= icon("hand-point-up")),
                               infoBox("Mexico", 27, icon= icon("hand-point-down")))),
                    tabPanel("Total Incoming Values",
                             fluidPage(
                               h1("Total Incoming by Border"),
                               box(title="Total Incoming From 1996 to 2018",
                                   plotOutput("plot1_2")),
                               infoBox("Mexico", 7017675377, icon= icon("hand-point-up")),
                               infoBox("Canada", 2669571066, icon= icon("hand-point-down"))
                             ))
                  ))),
    
    
    
    
    #Body3 : Different Ways of Border Entry ####
        tabItem(tabName="measure", 
                fluidPage(
                  h1("By Modes of Transportation"),
                  br(),
                  box(
                    title = "Transporation Comparison",
                    plotOutput("plotTransport", height = 625)),
                  box(
                    selectizeInput(inputId="border_3", label="Border:", border_choice),
                    title = "Transportation Comparison by Border",
                    plotOutput("plotMeasure", height = 550))
                )),
    #Body4 : By State Information ####  
        tabItem(tabName="chart2", 
                fluidPage(
                  h1("By State"),
                  br(),
                  box(
                    title = "State Comparison",
                    plotOutput("plot2_1", height = 625)),
                  box(
                    selectizeInput(inputId="State_2", label="State:",state_choice),
                    title="Measures by States",
                    plotOutput("plot2", height =550))
                  )),
    #Body5 : By Year ####
        tabItem(tabName = "chart3",
                fluidPage(
                  h1("By Year"),
                  box(title="Select Year Range between 1996 and 2018",
                      solidHeader=TRUE,
                      width = 7,
                      sliderInput(inputId ="Year_3", label="Year:", 1996, 2018,value=c(1996,2018), sep="", step=1)),
                  box(title="Select Mode of Entry", width = 5, selectizeInput(inputId ="Measure3", label="Measure:", measure_choice)),
                  box(width=12, title="Change Over Years",
                      solidHeader = TRUE,
                      plotOutput("plot3",height = 500)))),
    #Body6 : By Month ####
        tabItem(tabName = "chart4", 
                fluidPage(
                  h1("By Month"),
                  box(title="Select Month Range",
                      solidHeader=TRUE,
                      width = 6,
                      sliderInput(inputId ="Month_4", "Month:", 1,12,value = c(1,12))),
                  box(title = "Select Mode of Entry",width = 6, selectizeInput(inputId ="Measure4", label="Measure:", measure_choice)),
                  box(width= 12, title = "Change Over Months",
                      solidHeader =TRUE,
                      plotOutput("plot4", height = 500))
        )),
    #Body7 : Show the Data ####
        tabItem(tabName = "data",
                fluidPage(
                  h1("Data"),
                  box(selectizeInput("selected", "Select item to display:", choice)),
                  box(DT::dataTableOutput("table"),
                      width=12))),
    #Body8 : About me ####
         tabItem(tabName="me", 
                fluidRow(box(width=12,
                        h1("Hello"),
                        "This is me."
               )))))
)
