#----
# Load packages (install first if necessary)
library("rsconnect")
library("googlesheets")
library("ggmap")

#----
# Update data if necessary
# READ ME: Shiny cannot pull geocoded data quick enough.
#          So the data is saved in a csv read by the app.
#          If the data in the csv are out-of-date (i.e., there are new PSA members)
#          The coder can uncomment the next line of code to update the csv

# update <- "yes"
if (update == "yes"){
  # Load new data from Google Sheets
  # note: R will ask user to sign into their linked Google Drive profile
  DF <- gs_read(ss = gs_title("Members of the Psychological Science Accelerator"),
                na.rm = "N/A")
  
  # Geocode each PSA member
  # Note: this can be done more efficiently without for loops
  #       but loops provide flexibility needed to overcome limitations of geocoding services
  DF$lng <- NA
  DF$lat <- NA
  
  for (i in 1:nrow(DF)){
    # the most accurate geocode data come from searching by institution
    tmp <- geocode(DF$Institution[i],
                   output = "latlon",
                   source = "dsk")
    DF$lng[i] <- tmp$lon
    DF$lat[i] <- tmp$lat
    
    # sometimes dsk does not recognize the institution. Use city/country in these cases
    if (is.na(DF$lng[i])){
      tmp <- geocode(DF$`Map Info`[i],
                     output = "latlon",
                     source = "dsk")
      DF$lng[i] <- tmp$lon
      DF$lat[i] <- tmp$lat
      }
  }
  
  write.csv(DF, file = "psa.comm.data.csv")
  rm(DF, tmp, i, update)
}

#----
# Launch Shiny app!
rsconnect::deployApp("C:/Users/Nick/OneDrive - University of Tennessee/Research/projects/accel/shiny_map",
                     appName = "PSA_Map_Prototype")