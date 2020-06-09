library(rgdal)
library(dplyr)
library(leaflet)
library(ggplot2)
library(plotly)
library(tidyr)
library(dygraphs)
library(shiny)
library(shinyWidgets)
library(shinythemes) 
library(shinydashboard)

token = "pk.eyJ1IjoiZmdyZXZlIiwiYSI6ImNrYXpmMmI3dzA4Y3Yyc3AweW95eTR5azkifQ.Bou947cDslixneZpDKrImA"
stgo <- readOGR("https://raw.githubusercontent.com/fgreve/d3-comunas-cl/master/data/comunas.json")
class(stgo)

minsal = read.csv("https://raw.githubusercontent.com/MinCiencia/Datos-COVID19/master/output/producto1/Covid-19.csv", 
                  check.names = FALSE,
                  encoding="UTF-8") %>% 
    rename(cod_reg="Codigo region",id="Codigo comuna") %>%
    filter(Region == "Metropolitana")

stgo = sp::merge(stgo, minsal, by = "id")
stgo <- stgo[!is.na(stgo@data$Region),]
stgo <- stgo[stgo@data$Region=="Metropolitana",]

no_stgo = c("Tiltil","Lampa","Colina","San Jose de Maipo","Pirque","Paine","Buin","Alhue","Melipilla","San Pedro","Maria Pinto","Curacavi","Penaflor","Calera de Tango","Padre Hurtado","El Monte","Talagante","Isla de Maipo","Lo Barnechea")

stgo = stgo[!(stgo@data$Comuna %in% no_stgo),]

bins <- c(400, 600, 800, 1000, 1200, 1400, 1600, 1800, 2000, Inf)
pal <- colorBin("YlOrRd", domain = stgo$Tasa, bins = bins)

labels <- sprintf("<strong>%s</strong><br/>%g infected / population", stgo$Comuna, stgo$Tasa) %>% lapply(htmltools::HTML)

m <- leaflet(stgo) %>%
    setView(lng=-70.64724, lat=-33.47269, zoom=11) %>%
    addProviderTiles("MapBox", options=providerTileOptions(id="mapbox.light", accessToken=token)) %>% 
    addPolygons(
        fillColor = ~pal(Tasa),
        weight = 2,
        opacity = 1,
        color = "white",
        dashArray = "3",
        fillOpacity = 0.7,
        highlight = highlightOptions(weight = 5, color = "#666", dashArray = "", fillOpacity = 0.7, bringToFront = TRUE),
        label = labels,
        labelOptions = labelOptions(style = list("font-weight"="normal", padding="3px 8px"), textsize="15px", direction = "auto")) %>% 
    addLegend(pal = pal, values = ~Tasa, opacity = 0.7, title = NULL, position = "bottomright")

# series de tiempo por comuna (Numero de contagios)
library(xts)
time_series = minsal %>% 
    select(-Region,-cod_reg,-id,-Poblacion,-Tasa) %>% 
    gather("Fecha","Contagiados",-Comuna) %>% 
    spread(Comuna,Contagiados)   
    
time_series$Fecha = as.Date(time_series$Fecha)
time_series <- xts(time_series[,-1], order.by=as.Date(time_series[,1], "%Y-%m-%d"))
str(time_series)

# barra de tasas de contagio por comuna
df = minsal %>% select(Comuna,Tasa)
df$Comuna <- factor(df$Comuna, levels = unique(df$Comuna)[order(df$Tasa, decreasing = FALSE)])
p = df %>% plot_ly(x = ~Comuna, y = ~Tasa, type = "bar", name = 'Contagios')

# TotalesNacionales
producto5 = read.csv("https://raw.githubusercontent.com/MinCiencia/Datos-COVID19/master/output/producto5/TotalesNacionales.csv", 
                           check.names = FALSE, encoding="UTF-8")

TotalesNacionales = producto5 %>% gather("Date","Valor",-Fecha) %>% spread(Fecha,Valor) %>% rename(Fecha = Date)
TotalesNacionales$Fecha = as.Date(TotalesNacionales$Fecha)
TotalesNacionales <- xts(TotalesNacionales[,-1], order.by=as.Date(TotalesNacionales[,1], "%Y-%m-%d"))
str(TotalesNacionales)

# CasosRegionales
producto3 = read.csv("https://raw.githubusercontent.com/MinCiencia/Datos-COVID19/master/output/producto3/CasosTotalesCumulativo.csv", 
                     check.names = FALSE, encoding="UTF-8")

CasosRegionales = producto3 %>% gather("Date","Valor",-Region) %>% spread(Region,Valor) %>% rename(Fecha = Date)
CasosRegionales$Fecha = as.Date(CasosRegionales$Fecha)
CasosRegionales <- xts(CasosRegionales[,-1], order.by=as.Date(CasosRegionales[,1], "%Y-%m-%d"))
str(CasosRegionales)

rm(stgo, CasosRegionales, df, labels, producto3, producto5)

