# PSA_map
Code for a generating a world map of the Psychological Science Accelerator community.

To get started:
- Download all files and save to a single folder.
- app.R contains the code for building the Shiny app
- deploy_app.R contains the code for updating the locally stored list of labs (psa.comm.data.csv) using openly available geolocation services
- the 'www' folder contains the PSA logo

## notes on deploy_app.R
- Most people probably do not need to look at this app. The [outdated] data needed to test the app are in psa.comm.data.csv
- This code uses the googlesheet package to pull data on the participating labs.
- For the data to successfully write, you will (a) need to give R access to your Google account (it will ask), and (b) have access to the Google Sheet that it pulls from.

If you have any questions, you can contact me Nick via Slack, Twitter (@coles_nicholas_) or email (colesn @ vols.utk.edu)
