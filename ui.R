# ui.R for WonderData


# Design for HEADER starts here
header <- dashboardHeader(title = "WonderData")

# Design and widgets for SIDEBAR starts here
sidebar <- dashboardSidebar(
  sidebarMenu(
    menuItem("Home", tabName = "home", icon = icon("home")),
    menuItem("WORLD", icon = icon("bar-chart-o"), tabName = "profileWorld"),
    menuItem("ASEAN", icon = icon("bar-chart-o"), tabName = "profileAsean")
  )
)

# Design and widgets for BODY starts here
body <- dashboardBody(
  

  tabItems(
    # ========== body code for menu::HOME ===============
    tabItem(tabName = "home",
            fluidRow(
              box(width = 12,
                       status = "primary",
                       solidHeader = FALSE,
                       style = "color:#444",
                       img(src="WonderData.png", align="center"),
                       h1("Analysis of Revenues Generated From Tourism Industries"),
                       br(),
                       
                navbarPage(title = "",
                           tabPanel(strong("About"), 
                                    h4("Today globalization and trend in travelling have been dramatically increased over the last twenty years. 
                   The number of people visiting foreign country rise each and every year to the other part around the world. 
                   This phenomenon has brought impact to GDP (Gross Domestic Product) growth due to tourism expenditure."),
                                    h4("In fact, tourism has implications on the economy, on the natural and built evironment, on the local destination, 
                   and on the tourist themselves. Tourist also called visitors, which may be either resident or non-resident who 
                   are doing activities which imply tourism expenditure. World Tourism Organization mentions that money 
                   spent by foreign visitors accounted for almost 30 % of total world services exports."),
                                    h4("Using 10 years data, we can analyse the revenues generated from inbound and outbound tourism."),
                                    br(), br()
                                    ),
                           
                           tabPanel(strong("Glossary"), 
                                    h4(strong("Country of residence")),
                                    h5("A person who resides for more than one year and there his/her center of economic 
                              interest where the predominant amount of time is spent."),
                                    h4(strong("Inbound Tourist")),
                                    h5("The activities of a non-resident who visit a country for the purpose of tourism."),
                                    h4(strong("Outbound Tourist")),
                                    h5("The activities of a resident who leave their own country to visit another country for the purpose of tourism."),
                                    h4(strong("Passenger Transport Expenditure")),
                                    h5("Expenditures of international outbound visitors in other countries for all services provided during international transportation 
                                       by nonresident carriers which including fares that are a part of package tours and  charges for food, drink, or other items for which 
                                       passengers make expenditures while on board carriers."),
                                    h4(strong("Tourism Revenue")),
                                    h5("Income from visitors (inbound, outbound) covers the estimated daily spending."),
                                    h4(strong("Tourist")),
                                    h5("A visitors is classified as a tourist, if his/her trip includes an overnight stay. "),
                                     h4(strong("Tourism Expenditure")),
                                    h5("The amount paid for the consumption goods and services, wether for own use or to give away, for and during tourism trips. "),
                                    h4(strong("Tourism Industries")),
                                    h5("The activities that produce tourism characteristic products."),
                                    h4(strong("Trip")),
                                    h5("Refers to the travel by a person from the time of departure his/her usual residence until they return. 
                              Trip taken by visitors is a tourism trips."),
                                    h4(strong("International Tourism Expenditures")),
                                    h5("Expenditures of international outbound visitors in other countries, including payments to foreign carriers for international transport. 
                              These expenditures may include those by residents traveling abroad as same-day visitors, 
                              except in cases where these are important enough to justify separate classification."),
                                    h4(strong("Visitor")),
                                    h5("A traveller taking a Trip to a main destination outside his/her usual environment. "),
                                    br(), br()
                                    ),
                           
                           tabPanel(strong("Data Links"), 
                                    h4(strong("1. Github")), 
                                    h5(uiOutput("link1")), br(),
                                    h4(strong("2. RPubs")), 
                                    h5(uiOutput("link2")),
                                    h4(strong("3. Dataset for the World (from WDI)")), 
                                    h5(uiOutput("link3")), br(),
                                    downloadButton("downloadBtnW", "Download data"), br(), br(),
                                    #h4(strong("4. Dataset for ASEAN country")), 
                                    downloadButton("downloadBtnA", "Download data"), br(), br(),
                                    #h5(uiOutput("link4")),
                                    br(), br()
                                    )
                           ) # end of navbar page
                
              ) #end of box
            ) #end of fluidRow
    ), #end of tabitem

    # ========== body code for menu::WORLD ===============

    tabItem(tabName = "profileWorld",
            fluidRow(
              box(width = 12, 
                  tabsetPanel(
                    tabPanel("Analysis 1", 
                             h2("Revenues Generated from Tourism (USD Billion):", br(),"Top and Bottom Countries (WDI data)", align="center"),
                             box(title = "Top revenue", status = "primary", solidHeader = TRUE, 
                                 busyIndicator(text = "Rendering in progress ... ",wait = 500),
                                 checkboxInput("checkW1", "Add Outbound Revenue trend",
                                               value=TRUE),
                                 hr(),
                                 plotOutput("worldtopPlot"),
                                 hr(),
                                 sliderInput("sYearW1", "1. Select year:", min=2005, max=2015, value = 2016, step = 1, animate = TRUE),
                                 br(),
                                 radioButtons("w1", "2. Select number of country to view:",
                                              list("Top 5"='a', "Top 10"='b', "Top 20"='c', "Top 30"='d', "Show all"='e'),
                                             selected='a')
                             ),
                             box(title = "Bottom revenue", status = "primary", solidHeader = TRUE, 
                                 busyIndicator(text = "Rendering in progress ... ",wait = 500),
                                 checkboxInput("checkW2", "Add Outbound Revenue trend line",
                                               value=FALSE),
                                 hr(),
                                 plotOutput("worldbotPlot"),
                                 hr(),
                                 sliderInput("sYearW2", "1. Select year:", min=2005, max=2015, value = 2016, step = 1, animate = TRUE),
                                 br(),
                                 radioButtons("w2", "2. Select number of country to view:",
                                              list("Bottom 10"='f', "Bottom 20"='g', "Bottom 30"='h'),
                                             selected='f')
                             )
                    ),
                    
                    tabPanel("Analysis 2", 
                             h2("Transportation Revenues vs Inbound Revenues (USD Billion)", align="center"),
                            status = "primary", solidHeader = TRUE, 
                                 busyIndicator(text = "Rendering in progress ... ",wait = 500),
                                 checkboxInput("checkW3", "Add Inbound Revenue trend line",
                                               value=TRUE),
                                 hr(),
                                 plotOutput("worldRvTPlot"),
                                 hr(),
                                 sliderInput("sYearW3", "Select year:", min=2005, max=2015, value = 2010, step = 1, animate = TRUE),
                                 br()
                             ),
                    
                    tabPanel("Analysis 3", 
                             h2("Inbound Revenues (USD Billion) vs", br(),"GDP", align="center"),
                              status = "primary", solidHeader = TRUE, 
                                 busyIndicator(text = "Rendering in progress ... ",wait = 500),
                                 checkboxInput("checkW4", "View Inbound Revenue trend (USD Billion)",
                                               value=FALSE),
                                 checkboxInput("checkW5", "View Total Population (Million)",
                                               value=FALSE),
                                 hr(),
                                 plotOutput("worldRvGdpPlot"),
                                 hr(),
                                 sliderInput("sYearW4", "1. Select year:", min=2005, max=2015, value = 2016, step = 1, animate = TRUE),
                                 br(),
                                 radioButtons("w4", "2. Select number of country to view:",
                                              list("Top 10"='l', "Top 20"='m', "Top 30"='n'),
                                              selected='l'),
                                 br()
                             ),
                    
                    tabPanel("Data", 
                             br(),
                             box(width = 12, status = "primary", solidHeader = TRUE,
                                 h2("Download datasets"),
                                 br(),
                                 downloadButton("downloadBtnW", "Download data"), br(), br(),
                                 DT::dataTableOutput("dataWorldTable")
                             ))
                  )
              ) #end of box
            ) #end of fluidRow
    ), #end of tabitem
    


    # ========== body code for menu::ASEAN ===============
    tabItem(tabName = "profileAsean",
            fluidRow(
              box(width = 12,
                  tabsetPanel(
                    tabPanel("Analysis 1", 
                             h2("Revenues Generated from Tourism Expenditure (USD Billion):", br(),"ASEAN Countries", align="center"),
                             box(width = 12, status = "primary", solidHeader = TRUE, 
                                 #title = "Top revenue", 
                                 busyIndicator(text = "Rendering in progress ... ",wait = 500),
                                 plotOutput("aseanPlot"),
                                 br(),
                                 sliderInput("sYearA1", "Select year:", min=2005, max=2016, value = 2016, step = 1, animate = TRUE),
                                 br()
                             )),
                    tabPanel("Analysis 2", 
                             h2("Revenues Generated from Tourism Expenditure:", br(),  "Malaysia, 2005-2016", align="center"),
                             box(width = 12, status = "primary", solidHeader = TRUE,
                                 #title = "Revenue vs Year",  
                                 busyIndicator(text = "Rendering in progress ... ",wait = 500),
                                 plotOutput("MsiaPlot"),
                                 br()
                             )),
                    tabPanel("Data", 
                             br(),
                             box(width = 12, status = "primary", solidHeader = TRUE,
                                 h2("Download datasets"),
                                 br(),
                                 downloadButton("downloadBtnA", "Download data"), br(), br(),
                                 DT::dataTableOutput("dataAseanTable")
                             ))
                  )
              ) #end of box
            ) #end of fluidRow
    ) #end of tabitem
    
    )
#end of dashboardBody
)

dashboardPage(
  header, 
  title ="WonderData", 
  sidebar, 
  body
)
