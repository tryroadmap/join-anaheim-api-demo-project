#This is a wrapper for sourcing all other packages. This file should run first after git clone from the repo. Read README.md for more. 
#FORMAT
    #//anaheim(Date)
    #Expected number of cars to use the station at this hour: e.g. 2
    #Expected Rush Hour(s) for this hour(date): e.g. 6:00 PM
    #Expected number of cars to use the station at the rush hour: e.g. 4 cars
    #Required next hydrogen delivery based on the Storage available: e.g. 4:00 AM (%Likelihood of #correctness)
    #Average Consumption per car until "Date": e.g. 2 kg


#-----------
#fetch files
#-----------
rm(list=ls())
options(warn=-1) #should be switched back on after api testing.
#to avoid error set working directory 
fixDirectory <- function(){
  tryCatch({
    if (getwd() != "./R"){
      setwd("./R")
    }else cat("Make sure you are the /R directory when launching devtools::load_all()")
  }, error=function(e) cat("Launching anaheim from ./R")
  )
}

fixDirectory()
cat("\nCurrently at: " , getwd())
cat("\n")
source("loadAnaheimPackages.R")
source("getAllFiles.R")
getAllFiles()

#-------------------------------
#loads in data into dataframes
#-------------------------------
source("import_storage.R")
import_storage()
source("imports_pos.R")
import_pos()
source("dataviz_anaheim.R")   


anaheim  <- function(stationname="anaheim", date= now()){
  #----------------
  #inputs:
  #----------------
  #stationname: name of the station- can be later scaled to using more stations- data structure should be clearly similar.
  #date: date selected default value is today, this hour
  #default station name set to anaheim and default date to current time and date.
  #input date format YYYY-MM-DD HH:MM ("2016-12-03 11:00")
  source("grabvalues.R")
  print(date)
  mvals = grabvalues(date)
  source("getMatchingids.R")
  lookupid = getMatchingids(mvals[1], mvals[2], mvals[3], mvals[4]) #very easy to extend depending on required accu.
  #----------------
  #Interface 
  #----------------
  #re-write and rewired
  pumps <- pos_data_tidy$pumps[lookupid]
  day.rushhour <- pos_data_tidy$day.rushhour[lookupid]   
  day.rushhour.pumps <- pos_data_tidy$day.rushhour.pumps[lookupid]   
  day.delivery.expected <- pos_data_tidy$day.delivery.expected[lookupid]   
  day.delivery.expected.accuracy <- pos_data_tidy$day.delivery.expected.accuracy[lookupid]  
  day.consump.ave <- pos_data_tidy$day.consump.ave[lookupid]   
  
  #----------------
  #Return
  #----------------
  api_out = cat(paste0("Expected number of cars to use the ",stationname ," station at ", as.character(date) ,": ", pumps, " cars",
    "\nExpected Rush Hour(s) for ", as.character(date) , " at ",  stationname ," station: ",day.rushhour,
    "\nExpected number of cars to use ", stationname , " station at ",day.rushhour,": ", day.rushhour.pumps, " cars",
    "\nRequired next hydrogen delivery based on the Storage data available: ", day.delivery.expected," with Prediction Accuracy: ", day.delivery.expected.accuracy,"%",
    "\nExpected Average Consumption: ", day.consump.ave ," kg\n")) #simplified text on the last line
  }

#hard test
anaheim(stationname="anaheim", date="2016-12-03 11:00")


#----------------
#AWS setup Innitialization
#----------------
# To better set up AWS same env. should be regenerated. These are the available R packages in our Scripts environment:
paste0(installed.packages()[,"Package"], "-", installed.packages()[,"Version"])


#----------------
#API calls to anaheim
#----------------
cat("\nEverything succesfully loaded and test. \nPlease allow the API to run on your server for anaheim package...\n")
library(plumber)
r <- plumb("apiAnaheim.R")
r$run(port=8000)

