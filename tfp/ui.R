
# Use a fluid Bootstrap layout
fluidPage(    
  
  # Give the page a title
  titlePanel("Total Factor Productivity"),
  
  # Generate a row with a sidebar
  sidebarLayout(      
    
    # Define the sidebar with one input
    sidebarPanel(
      selectInput("region", "Region:", 
                  choices=colnames(tfp)),
      hr(),
      helpText("Source: Penn World Table.",
               a(href="http://www.fgreve.com", target="_blank", "www.fgreve.com"))
    ),
    
    # Create a spot for the barplot
    mainPanel(
      plotOutput("phonePlot")  
    )
    
  )
)