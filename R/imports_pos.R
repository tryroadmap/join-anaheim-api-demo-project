import_pos <- function(){
    #all activities about retriving, loading and filtering the pos data is done here.
    #The generated dataframes are attached as global variables.
    
    #import the storage files
fileaddress <- "../data/hoofar_raj/tidydata.csv"
pos_data <- read_csv(fileaddress)
head(pos_data)


#check the columns or re-write for better clarity and compactness for both tables before merge according to the documentaion /data/README.md
names(pos_data)
#-----------------------------------------

library(lubridate)
library(readr)

testVariables <- function(samplelist){
  #check for stratosample to see types and values of the data
  pos_data$pumps[samplelist]
  pos_data$section[samplelist]
  pos_data$holiday[samplelist]
  pos_data$weathertype[samplelist]
  pos_data$atemp[samplelist]
  pos_data$atemX[samplelist]
  pos_data$totalsales[samplelist]
  pos_data$quantity[samplelist]
  pos_data$newcustomer[samplelist]
  pos_data$returningcustomer[samplelist]
  pos_data$day.rushhour[samplelist]
  pos_data$day.rushhour.pumps[samplelist]
  
}

#to test method
samplelist <- c(1:2)
pos_data$datetimehourly[samplelist]
pos_data$pumps[samplelist]
pos_data$section[samplelist]
pos_data$holiday[samplelist]
pos_data$weathertype[samplelist]
pos_data$atemp[samplelist]
pos_data$atemX[samplelist]
pos_data$totalsales[samplelist]
pos_data$quantity[samplelist]
pos_data$newcustomer[samplelist]
pos_data$returningcustomer[samplelist]
pos_data$day.rushhour[samplelist]
pos_data$day.rushhour.pumps[samplelist]


#buildDateColumns <- function(rawhourlycolumndata, dataframeobj){}

pos_datastring <- as.character(pos_data$datetimehourly, stringsAsFactors=FALSE)  
timedatepos <- mdy_hm(pos_datastring)

#to better search parse them sepeerately 
day_col <- day(timedatepos)
month_col <- month(timedatepos)
year_col <- year(timedatepos)
second_col <- second(timedatepos)
min_col <- minute(timedatepos)
hour_col <- hour(timedatepos)
pos_parsed <- cbind(pos_data, timedatepos, day_col, month_col, year_col, second_col , min_col, hour_col)  

updateRushHour<- function(){
  #uses other R scripts in R/
  cat("\nPOS data for day.rushhour is updated.")
}



updateRushHourPumps<- function(){
  #uses other R scripts in R/
  cat("\nPOS data for day.rushhour.pumps is updated.")
}


updateDeliveryExpected<- function(){
  #in how many hours based on the existing storage and the expected average use we need a delivery.
  #uses other R scripts in R/
  cat("\nPOS data for day.delivery.expected is updated.")
}


updateDeliveryExpectedAccuracy<- function(){
  #uses other R scripts in R/
  cat("\nPOS data for day.delivery.expected.accuracy is updated.")
}


updateAverageDayCons<- function(){
  #uses other R scripts in R/
  cat("\nPOS data for day.consump.ave is updated.")
}


updateRushHour()
updateRushHourPumps()
updateDeliveryExpected()
updateDeliveryExpectedAccuracy()
updateAverageDayCons()

#merge both dataframes
#save and export the sorted table
export_filename = "pos_parsed.csv"
export_address = "../data/hoofar_raj/"


write.csv( pos_parsed, file = export_filename)
attach(pos_parsed)
cat("\nPOS data is loaded successfully!")

#===================================
#Prepare Training set and testing set for RF model.
#===================================
#four ops: filter, transform, agrigate, sort

createposfiles <- function(){
  cutoff = 0.8
  obscount = dim(pos_parsed)[1]*cutoff
  postrain <-  pos_parsed[1:obscount, ]
   
  write.csv( postrain, file = "trainpos.csv")
  cat("\ntrain data is created successfully!")
  postest <- pos_parsed[-(1:obscount), ]
  write.csv( postest, file="testpos.csv")
  if (sum(dim(postrain)[1], dim(postest)[1]) == dim(pos_parsed)[1]){
    cat("\ntest data is created successfully!")  
  }
}
createposfiles()

}
