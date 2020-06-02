fluidPage(
  titlePanel("PWT"),
  helpText("Fernando Greve.",
           a(href="http://www.fgreve.com", target="_blank", "www.fgreve.com")),
           
  sidebarLayout(

    # Sidebar panel for inputs 
    sidebarPanel(
    
      selectInput("country", label = h4("Country"), c("All", unique(as.character(df$country)))),

      sliderInput("year", label = h4("Year"), round = TRUE, sep = "", format="####",
                  min = min(df$year, na.rm = TRUE), max = max(df$year, na.rm = TRUE), 
                  value = c(2000,2015)),
    ),

  # Main panel for displaying outputs
    mainPanel(
      DT::dataTableOutput("table")
    ),
  ),
)