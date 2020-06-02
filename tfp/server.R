

# Define a server for the Shiny app
function(input, output) {
  
  # Fill in the spot we created for a plot
  output$phonePlot <- renderPlot({
    
    # Render a barplot
    barplot(tfp[,input$region], 
            main=input$region,
            ylab="Total Factor Productivity growth",
            xlab="Period of time",
            names.arg=c("1990-1995", "1995-2000",	"2000-2005",	"2005-2010",	"2010-2015")
            )
  })
}


