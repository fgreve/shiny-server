library(shiny)
library(dplyr) # tidyverse

pwt = read.csv("https://raw.githubusercontent.com/fgreve/PennWorldTable9.1/master/pwt91.csv")
df = pwt %>% select(country,year,pop)
df$year = as.integer(df$year)

rm(pwt)

