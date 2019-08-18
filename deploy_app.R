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

# Load new data from Google Sheets
# note: R will ask user to sign into their linked Google Drive profile
DF.VIEWING <- gs_read(ss = gs_title("data-shiny"),
                     na.rm = "N/A")
  
  
# Geocode each viewing sites
register_google(key = "AUTH_TOKEN") #  to test, comment out this line
tmp <- geocode(location = paste0(DF.VIEWING$`universitas`, ",", 
                                   DF.VIEWING$`mapinfo`),
                 output = "latlon",
                 source = "google") #  to test, change this argument to "dsk"
DF.VIEWING$lng <- tmp$lon
DF.VIEWING$lat <- tmp$lat
  
# write csv
write.csv(DF.VIEWING, file = "webinar.viewing.data.csv")
rm(DF.VIEWING, tmp)

#----
# Launch Shiny app!
rsconnect::deployApp("D:/Drive/SainsTerbukaUA/IDN_OS_Webinar/webinarsains_map",
                    appName = "viewing_sites")