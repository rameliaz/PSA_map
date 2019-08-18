#----
# Load packages (install first if necessary)
library("shiny")
library("shinythemes")
library("shinydashboard")
library("leaflet")
library("leaflet.extras")
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
DF <- read.csv("webinar.viewing.data.csv")

#----
# Shiny app
# ui
ui <- fluidPage(
  HTML('<center><b>LOKASI PENYIARAN WEBINAR SAINS 2019</b></center>'),
  
  fluidRow(style = "border: 4px double black;",
           leafletOutput(outputId = "webinar.map")
  )
)


# server
server <- function(input, output, session) {
  output$webinar.map <- renderLeaflet({
    # build map
    leaflet(DF) %>% 
      setView(lng = 118, lat = -2.5, zoom = 4)  %>% #setting the view over ~ Indonesia
      addTiles() %>% 
      addCircles(lat = ~lat, 
                       lng = ~lng,
                       radius = 5, 
                       popup = ~paste("<b> ID Lokasi Penyiaran: </b>", ID, "<br>",
                                      "<b> Nama PIC: </b>", PIC, "<br>",
                                      "<b> Nama Host: </b>", host, "<br>",
                                      "<b> Universitas: </b>", universitas, "<br>",
                                      "<b> Nama Kota dan Propinsi: </b>", mapinfo, "<br>",
                                      "<b> Email Co-Host: </b>", email)
      )
  })
}

shinyApp(ui, server)