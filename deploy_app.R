library("rsconnect")
library("googlesheets")
library("ggmap")

#----
# Prompt user to update data
# Note: Shiny cannot handle pull geolocation data quick enough.
#       So the data called in the app is saved in a csv before running.
#       If the user tells R the data are out-of-date, they will be updated here
update <- readline("Would you like to update the PSA network list? (Y/N)")

if (update == "Y"){
  # Load new data from Google Sheets
  # note: R will ask user to sign into their linked Google Drive profile
  # Note: google is working, but hitting query limits
  DF <- gs_read(ss = gs_title("Members of the Psychological Science Accelerator"),
                na.rm = "N/A")
  
  # Extract geolocation data using geocode function
  # note: source set to dsk to avoid Google API query limits
  DF.ll <- geocode(location = paste(DF$Institution, DF$`Map Info`, sep = ", "), 
                   output = "latlon",
                   source = "google",
                   override_limit = TRUE)
  DF$lng <- DF.ll$lon  #  longitude
  DF$lat <- DF.ll$lat  #  latitude
  rm(DF.ll)
   
  write.csv(DF, file = "psa.comm.data.csv")
}


#----
# Launch Shiny app!
rsconnect::deployApp("C:/Users/Nick/OneDrive - University of Tennessee/Research/projects/accel/shiny_map",
                     appName = "PSA_Map_Prototype")