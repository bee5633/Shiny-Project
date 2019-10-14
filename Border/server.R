shinyServer(function(input, output,session) {
  
  #Body1 : Map ####
  
  #make data smaller by putting all the same port in a same long and lat so it can shorten the time to upload the map
  borderPortLongLat <- borderF %>% 
    select(Port.Name,State,Longitude,Latitude) %>% 
    group_by(Port.Name) %>% 
    mutate(Longitude=mean(Longitude), Latitude=mean(Latitude))
  
  borderUniqPortLongLat = unique(borderPortLongLat)
  
  output$borderMap <- renderLeaflet({
      leaflet_border <- leaflet(borderUniqPortLongLat) %>% 
        addTiles() %>% 
        addCircles(~Longitude, ~Latitude) %>% 
        addMarkers(~Longitude, ~Latitude, popup = paste("Port Name:", borderUniqPortLongLat$Port.Name, "<br>",
                                                        "State:", borderUniqPortLongLat$State, "<br>",
                                                        "Long:",borderUniqPortLongLat$Longitude, "<br>",
                                                        "Lat:", borderUniqPortLongLat$Latitude, "<br>"))
  })
  
  
  #Body1 : Border Information ####
  output$plot1 <- renderPlot(
    borderF %>% 
      group_by(Border) %>% 
      summarise(NumberPort = dplyr::n_distinct(Port.Name)) %>% 
      ggplot(aes(Border, NumberPort)) + geom_col(fill='light pink') + 
      labs(x="Border", y="Number of Port") + 
      theme(axis.text=element_text(size=12),
            axis.title=element_text(size=14,face="bold"))
  )
  
  #depending on border, how many incomings
  output$plot1_2 <- renderPlot(
    borderF %>% 
      select(Border, Value) %>% 
      group_by(Border) %>% 
      summarise(totalIncBor = sum(as.numeric(Value))) %>% 
      ggplot(aes(Border, totalIncBor)) + geom_col(fill='orange') + 
      labs(x="Border", y="Number of Incoming") +
      theme(axis.text=element_text(size=12),
            axis.title=element_text(size=14,face="bold"))
  )
  
  #Body2 : Measure ####
  output$plotTransport <- renderPlot(
    borderF %>% 
      group_by(Measure, Value) %>% 
      summarise(sumV = sum(as.numeric(Value))) %>% 
      ggplot(aes(Measure, sumV)) + geom_col(fill='Navy') + 
      labs(x="Measure", y="Number of Incoming") +
      theme(axis.text.x=element_text(angle=90)) +
      theme(axis.text=element_text(size=12),
            axis.title=element_text(size=14,face="bold"))
  )
  
  output$plotMeasure <- renderPlot(
    borderF %>% 
      filter(Border == input$border_3) %>% 
      select(Measure, Value, Border) %>% 
      group_by(Measure, Border) %>% 
      summarise(totalmeasure = sum(as.numeric(Value))) %>% 
      ggplot(aes(Measure, totalmeasure)) + geom_col(fill='purple') + labs(x="Measure", y="Number of Incoming") +
      theme(axis.text.x=element_text(angle=90)) +
      theme(axis.text=element_text(size=12),
            axis.title=element_text(size=14,face="bold"))
  )
  #Body3 : By State Information ####
  output$plot2 <- renderPlot(
    borderF %>% 
      filter(State == input$State_2) %>%
      select(State, Measure, Value) %>% 
      group_by(State, Measure) %>% 
      mutate(MeasureSum = sum(Value)) %>% 
      ggplot(aes(Measure, MeasureSum)) + geom_col(fill ='light blue') + 
      labs(title="Modes of Transportation by Different States",x="Modes of Transportation", y="Count") + 
      theme(axis.text.x=element_text(angle=90)) +
      theme(axis.text=element_text(size=12),
            axis.title=element_text(size=14,face="bold"))
  )
  
  output$plot2_1 <- renderPlot(
    borderF %>% 
      group_by(State) %>% 
      summarise(sumV = sum(as.numeric(Value))) %>% 
      arrange(desc(sumV)) %>% 
      ggplot(aes(State, sumV)) + geom_col(fill='light green') + 
      labs(x="State", y="Border Entry") +
      theme(axis.text.x=element_text(angle=90)) +
      theme(axis.text=element_text(size=12),
            axis.title=element_text(size=14,face="bold"))
  )
  
  
  
  #Body4 : By Year ####
  output$plot3 <- renderPlot(
    borderF %>%
      group_by(Border, Year) %>% 
      filter(Measure == input$Measure3) %>% 
      summarise(total_3 = sum(Value)) %>% 
      filter(between(Year, input$Year_3[1], input$Year_3[2])) %>% 
      ggplot(aes(x=Year, y=total_3)) +
      geom_col(aes(fill=Border), position="dodge") + 
      labs(x="Year", y="Border Entry") +
      theme(axis.text=element_text(size=12),
            axis.title=element_text(size=14,face="bold")) +
      theme(legend.text=element_text(size=14))
  ) 
  
  #Body5 : By Month ####
  output$plot4 <- renderPlot(
    borderF %>%
      group_by(Border, Month) %>% 
      filter(Measure == input$Measure4) %>% 
      summarise(total_4 = sum(Value)) %>% 
      filter(between(Month, input$Month_4[1], input$Month_4[2])) %>% 
      ggplot(aes(x=Month, y=total_4)) +
      geom_col(aes(fill=Border), position="dodge") +
      labs(x="Month", y="Border Entry") + 
      scale_x_continuous(breaks=seq(1,12, by=1)) +
      theme(axis.text=element_text(size=12),
            axis.title=element_text(size=14,face="bold")) +
      theme(legend.text=element_text(size=14))
      
  )
  #Body6 : Show the Data ####
  output$table <- DT::renderDataTable({
    datatable(borderF,rownames = FALSE) %>% 
      formatStyle(input$selected,background="skyblue",fontWeight='bold')
  })
  #Body7 : About ####
  url <- a("Border Crossing", href = "https://www.kaggle.com/akhilv11/border-crossing-entry-data")
  
  output$tab <- renderUI ({
    tagList("URL link:", url)
  })
  
})

