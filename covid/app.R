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

ui <- shinydashboard::dashboardPage(
    dashboardHeader(title = "Covid-19 Chile" ),
    #sidebar <- dashboardSidebar(sidebarMenu(), disable = TRUE),
    
    sidebar <- dashboardSidebar(collapsed = TRUE,
        sidebarMenu (
            menuItem("Fernando Greve", startExpanded = TRUE, menuSubItem(text = "fernandogreve.com", href = "https://fernandogreve.com/")))
            
        ),
  
    
    
    dashboardBody(
        
        h2("Total Nacional"),
        
        h5('Ultima actualizacion'),
        textOutput("b"),
        
        fluidRow(valueBoxOutput("value1"),
                 valueBoxOutput("value2"),
                 valueBoxOutput("value3")),


        checkboxGroupInput("var_nacional","Elegir:", c("Casos totales","Casos nuevos totales"), selected=c("Casos totales","Casos nuevos totales"), inline = TRUE),

        dygraphOutput("dygraph_nacional"),
                          
        h2("Tasa de Contagios RM"),         
        
        plotlyOutput("plot"),
        
        leafletOutput("mymap"),
        
        dygraphOutput("dygraph"),
        
        selectInput("comuna","Elegir comunas",minsal$Comuna,selected=c("Nunoa","Independencia"),multiple=TRUE),
   
        
        tags$footer(a(href="http://www.fernandogreve.com", target="_blank", "www.fernandogreve.com"))
    
    )

)
                 

server = function(input, output){
    output$mymap <- renderLeaflet({m})
    
    output$plot <- renderPlotly({p})
    
    output$dygraph <- renderDygraph({dygraph(time_series[,input$comuna], main = "Total Contagiados por comuna") %>% 
            dyRangeSelector() %>% dyOptions(stackedGraph = TRUE) %>% dyRangeSelector(height = 20) %>%
            dyHighlight(highlightSeriesOpts = list(strokeWidth = 3))
        
        })
    
    output$dygraph_nacional <- renderDygraph({dygraph(TotalesNacionales[,input$var_nacional], main = "Casos totales y Casos nuevos totales") %>% 
            dyRangeSelector() %>% dyOptions(stackedGraph = TRUE) %>% dyRangeSelector(height = 20) %>%
            dyHighlight(highlightSeriesOpts = list(strokeWidth = 3))
        })
    
    
    output$value1 <- renderValueBox({
        valueBox(
            formatC(last(TotalesNacionales$"Casos nuevos totales", 1), format="d", big.mark='.'),
            names(TotalesNacionales$"Casos nuevos totales"),
            color = "purple")   
    })
    
    output$value2 <- renderValueBox({
        valueBox(
            formatC(last(TotalesNacionales$"Casos totales", 1), format="d", big.mark='.'),
            names(TotalesNacionales$"Casos totales"),
            color = "green")
    })
    
    output$value3 <- renderValueBox({
        valueBox(
            formatC(last(TotalesNacionales$"Fallecidos", 1), format="d", big.mark='.'),
            names(TotalesNacionales$"Fallecidos"),
            color = "yellow")
    })
    
    output$b <- renderText({time(last(TotalesNacionales))  %>% as.character() })

    

}


shinyApp(ui, server)      
      