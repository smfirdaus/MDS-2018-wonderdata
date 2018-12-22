# server.R for WonderData


shinyServer(
  function(input, output) {
    # ============= code for links ===============
    url1 <- a("https://github.com/smfirdaus/wonderdata", href="https://github.com/smfirdaus/wonderdata")
    output$link1 <- renderUI({
      tagList(url1)
    })
    url2 <- a("https://rpubs.com/nadiabella/wonderdata", href="https://rpubs.com/nadiabella/wonderdata")
    output$link2 <- renderUI({
      tagList(url2)
    })
    output$downloadBtnA <- downloadHandler(
      filename = function() {
        paste("aseanData.csv", ".csv", sep = "")
      },
      content = function(file) {
        write.csv(output$dataAseanTable, file, row.names = FALSE)
      }
    )
    # ============= code for reactive ===============
    re_yearW1 = reactive({
      yearW1 = as.numeric(input$sYearW1)
      return(filter(df, year == yearW1))
    })
    re_yearW2 = reactive({
      yearW2 = as.numeric(input$sYearW2)
      return(filter(df, year == yearW2))
    })
    re_yearW3 = reactive({
      yearW3 = as.numeric(input$sYearW3)
      return(filter(df, year == yearW3))
    })
    re_yearW4 = reactive({
      yearW4 = as.numeric(input$sYearW4)
      return(filter(df, year == yearW4))
    })
    re_yearW5 = reactive({
      yearW5 = as.numeric(input$sYearW5)
      return(filter(df, year == yearW5))
    })
    
    re_yearA1 = reactive({
      yearA1 = as.numeric(input$sYearA1)
      return(filter(df.Asean, Year == yearA1))
    })

    # ============= output code for ::WORLD ===============
    # Plot World 1: Show top country (inbound vs outbound)
    output$worldtopPlot <- renderPlot({
      #referring radio button input w1 in ui.r as input$w1
      if(input$w1=='a'){i = 5}
      if(input$w1=='b'){i = 10}
      if(input$w1=='c'){i = 20}
      if(input$w1=='d'){i = 30}
      if(input$w1=='e'){i = 5000}
      
      dfW1 <- re_yearW1()
      dataInList1 <- dfW1 %>% arrange(desc(dfW1$inbound_revenue))
      dataWorld1 <- head(dataInList1, n=i) #use for barplot
      
      op <- par(mar=c(9,5,2,4)) 
      PlotW1 <- barplot(dataWorld1$inbound_revenue/1000000000, 
                        ylab="Inbound Revenue", 
                        names.arg=dataWorld1$country, 
                        border=TRUE, 
                        col = grey.colors(30),
                        las=2)
      rm(op)
      if(1 %in% input$checkW1) {
      lines(x = PlotW1, y = dataWorld1$outbound_revenue/1000000000, type = "p", lwd=5, col="brown1", ylim=c(0,50))
        axis(side = 4)
        mtext("Outbound Revenue (USD Billion)", side = 4, line = 3)}
      
    })
 
    # Plot World 2: Show bottom country (inbound vs outbound)
    output$worldbotPlot <- renderPlot({
      if(input$w2=='f'){i = 10}
      if(input$w2=='g'){i = 20}
      if(input$w2=='h'){i = 30}
      
      dfW2 <- re_yearW2()
      dataInList2 <- dfW2 %>% arrange(desc(dfW2$inbound_revenue))
      dataWorld1 <- tail(dataInList2, n=i) #use for barplot
      op <- par(mar=c(9,5,2,4)) 
      PlotW2 <- barplot(dataWorld1$inbound_revenue/1000000, 
                        ylab="Inbound Revenue", 
                        names.arg=dataWorld1$country, 
                        border=FALSE, 
                        col = grey.colors(30),
                        las=2)
      rm(op)
      if(1 %in% input$checkW2) {
        lines(x = PlotW2, y = dataWorld1$outbound_revenue/1000000, type = "p", lwd=5, col="brown1", ylim=c(0,50))
        axis(side = 4)
        mtext("Outbound Revenue (Million)", side = 4, line = 3)}
    })
    
    # Plot World 3: Show Transportation vs Total Tourism Revenue
    output$worldRvTPlot <- renderPlot({
      
      dfW3 <- re_yearW3()
      dataList3 <- dfW3 %>% arrange(desc(dfW3$passengers_transports))
      dataWorld3 <- head(dataList3, n=20)
      op <- par(mar=c(9,5,2,5)) 
      PlotW3 <- barplot(dataWorld3$passengers_transports/1000000000, 
                        ylab="Transportation Revenue (USD Billion)", 
                        names.arg=dataWorld3$country, 
                        border= FALSE,
                        horiz = FALSE,
                        ylim=c(0,150), 
                        col = grey.colors(30),
                        las=2)
      rm(op)
      if(1 %in% input$checkW3) {
        lines(x = PlotW3, y = dataWorld3$inbound_revenue/1000000000, type = "p", lwd=5, col="brown1", pch=22)
        axis(side = 4)
        mtext("Inbound Revenue(USD Billion)", side = 4, line = 3)}
    })
    
    # Plot World 4: Show GDP vs Total Tourism Revenue
    output$worldRvGdpPlot <- renderPlot({
      if(input$w4=='l'){i = 10}
      if(input$w4=='m'){i = 20}
      if(input$w4=='n'){i = 30}
      
      dfW4 <- re_yearW4()
      dataList4 <- dfW4 %>% arrange(desc(dfW4$GDP_per_capita))
      dataWorld4 <- head(dataList4, n=i)
      op <- par(mar=c(9,5,2,5)) 
      PlotW4 <- barplot(dataWorld4$GDP_per_capita/1000, 
                        ylab="GDP Per Capita (USD '000)", 
                        names.arg=dataWorld4$country, 
                        border= FALSE,
                        horiz = FALSE,
                        ylim=c(0,340),
                        col = "grey",
                        las=2)
      rm(op)
      axis(side = 4)
      mtext("Inbound Revenue", side = 4, line = 3)
      if(1 %in% input$checkW4) lines(x = PlotW4, y = dataWorld4$inbound_revenue/1000000000, lwd=5, col="brown1")
      if(1 %in% input$checkW5) {
        #points(x = PlotW4, y = dataWorld4$population_total/1000000,  col="blue", pch=19)
        text(PlotW4, dataWorld4$population_total/1000000, labels=round(dataWorld4$population_total/1000000, digits=2), cex= 1, font=1, pos=3, col="black")
        }
      
    })

    # Table World 1: List the data table
    output$dataWorldTable <- DT::renderDataTable(
      DT::datatable(
        df,
        rownames = TRUE,
        options = list(searching = FALSE, lengthChange = TRUE, scrollX = TRUE)
      )
    )
    
    # ============= output code for ::ASEAN ===============
    # Plot ASEAN 1: Show Southeast Asia country
    output$aseanPlot <- renderPlot({
      
      dfA1 <- re_yearA1()
      dataAsean1 <- dfA1 %>% arrange(desc(dfA1$Inbound_Revenue))
      
      ggplot(dataAsean1, aes(Country, y=Inbound_Revenue)) + 
        geom_bar(aes(x=reorder(CountryName, -Inbound_Revenue), y=Inbound_Revenue), stat = "identity", fill = "steelblue") +
        ylab("") +
        xlab("") +
        theme_minimal() +
        geom_label(aes(x=reorder(CountryName, -Inbound_Revenue), y=Inbound_Revenue, label = round(Inbound_Revenue/1000000000, digits=1)), size=5, vjust = 0.5) +
        theme(axis.text=element_text(size=16),
              axis.text.x = element_text(angle = 45, hjust = 1),
              axis.text.y = element_blank(),
              panel.grid.minor = element_blank(),
              panel.grid.major = element_blank()) 
      
    })

    # Plot ASEAN 2: Show for Malaysia 
    output$MsiaPlot <- renderPlot({

      #Sys.sleep(1)
      ggplot(data=df.Msia, aes(x=Year, y=Inbound_Revenue, group=1)) +
        geom_line(color="red", size=2)+
        geom_point()+ 
        #xlab("") +
        ylab("") +
        geom_label(aes(Year, Inbound_Revenue, label = round(Inbound_Revenue/1000000000, digits=2)), size=5, vjust = 0.5)+
        theme_minimal()+
        theme(axis.text=element_text(size=16), 
              panel.grid.minor = element_blank(),
              #axis.text.x = element_text(hjust = 1),
              axis.text.y = element_blank(),
              axis.title = element_text(size=18,face="bold"))

    })
    # Table ASEAN 1: List the data table
    output$dataAseanTable <- DT::renderDataTable(
      DT::datatable(
        df.Asean,
        rownames = TRUE,
        options = list(searching = FALSE, lengthChange = TRUE, scrollX = TRUE)
      )
    )

  }
)