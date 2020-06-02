fluidPage(
  titlePanel("Chile: Casos covid19 por comuna"),
  helpText("Fernando Greve.",
           a(href="http://www.fgreve.com", target="_blank", "www.fgreve.com")),
           
  # Create a new Row in the UI for selectInputs
  fluidRow(
    column(4,
        selectInput("region",
                    "Region:",
                    c("All",
                      unique(as.character(df$Region))))
    ),
    column(4,
        selectInput("comuna",
                    "Comuna:",
                    c("All",
                      unique(as.character(df$Comuna))))
    ),
    column(4,
        selectInput("fecha",
                    "Fecha:",
                    c("All",
                      unique(as.character(df$date))))
    )
  ),
  # Create a new row for the table.
  DT::dataTableOutput("table")
)