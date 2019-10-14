#Bee Kim- Shiny visualization project

#prep ####
#Load the library
library(tidyverse)
library(ggmap)
library(tmap)
library(leaflet)
library(mapview)
library(sf)
library(spData)

#load the data
border = read.csv("./Border_Crossing_Entry_Data.csv")

#check the data
view(border)
str(border)

#clean the data ####
#check if there is any missing values
length(border[is.na(border)])   # no missing value

#check different levels of Border column
unique(border$Border)
#shorten these to "Canada" and "Mexico"
border <- border %>% 
  mutate(Border=gsub(pattern = "US-Canada Border", replacement="Canada", x=Border, ignore.case = F, fixed = T)) %>%
  mutate(Border=gsub(pattern = "US-Mexico Border", replacement="Mexico", x=Border, ignore.case = F, fixed = T))

#Date only matters for month and year. so change the format to month and year only
#change class of Date column to date
border <- border %>% 
  mutate(Date=as.Date(Date, "%m/%d/%Y %H:%M:%S %p"))

#check the class of changed date column
class(border$Date)

#make new columns for month and year
border <- border %>%
  mutate(Month =as.numeric(format(Date,"%m"))) %>% 
  mutate(Year =as.numeric(format(Date, "%Y")))

#see how many unique values in Measure column
unique(border$Measure)
#trucks, trains, bus passengers, rail containers empty, buses, pedestrians, rail containers full, personal vehicle passengers,
#truck containers empty, personal vehicles, truck contrainers full, train passengers

#class of location column
class(border$Location)

#change the factor class of location column to geospatial location
border1 <- border 
border1 <- border1 %>% 
  mutate(m = gsub("POINT ","", as.character(Location))) %>%
  mutate(m = gsub("[()]", "", as.character(m)))
border1$m[1]
border2 <- border1 %>% 
  separate(m, c("Longitude", "Latitude"),sep=" ")
border2

#cleaned dataset
view(border2)

#export the data
write.csv(border2, file="border2.csv", row.names=FALSE)

#get rid of some columns that we don't need
borderF = border2 %>% 
  select(Border,Port.Name,Port.Code,State,Measure,Value,Month,Year,Longitude,Latitude) %>% 
  filter(Year<2019)

view(borderF)

#export the final data
write.csv(borderF, file="borderF.csv", row.names=FALSE)

#exploratory data analysis ####
#1. Total number of border ####
view(borderF)
length(unique(borderF$Port.Name))

#2. Number of border by Border ####
borderF %>% 
  group_by(Border) %>% 
  summarise(NumberPort = n_distinct(Port.Name)) %>% 
  ggplot(aes(Border, NumberPort)) + geom_col()

borderF %>% filter(Border=="Canada")

sum(borderF %>% filter(Border =="Canada") %>%  summarise(n_distinct(Port.Name)))

borderCanada = borderF %>% filter(Border =="Canada")



#3. By Year and Border. How many passings ####
border3=borderF %>% 
  group_by(Border, Year) %>% 
  summarise(total_3 = sum(Value))
view(border3)
colnames(border3)
ggplot(data=border3, aes(Year, total_3)) + geom_col(aes(fill=border3$Border), position='dodge')


#4. By month and Border. How many passings. ####
border4 = borderF %>% 
  group_by(Border, Month) %>% 
  summarise(sum(Value))
view(border4)
ggplot(data=border4, aes(border4$Month, border4$`sum(Value)`)) + geom_col(aes(fill=border4$Border), position='dodge')

#5. By state. How many passings. ####
border5 = borderF %>% 
  group_by(State) %>% 
  summarise(sumV = sum(as.numeric(Value))) %>% 
  arrange(desc(sumV)) 
view(border5)
ggplot(data=border5, aes(border5$State, border5$sumV)) + geom_col(aes())

#6. by measure and border. -> what type of coming in ####
border6 = borderF %>% 
  group_by(Measure, Border) %>% 
  summarise(sumV = sum(as.numeric(Value))) %>% 
  arrange(desc(sumV))
view(border6)



 CanadaIncoming = borderF %>% 
   filter(Border == "Canada") %>% 
   summarise(sum(as.numeric(Value)))
 CanadaIncoming
    
 MexicoIncoming = borderF %>% 
   filter(Border == "Mexico") %>% 
   summarise(sum(as.numeric(Value)))
 MexicoIncoming
 
 
 #7. map ####

borderPortLongLat = borderF %>% 
  select(Port.Name,Longitude,Latitude) %>% 
  group_by(Port.Name) %>% 
  mutate(Longitude=mean(Longitude), Latitude=mean(Latitude))
  
unique(borderF$Port.Name)


leaflet_border = leaflet() %>% 
  addTiles() %>% 
  addCircles(~Longitude, ~Latitude)


colnames(borderF)

bNorthD=borderF %>% 
  group_by(State, Measure) %>% 
  filter(State == "North Dakota") %>%
  ggplot(aes(x=Measure)) + geom_bar(fill ='light blue') + 
  labs(title="Modes of Transportation by Different States",x="Modes of Transportation", y="Count") + 
  theme(axis.text.x=element_text(angle=90))

bNorthD$Measure

bTexas=borderF %>% 
  filter(State == "Texas") %>%
  select(State, Measure, Value) %>% 
  group_by(State, Measure) %>%
  mutate(MeasureSum = sum(Value))

borderF %>% 
  filter(State=="North Dakota")
         
bTexas$MeasureSum
         
?

