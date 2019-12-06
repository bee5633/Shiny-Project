# Shiny Project (R)

<b> Introduction </b> \
Since 2016 election, U.S. Border security has been a major subject of debate. \
Did the political agenda affect the way people enter our country in both Southern and Nothern borders? \
If not, what drives the number of Border entry to fluctuate? 

<b> Data </b> \
This data is originally collected by U.S. Customs and Border Protection (CBP) every quarter. \
Then it gets cleaned, assessed and maintained by the Bureau of Transportation Statistics (BTS). \
It contains the statisics for inbound crossings at the U.S.-Canada and the U.S.-Mexico border at the port level for every month from the beginning of 1996. \
The original dataset of 40MB includes 349,000 rows with 7 columns, classified as follows: Port Name, State, Port Code, Border, Date, Measure, Value and Location. 

 -note : important to be aware that this dataset doesn't count the number of unique vehicles, passengers or pedestrians but rather the number of crossing. Meaning, the same truck can go back and forth across the border several times a day and data for each time will be collected. 

<b> R packages used </b> \
dplyr: to clean the data
  Boder Name changed : U.S.-Canada Border -> Canada
                       U.S.-Mexico Border -> Mexico
  Location divided in two sections : Longitude and Latitude
ggplot2 and leaflet : EDA
shiny : dashboard for presentation

