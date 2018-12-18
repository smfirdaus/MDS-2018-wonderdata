# global.R for WonderData
library(shiny)
library(shinydashboard)
library(shinysky)
library(DT)
library(ggplot2)
library(dplyr)
library(tidyr)
library(reshape)
library(WDI)
library(ggthemes)
library(RJSONIO)

# ===================== WDI Data ===================== 
# Load WDI data from WDI package (to plot life expectancy vs GDP)
df <- WDI(country="all", indicator=c("NY.GDP.PCAP.CD", "SP.POP.TOTL", "ST.INT.XPND.CD","ST.INT.TRNR.CD","ST.INT.TRNX.CD"), start=2000, end=2015, extra = TRUE)
# Select features to remove
drops <- c("iso2c","iso3c", "capital", "longitude", "latitude", "income", "lending")
df <- df[ , !(names(df) %in% drops)]
# Name features
colnames(df) <- c("country","year", "GDP_per_capita", "population_total", "inbound_revenue","passengers_transports","outbound_revenue","region")
#df <- df[-c(1, 2, 3, 4, 5, 6, 19, 66, 67, 159, 178, 179, 180, 181, 182, 201, 202, 203, 204, 205, 206, 207, 225, 226, 227, 228, 236, 237, 238, 239, 240, 241, 242, 243, 245, 246, 247, 248, 249, 250, 251, 252, 253, 254, 255, 256, 257, 258, 259, 260, 262, 263), ]

# Imputing missing values with zero for China
df$passengers_transports[is.na(df$passengers_transports == "China")] <- 0
df$outbound_revenue[is.na(df$outbound_revenue == "China")] <- 0

# drop all NA observation
df <- df %>% drop_na()

#save row contains `Aggregate`` in column `region`
df.Agg <- filter(df, region == "Aggregates")
#remove row contains `Aggregate in column `region`
df <- df[df$region!="Aggregates", ]

# ===================== csv data: ASEAN ===================== 
#Asean Outbound
df.Asean <- read.csv("Asean.csv")
colnames(df.Asean) <- c("CountryName","CountryCode","2005","2006","2007","2008","2009","2010","2011","2012","2013","2014","2015","2016")
df.Asean <- melt(df.Asean, id=c(1,2))
colnames(df.Asean) <- c("CountryName","CountryCode","Year","Inbound_Revenue")

df.Msia <- filter(df.Asean, CountryName == "Malaysia")

#Filter Asean Countries
df.Asean <- filter(df.Asean,CountryName  %in% c("Thailand","Brunei Darussalam","Malaysia",
                                                "Indonesia","Cambodia","Vietnam","Singapore",
                                                "Lao PDR","Myanmar","Philippines"))
