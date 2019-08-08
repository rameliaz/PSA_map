# Indonesian Science Webinar 2019 Viewing Sites Map
Code for a generating an Indonesia map of the Indonesian Science Webinar 2019 viewing sites. We made this map to provide information to people who need to know the nearest viewing site to them.

In this repo, we have:
- app.R contains the code for building the Shiny app
- deploy_app.R contains the code for updating the locally stored list of labs (webinar.viewing.data.csv) using openly available geolocation services
- the 'image' folder contains the suporting organisations logo

## notes on deploy_app.R
- Most people probably do not need to look at this app. The [outdated] data needed to test the app are in webinar.viewing.data.csv
- This code uses the googlesheet package to pull data on the viweing sites.
- For the data to successfully write, you will (a) need to give R access to your Google account (it will ask), and (b) have access to the Google Sheet that it pulls from.

We sincerely thank Nicholas Coles as we forked his [PSA map repo](https://github.com/ColesNicholas/PSA_map) and we then modified it for Indonesian Science Webinar 2019.
