#Bee Kim- Shiny visualization project

#prep ####
#Load the library
library(tidyverse)
library(ggmap)

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

