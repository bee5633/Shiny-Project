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
  Boder Name changed : "U.S.-Canada Border" -> "Canada", "U.S.-Mexico Border" -> "Mexico"
  Location divided in two sections : Longitude and Latitude \
ggplot2 and leaflet : EDA \
shiny : dashboard for presentation

<b> Analysis </b> \
Ports \
There are a total of 116 ports in this dataset. Among those, 89 ports are in Canada Border and 27 ports are in Mexico Border. So there are about 3 times more ports in Canada Border compared to the Mexico Border. 

Total Incomings \
Compared to the number of ports, the number of total incomings from 1996 to 2018 showed total opposite as there were about 7 billions of total border crossing at Mexico Border while there were about 2.6 billions of total border crossing at the Canada Border. Even though there were more ports available in the northern border of U.S., there were fewer people coming in. 

Border Entry Methods \
Overall, most of the border entry was done in personal vehicles. The next highest value was surprisingly Pedestrians. When the measure(mode of transportation) was compared between two borders, there was a visible difference where the Mexico Border has a significant number of pedestrians whereas the Canada Border does not. 

Number of Border Entry \
When I looked into the change in number of truck entering the U.S. at Canada and Mexico Borders, both had a sudden drop of number in the year 2009. That was the year of global financial crisis. Trucks can be used for in-land trades and it is obvious from the graph above that the economy has a big impact on the border entry. Also, I was able to see the increase in the number of trucks entering at the Mexican border across the years, possibly suggesting a better state of trade between the U.S. and Mexico. 

As I wanted to see the impact of the 2016 election, I looked at the number of Pedestrians and Personal Vehicle Passengers over the years at Mexican Border. Originally, I expected to see the decrease in number as there was a lot of political conflict going on, however the statistics show the increase in border entry. 

The number of incoming buses and bus passengers into the U.S. seem to be decreasing on both Canada and Mexico sides. Usually buses transport tourists, but as other methods of traveling such as flight and train have advanced and cheaper over the years, use of bus as a method for traveling seems to have declined. 

Two methods of transportation used for border entry that look distinctly different were Pedestrian and Train Passengers. As seen in previous graphs, most of the pedestrians are coming into the U.S. from Mexico because it is easier to walk across the border in the southern side of the States. A train is used more often to enter from Canada, and the number of its use has been increasing. This increase in the use of trains can be related to the decreasing use of buses. 

The data shows that there is no distinction in transportation methods used for trade such as Truck, Truck Container Full, Rail Container Full observable according to the month of the year. These seem to have a steady number of incoming from both Mexico and Canada borders, no matter what month it is. This indicates that the business related border entry stays steady in all-year-around. 

However this changes when it comes to the transportation related to traveling such as Personal Vehicle Passengers, Bus Passengers and Train Passengers. Number of border entry in US-Canada increases significantly in summer months, while number of border entry in US-Mexico stays around same all-year-around. As the northern border get a harsh cold winter, it makes sense more people would opt to travel in the summer months. 

<b> Conclusion </b> \
From the visualization and statistics, the number of border entry depends on the economy and business rather on the political climate. However this dataset itself can't explain the reason behind the change in number of border entry as there are still many factors that need to be considered. For further research, I would like to obtain the data regarding the citizenship of people that enter the U.S. borders as well as their intention or the reason for the entry. This can further support how the economy or tourism affect the trend in the border entry.
