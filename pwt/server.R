function(input, output) {

  # Filter data based on selections
  output$table <- DT::renderDataTable(DT::datatable({
    data <- df
    if (input$country != "All") {
      data <- data[data$country == input$country,]
    }
    if (input$year != "All") {
      data <- data[data$year %in% input$year,]
    }    
    
    data
  }))

}