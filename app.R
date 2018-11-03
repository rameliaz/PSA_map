#----
# Load packages (install first if necessary)
library("shiny")
library("shinythemes")
library("shinydashboard")
library("leaflet")
#library("leaflet.extras")
library("htmltools")
library("dplyr")

#----
# Load data
# Note: Shiny cannot pull geocoded data quick enough.
#       So the data needs to be saved in a csv and updated when necessary.
#       In this code, R will pull the available csv, 
#       but the deployment code will allow the user to update the csv. 

# Note: Shiny cannot pull geocoded data quick enough.
#       So the data is saved in a csv read by the app.
#       In this code, R pulls the available csv, 
#       but the deploy_app.R code will  allow the user to update the csv (if necessary). 
DF <- read.csv("psa.comm.data.csv")

#----
# Shiny app
# ui
ui <- fluidPage(
  HTML('<center> <img src= "psa_image_small.jpg" align = "middle"> </center>'),
  
  fluidRow(style = "border: 4px double black;",
           leafletOutput("psa.map")
    )
)

# server
server <- function(input, output, session) {
  output$psa.map <- renderLeaflet({
    # build map
    leaflet(DF) %>% 
      addTiles() %>% 
      addCircleMarkers(radius = 2, 
                       popup = ~paste("<b> Lab ID: </b>", LAB.ID, "<br>",
                                      "<b> Name: </b>", Names, "<br>",
                                      "<b> Institution: </b>", Institution, "<br>",
                                      "<b> City: </b>", City, "<br>",
                                      "<b> Country: </b>", Country, "<br>",
                                      "<b> Subfield: </b>", Subfield..Social..Cognitive..Clinical..etc..)
      )
  })
  }

shinyApp(ui, server)