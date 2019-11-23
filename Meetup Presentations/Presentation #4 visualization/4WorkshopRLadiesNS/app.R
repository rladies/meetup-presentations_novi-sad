#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

ui <- fluidPage(
  
                # Dodamo naslov
                headerPanel("Hello!"),
                
                # U baru sa strane, u input delu, dodaj  
                sidebarPanel(
                  # Padajuci meni
                  selectInput("Vector", 
                            "Select Mean of the distribution",
                            c(0,1,2,3,4,5),
                            selected = 0,
                            multiple = FALSE),
                  # Vrednost za n
                  numericInput("n", "n", 50),
                  # I dugme Go
                  actionButton("go", "Go")
                
                ),
                
                # U output delu dodaj plot i statistiku
                mainPanel(plotOutput("main_plot"), 
                          verbatimTextOutput("stats"))
)


server <- function(input, output) {
  
  # Kada se aktivira dugme Go sačuvaj mi vrednost promenljive n
  randomVals <- eventReactive(input$go, input$n)
  
  # Kreiraj n, tj. randomVals(), brojeva sa normalnom raspodelom (rnorm)
  # čija je srednja vrednost, mean, sačuvana u vektoru input$Vector
  v <- function() { 
       return(
              rnorm(randomVals(), mean = as.numeric(input$Vector))
  )}
  
  # Kreiran output plot definisan u ui, tako što crtamo histogram 
  # uz pomoć vectora v koji smo upravo definisali
  output$main_plot <- renderPlot(
                      hist(v(), 
                           breaks = 15, # broj stubova
                           xlab = "",   # bez imena na x - osi
                           main = "Histogram of samples size n") # sa naslovom
  )
  
  # Dodaj ispod histograma i opisnu statistiku definisanu u ui
  output$stats <- renderPrint({summary(v())})
}

# Pokrenimo aplikaciju
shinyApp(ui = ui, server = server)

