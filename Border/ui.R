
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
        menuItem("Border Ports", tabName = "borderport", icon=icon("map")),
        menuItem("Modes of Transportation", tabName="measure", icon = icon("car-side")),
        menuItem("States",tabName="chart2", icon=icon("flag")),
        menuItem("Trend by Year",tabName= "chart3",icon = icon("chart-line")),
        menuItem("Trend by Month", tabName= "chart4", icon=icon("chart-line")),
        menuItem("Data",tabName = "data",icon = icon("database")),
        menuItem("About", tabName="me", icon=icon("info")))
    ),
    
    
    #Body1 : About the Border ####
    dashboardBody(
      tabItems(
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
    
    
    
    
    #Body2 : Different Ways of Border Entry ####
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
    #Body3 : By State Information ####  
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
    #Body4 : By Year ####
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
    #Body5 : By Month ####
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
    #Body6 : Show the Data ####
        tabItem(tabName = "data",
                fluidPage(
                  h1("Data"),
                  box(selectizeInput("selected", "Select item to display:", choice)),
                  box(DT::dataTableOutput("table"),
                      width=12))),
    #Body7 : About ####
         tabItem(tabName="me", 
                fluidPage(
                        h1("About Data"),
                        h4("This data visualization project was done based on the Bureau of Transportation Statistics (BTS) Border Crossing Data.", br(),
                        "Data are collected at U.S.-Canada and U.S.-Mexico border at the port level for the inbound crossings by U.S. Customs and Border Protection (CBP).", br(),
                        "Data include the number of vehicles, containers, passengers and pedestrians along with type of transportation such as trucks, trains, buses and personal vehicles.", br(),
                        "Most data are available from 1994 and new data are being constantly added after the review from BTS.", br(),
                        "The data can be accessed with the link below."),
                        uiOutput("tab"),
                        br(),
                        br(),
                        h1("About Me"),
                        h4("Bee Kim is a currently studying at NYC Data Science Academy as a fellow to follow her passion.", br(),
                        "She holds a MS degree in Information Systems with concentration in data analysis from NJIT and BS degree in Clinical Laboratory Science from SUNY Stony Brook.", br(),
                        "If you want to follow her work in data science, please check the GitHub link above the Dashboard!")
               )))
))
