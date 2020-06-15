
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
        fluidRow(valueBoxOutput("value1"), valueBoxOutput("value2"), valueBoxOutput("value3")),
        checkboxGroupInput("var_nacional","Elegir:", names(TotalesNacionales), selected="Casos nuevos totales", inline = TRUE),
        dygraphOutput("dygraph_nacional"),
        
        h2("Casos Nuevos por Comuna"),
        dygraphOutput("dygraph"),
        checkboxGroupInput("comuna","Elegir comunas",minsal$Comuna,selected=c("Nunoa","Independencia","Providencia","La Reina","Santiago"), inline = TRUE),
        
        h2("Tasa de Contagios RM (Tasa: casos confirmados por cada 100 mil habitantes)"),
        plotlyOutput("plot"),
        leafletOutput("mymap"),
        
        tags$footer(a(href="http://www.fernandogreve.com", target="_blank", "www.fernandogreve.com"))
        
    )
    
)