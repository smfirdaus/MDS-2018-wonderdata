# server.R for WonderData


shinyServer(
  function(input, output) {
   
    # ============= output code for ::WORLD ===============
    re_yearW1 = reactive({
      yearW1 = as.numeric(input$sYearW1)
      return(filter(df, year == yearW1))
    })
    re_yearW2 = reactive({
      yearW2 = as.numeric(input$sYearW2)
      return(filter(df, year == yearW2))
    })
    re_yearA1 = reactive({
      yearA1 = as.numeric(input$sYearA1)
      return(filter(df.Asean, Year == yearA1))
    })
    # Show top 10 country
    output$worldtopPlot <- renderPlot({
      #referring radio button input w1 in ui.r as input$w1
      if(input$w1=='a'){i = 5}
      if(input$w1=='b'){i = 10}
      if(input$w1=='c'){i = 20}
      if(input$w1=='d'){i = 30}
      if(input$w1=='e'){i = 5000}
      
      dfW1 <- re_yearW1()
      dataList <- dfW1 %>% arrange(desc(dfW1$tourism_expenditure))
      dataWorld1 <- head(dataList, n=i)
      
      Sys.sleep(1)
      barplot(dataWorld1$tourism_expenditure/1000000000, 
              main="Revenues (USD Billion)", 
              ylab="Tourism Expenditure", 
              names.arg=dataWorld1$country, 
              border=FALSE, 
              col = grey.colors(30),
              #density=c(50,40,30,20,10),
              las=2)
    })
    
    # Show bottom 10 country
    output$worldbotPlot <- renderPlot({
      #referring radio button input w2 in ui.r as input$w2
      if(input$w2=='f'){i = 10}
      if(input$w2=='g'){i = 20}
      if(input$w2=='h'){i = 30}
      
      dfW2 <- re_yearW2()
      dataList <- dfW2 %>% arrange(desc(dfW2$tourism_expenditure))
      dataWorld2 <- tail(dataList, n=i)
      
      Sys.sleep(1)
      barplot(dataWorld2$tourism_expenditure/1000000, 
              main="Revenues (USD Million)", 
              ylab="Tourism Expenditure", 
              names.arg=dataWorld2$country, 
              border=FALSE, 
              col = grey.colors(30),
              #density=c(50,40,30,20,10),
              las=2)
    })
    
    # Show the data table
    output$dataWorldTable <- DT::renderDataTable(
      DT::datatable(
        df,
        rownames = TRUE,
        options = list(searching = FALSE, lengthChange = TRUE, scrollX = TRUE)
      )
    )
    
    # ============= output code for ::ASIA ===============
    output$asiaPlot <- renderPlot({
      
      dfA1 <- re_yearA1()
      dataAsean1 <- dfA1 %>% arrange(desc(dfA1$Revenue))
      
      Sys.sleep(1)
      barplot(dataAsean1$Revenue/1000000, 
              main="Revenues (USD Million)", 
              ylab="Tourism Expenditure", 
              names.arg=dataAsean1$CountryName,
              border=FALSE, 
              col = grey.colors(30),
              #density=c(50,40,30,20,10),
              las=2)
    })
    # Show the data table
    output$dataAsiaTable <- DT::renderDataTable(
      DT::datatable(
        df.Asean,
        rownames = TRUE,
        options = list(searching = FALSE, lengthChange = TRUE, scrollX = TRUE)
      )
    )

  }
)