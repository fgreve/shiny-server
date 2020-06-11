library("dplyr")
library("shiny")

fluidPage(
  titlePanel('Chilean Congress Voting Tracker'),
  sidebarLayout(
    sidebarPanel(
      selectInput("dataset", "Senador:", selected = "Girardi L. Guido",
                  choices = c("TODOS",
                              "Walker P. Ignacio", 
                              "Allamand Z. Andres",
                              "Alvear V. Soledad",
                              "Arancibia R. Jorge",
                              "Avila C. Nelson",
                              "Cantero O. Carlos",
                              "Chadwick P. Andres",
                              "Coloma C. Juan Antonio",
                              "Escalona M. Camilo",
                              "Espina O. Alberto",
                              "Flores L. Fernando",
                              "Frei R. Eduardo",
                              "Garcia R. Jose",
                              "Gazmuri M. Jaime",
                              "Girardi L. Guido",
                              "Gomez U. Jose Antonio",
                              "Horvath K. Antonio",
                              "Kuschel S. Carlos Ignacio",
                              "Larrain F. Hernan",
                              "Longueira M. Pablo",
                              "Matthei F. Evelyn",
                              "Munoz A. Pedro",
                              "Munoz B. Roberto",
                              "Novoa V. Jovino",
                              "Ominami P. Carlos",
                              "Orpis B. Jaime",
                              "Prokurica P. Baldo",
                              "Ruiz-Esquide J. Mariano",
                              "Sabag C. Hosain",
                              "Vasquez U. Guillermo",
                              "Zaldivar L. Adolfo",
                              "Perez V. Victor",
                              "Bianchi C. Carlos",
                              "Letelier M. Juan Pablo",
                              "Romero P. Sergio",
                              "Naranjo O. Jaime",
                              "Navarro B. Alejandro",
                              "Nunez M. Ricardo",
                              "Pizarro S. Jorge",
                              "Allende B. Isabel",
                              "Chahuan C. Francisco",
                              "Garcia Huidobro S. Alejandro",
                              "Lagos W. Ricardo",
                              "Rincon G. Ximena",
                              "Rossi C. Fulvio",
                              "Tuma Z. Eugenio",
                              "Uriarte H. Gonzalo",
                              "Von Baer J. Ena",
                              "Walker P. Patricio",
                              "Zaldivar L. Andres",
                              "Walker P. Ignacio",
                              "Perez S. Lily",
                              "Quintana L. Jaime",
                              "Larrain P. Carlos",
                              "Araya G. Pedro",
                              "De Urresti L. Alfonso",
                              "Goic B. Carolina",
                              "Harboe B. Felipe",
                              "Montes C. Carlos",
                              "Moreira B. Ivan",
                              "Munoz D. Adriana",
                              "Guillier A. Alejandro",
                              "Ossandon I. Manuel Jose",
                              "Van Rysselberghe H. Jacqueline",
                              "Quinteros L. Rabindranath",
                              "Matta A. Manuel Antonio")),   
          

      
      dateRangeInput("dateRange", "Date range:",
                     start  = "2017-01-01",
                     end    = "2017-12-31",
                     format = "mm/dd/yy",
                     separator = " - "),
      
      #sliderInput("range", "Periodo del Proyecto de Ley:",
                  #min = 2000, max = 2017, value = c(2015,2017)),
      
      textInput("txt", "Buscar Proyecto por palabra clave:", ""),
      
      hr(),
      helpText("Source: Camara de Senadores de Chile.",
               a(href="http://www.fgreve.com", target="_blank", "www.fgreve.com"))
      
    ),
    mainPanel(
      tableOutput('table')
    )
  )
)