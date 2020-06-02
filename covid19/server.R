function(input, output) {

  # Filter data based on selections
  output$table <- DT::renderDataTable(DT::datatable({
    data <- df
    if (input$region != "All") {
      data <- data[data$Region == input$region,]
    }
    if (input$comuna != "All") {
      data <- data[data$Comuna == input$comuna,]
    }
    if (input$fecha != "All") {
      data <- data[data$date == input$fecha,]
    }
    data
  }))

}