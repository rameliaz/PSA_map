# Issues
# missing all names and all contributing researchers
# map will often incorrectly place a datapoint if there are multiple cities in a country with the same name

# clear R environment
rm(list = ls())

#----
# Install and load packages by calling 'meta.pipeline.packages.R' script
library("shiny")
library("shinythemes")
library("shinydashboard")
library("googlesheets")
library("ggmap")
library("leaflet")
library("htmltools")
library("dplyr")

# #----
# # Load data
# # Note: it will ask you to sign in to your Google profile
# DF <- gs_read(ss = gs_title("Members of the Psychological Science Accelerator"),
#               na.rm = "N/A")
#               
# # extract geolocation data using geocode function
# # note: source set to dsk to avoid Google API query limits
# # warning: this will take a couple of minutes first time it is run.
# DF.ll <- geocode(location = DF$'Map Info', 
#                  output = "latlon",
#                  source = "dsk")
# DF$lng <- DF.ll$lon  #  longitude
# DF$lat <- DF.ll$lat  #  latitude
# rm(DF.ll)
# 
# write.csv(DF, file = "data.csv")
DF <- read.csv("data.csv")        
#----
# Shiny app

# ui
ui <- fluidPage(
  "PSA Shiny Map prototype",
  leafletOutput("psa.map")
)

# server
server <- function(input, output, session) {
  output$psa.map <- renderLeaflet({
    leaflet(DF) %>% 
      addTiles() %>% 
      addCircleMarkers(radius = 2, 
                       popup = ~paste("<b> Lab ID: </b>", TUR_011, "<br>",
                                      "<b> Name: </b>", First.Name, Last.Name, "<br>",
                                      "<b> Institution: </b>", Institution, "<br>",
                                      "<b> City: </b>", City, "<br>",
                                      "<b> Country: </b>", Country, "<br>",
                                      "<b> Subfield: </b>", Subfield..Social..Cognitive..Clinical..etc..)
      )
  })
  }

shinyApp(ui, server)