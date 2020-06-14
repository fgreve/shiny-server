
function(input, output){
    output$mymap <- renderLeaflet({m})
    
    output$plot <- renderPlotly({p})
    
    output$dygraph <- renderDygraph({dygraph(time_series[,input$comuna], main = "Casos Nuevos por Comuna") %>% 
            dyRangeSelector() %>% dyOptions(stackedGraph = TRUE) %>% dyRangeSelector(height = 20) %>%
            dyHighlight(highlightSeriesOpts = list(strokeWidth = 3))
        
    })
    
    output$dygraph_nacional <- renderDygraph({dygraph(TotalesNacionales[,input$var_nacional], main = "Total Nacional") %>% 
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
