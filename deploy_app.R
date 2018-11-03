#----
# Load packages (install first if necessary)
# Note: make sure running v2.7 of ggmap. 
# If not, run following code: devtools::install_github("dkahle/ggmap")
library("rsconnect")
library("googlesheets")
library("ggmap")

#----
# Update data if necessary
# READ ME: Shiny cannot pull geocoded data quick enough.
#          So the data is saved in a csv read by the app.
#          If the data in the csv are out-of-date (i.e., there are new PSA members)
#          The coder can uncomment the next line of code to update the csv.
#          Right now, the function requires my Google API key to work.
#          To test without key:
#          1. comment out the "register google function"
#          2. in the geocode function, change source argument to "dsk"

# update <- "yes"
if (update == "no"){
  # Load new data from Google Sheets
  # note: R will ask user to sign into their linked Google Drive profile
  DF.MEMB <- gs_read(ss = gs_title("Official List of Members of the Psychological Science Accelerator"),
                     na.rm = "N/A")
  
  # limit dataframe to one observation per lab
    ## create new vector that contains all the names in each lab
    names <- group_by(DF.MEMB, `LAB ID`) %>%
      summarise(Names = paste0(paste(`First Name`, `Last Name`), 
                               collapse = "; "))
    
    ## delete duplicate entries for each lab
    DF.LAB <- DF.MEMB[!duplicated(DF.MEMB$`LAB ID`), ]
    
    ## merge lab dataframe with  list of names
    DF.LAB <- merge(x = DF.LAB, y = names, by = "LAB ID")
    
    ## delete vestigial
    rm(names)
    
  # Geocode each PSA lab
  register_google(key = "PASTE GOOGLE API KEY HERE") #  to test, comment out this line
  tmp <- geocode(location = paste0(DF.LAB$Institution, ",", 
                                   DF.LAB$`Map Info`),
                 output = "latlon",
                 source = "google") #  to test, change this argument to "dsk"
  DF.LAB$lng <- tmp$lon
  DF.LAB$lat <- tmp$lat
  
  # write csv
  write.csv(DF.LAB, file = "psa.comm.data.csv")
  rm(DF.MEMB, DF.LAB, tmp, update)
}

#----
# Launch Shiny app!
rsconnect::deployApp("C:/Users/Nick/OneDrive - University of Tennessee/Research/projects/psa/PSA_map",
                     appName = "PSA_Map_Prototype")