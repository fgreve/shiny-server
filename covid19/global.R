library(shiny)
library(dplyr) # tidyverse
library(tidyr) # gather()

minsal = read.csv("https://raw.githubusercontent.com/MinCiencia/Datos-COVID19/master/output/producto1/Covid-19.csv", 
              check.names = FALSE,
              encoding="UTF-8") %>% 
  rename(cod_reg="Codigo region",cod_com="Codigo comuna")

casos = minsal %>% 
  select(-Region,-cod_reg,-Comuna,-Poblacion,-Tasa) %>% 
  gather("date", "cases",-1)

casos$date <- as.Date(casos$date, "%Y-%m-%d")
class(casos$date) 

info = minsal %>% select(Region,cod_reg,Comuna,cod_com,Poblacion)

df = merge(x=info, y=casos, by="cod_com", all.y=TRUE) %>% select(-cod_reg,-cod_com)

rm(casos,info,minsal)
