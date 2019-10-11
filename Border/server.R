shinyServer(function(input, output,session) {
  
  #Body3 : Show the Data ####
  output$table <- DT::renderDataTable({
    datatable(borderF,rownames = FALSE) %>% 
      formatStyle(input$selected,background="skyblue",fontWeight='bold')
  })
  
  #Body4 : Map ####
  
  
  #Body7 chart 3: By Year ####
  output$plot3 <- renderPlot(
    borderF %>%
      group_by(Border, Year) %>% 
      summarise(total_3 = sum(Value)) %>% 
      filter(between(Year, input$Year_3[1], input$Year_3[2])) %>% 
      ggplot(aes(x=Year, y=total_3)) +
      geom_col(aes(fill=Border), position="dodge") 
  ) 
  
  #Body8 chart 4: By Month ####
  output$plot4 <- renderPlot(
    borderF %>%
      group_by(Border, Month) %>% 
      summarise(total_4 = sum(Value)) %>% 
      filter(between(Month, input$Month_4[1], input$Month_4[2])) %>% 
      ggplot(aes(x=Month, y=total_4)) +
      geom_col(aes(fill=Border), position="dodge") 
  )
})

