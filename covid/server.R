
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
    
    output$dygraph_region <- renderDygraph({dygraph(CasosRegionales_diff[,input$region], main = "Casos Nuevos por Region") %>% 
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
            color = "purple")
    })
    
    output$value3 <- renderValueBox({
        valueBox(
            formatC(last(TotalesNacionales$"Fallecidos", 1), format="d", big.mark='.'),
            names(TotalesNacionales$"Fallecidos"),
            color = "green")
    })
    
    output$value4 <- renderValueBox({
        valueBox(
            formatC(last(TotalesNacionales$"Fallecidos nuevos", 1), format="d", big.mark='.'),
            names(TotalesNacionales$"Fallecidos nuevos"),
            color = "green")
    })
    
    
    output$value5 <- renderValueBox({
        valueBox(
            formatC(last(CasosRegionales$"Metropolitana", 1), format="d", big.mark='.'),
            "Casos R.Metropolitana",
            color = "red")
    })
    
    output$value6 <- renderValueBox({
        valueBox(
            formatC(last(CasosRegionales_diff$"Metropolitana", 1), format="d", big.mark='.'),
            "Casos nuevos R.Metropolitana",
            color = "red")
    })
    
    
    output$b <- renderText({time(last(TotalesNacionales))  %>% as.character() })
    
    
    
}
