# ui.R for WonderData


# Design for HEADER starts here
header <- dashboardHeader(title = "WonderData")

# Design and widgets for SIDEBAR starts here
sidebar <- dashboardSidebar(
  sidebarMenu(
    menuItem("Home", tabName = "home", icon = icon("home")),
    menuItem("WORLD", icon = icon("bar-chart-o"), tabName = "overview", startExpanded = TRUE,
             menuSubItem("Profile", icon = icon("check-circle"),tabName = "profileWorld"),
             menuSubItem("Data", icon = icon("check-circle"),tabName = "dataWorld")),
    menuItem("ASIA", icon = icon("bar-chart-o"), tabName = "overview", startExpanded = TRUE,
             menuSubItem("Profile", icon = icon("check-circle"), tabName = "profileAsia"),
             menuSubItem("Data", icon = icon("check-circle"),tabName = "dataAsia"))
  )
)

# Design and widgets for BODY starts here
body <- dashboardBody(
  

  tabItems(
    # ========== body code for menu::Home ===============
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
                           tabPanel(strong("ABOUT"), 
                                    h4("Today globalization and trend in trevelling have been dramatically increased over the last twenty years. 
                   The number of people who visiting foreign country rise each and every year to the other part around the world. 
                   This phenomenon has brought impact to GDP (Gross Domestic Product) growth due to tourism spending."),
                                    h4("In fact, tourism has implications on the economy, on the natural and built evironment, on the local desination, 
                   and on the tourist themselves. Tourist also called visitors, which may be either resident or non-resident who 
                   are doing activities which imply tourism expenditure. Additionally, in world tourism organization data says money 
                   spent by foreign visitors accounted for almost  30 % of total world services exports."),
                                    h4("Using 10 years data, we can anlyse the revenues generated from inbound and outbound tourism."),
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
                           
                           tabPanel(strong("Dataset"), 
                                    h4(strong("Source 1")), 
                                    h5("World Bank Data"), 
                                    h4(strong("Source 2")), 
                                    h5("Facebook"),
                                    br(), br()
                                    ),
                           
                           tabPanel(strong("Info"), 
                                    "What we have and how user can interact with this shiny app"
                                    ),
                           
                           tabPanel(strong("Links"), 
                                    "1. Github Links here", br(),
                                    "What we have and how user can interact with this shiny app")
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
                             h2("Revenues Generated from Tourism Expenditure:", br(),"Top and Bottom Countries (WDI data)", align="center"),
                             box(title = "Top revenue", status = "primary", solidHeader = TRUE, 
                                 busyIndicator(text = "Rendering in progress ... ",wait = 500),
                                 plotOutput("worldtopPlot"),
                                 br(),br(),
                                 sliderInput("sYearW1", "1. Select year:", min=2005, max=2015, value = 2016, step = 1),
                                 br(),
                                 radioButtons("w1", "2. Select number of country to view:",
                                              list("Top 5"='a', "Top 10"='b', "Top 20"='c', "Top 30"='d', "Show all"='e'),
                                             selected='a')
                             ),
                             box(title = "Bottom revenue", status = "primary", solidHeader = TRUE, 
                                 busyIndicator(text = "Rendering in progress ... ",wait = 500),
                                 plotOutput("worldbotPlot"),
                                 br(),br(),
                                 sliderInput("sYearW2", "1. Select year:", min=2005, max=2015, value = 2016, step = 1),
                                 br(),
                                 radioButtons("w2", "2. Select number of country to view:",
                                              list("Bottom 10"='f', "Bottom 20"='g', "Bottom 30"='h'),
                                             selected='f')
                             )
                    ),
                    tabPanel("Analysis 2", 
                             h2("Revenues generated from countries in the world"),
                             "Tab content here")
                  )
              ) #end of box
            ) #end of fluidRow
    ), #end of tabitem
    
    tabItem(tabName = "dataWorld",
            fluidRow(
              box(width = 12, solidHeader = FALSE,
                  h2("Download datasets"),
                  br(),
                  downloadButton("downloadBtnW", "Download data"), br(), br(),
                  DT::dataTableOutput("dataWorldTable")
              )
            )
            
    ), #end of tabitem

    # ========== body code for menu::ASIA ===============
    tabItem(tabName = "profileAsia",
            fluidRow(
              box(width = 12,
                  tabsetPanel(
                    tabPanel("Analysis 1", 
                             h2("Revenues Generated from Tourism Expenditure:", br(),"ASEAN Countries (csv data)", align="center"),
                             box(width = 12,
                                 title = "Top revenue", status = "primary", solidHeader = TRUE, 
                                 busyIndicator(text = "Rendering in progress ... ",wait = 500),
                                 plotOutput("asiaPlot"),
                                 br(),
                                 sliderInput("sYearA1", "1. Select year:", min=2006, max=2016, value = 2016, step = 1),
                                 br()
                             )
                    ),
                    tabPanel("Analysis 2", 
                             h2("Revenues generated from countries in the world"),
                             "Tab content here")
                  )
              ) #end of box
            ) #end of fluidRow
    ), #end of tabitem
    tabItem(tabName = "dataAsia",
            fluidRow(
              box(width = 12, solidHeader = FALSE,
                  h2("Download datasets"),
                  br(),
                  downloadButton("downloadBtnA", "Download data"), br(), br(),
                  DT::dataTableOutput("dataAsiaTable")
              )
            )
    ) #end of tabitem
           
    
    )
#end of dashboardBody
)

dashboardPage(
  header, 
  title ="WQD7001 - Group 11", 
  sidebar, 
  body
)
