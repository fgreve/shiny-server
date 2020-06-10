
dashboardPage(
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