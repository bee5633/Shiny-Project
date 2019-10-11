
ui <- dashboardPage( skin = "yellow",
    #Header ####
    dashboardHeader(
      title = "Border Entry to US"),
    #Sidebar ####
    dashboardSidebar(
      sidebarUserPanel(name="Bee Kim"),
      sidebarMenu(
        #total of 5 tabs in the sidebar
        menuItem("About Data", tabName ="aboutdata",icon = icon("info")),
        menuItem("About Me", tabName="me", icon=icon("user-alt")),
        menuItem("Data",tabName = "data",icon = icon("table")),
        menuItem("Map",tabName = "map", icon=icon("map")),
        menuItem("Charts",tabName= "charts",icon = icon("bar-chart-o"),
                menuSubItem("By Border", tabName = "chart1"),
                menuSubItem("By State", tabName ="chart2"),
                menuSubItem("By Year", tabName ="chart3"),
                menuSubItem("By Month", tabName="chart4")))
    ),
    #Body1 : About the Data ####
    dashboardBody(
      tabItems(
        tabItem(tabName="aboutdata",
                fluidRow(box(width=12,
                  h1("About Data"),
                  "This dataset is about Border Entry."
                  ))),
    #Body2 : About me ####
        tabItem(tabName="me", 
                fluidRow(box(width=12,
                  h1("Hello"),
                  "This is me."
                  ))),
    #Body3 : Show the Data ####
        tabItem(tabName = "data",
                fluidPage(
                  h1("Data"),
                  box(selectizeInput("selected", "Select item to display:", choice)),
                  box(DT::dataTableOutput("table"),
                      width=12))),
    #Body4 : Map ####
        tabItem(tabName = "map",
                fluidRow(
                  box(selectizeInput("USportname","Select the Port Name:", port_choice))),
                  box()
                  ),
    #Body5 chart 1: Border Information ####
        tabItem(tabName="chart1", 
                fluidRow(
                  h1("By Border"))),
    #Body6 chart 2: By State Information ####
        tabItem(tabName="chart2", 
                fluidRow(
                  h1("By State"))),
    #Body7 chart 3: By Year ####
        tabItem(tabName = "chart3",
                fluidRow(
                  box(title="Inputs",
                      solidHeader=TRUE,
                      width = 4,
                      sliderInput(inputId ="Year_3", label="Year:", 1996, 2019,value=c(1996,2019), sep="")),
                  box(title="Change Over Years",
                      solidHeader = TRUE,
                      plotOutput("plot3",height = 250)))),
    #Body8 chart 4: By Month ####
        tabItem(tabName = "chart4", 
                fluidRow(
                  box(title="Inputs",
                      solidHeader=TRUE,
                      width = 4,
                      sliderInput(inputId ="Month_4", "Month:", 1,12,value = c(1,12))),
                  box(title = "Change Over Months",
                      solidHeader =TRUE,
                      plotOutput("plot4", height = 250))))
        ))
)