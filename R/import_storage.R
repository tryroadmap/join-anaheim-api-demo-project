import_storage <- function(){
      #all activities about retriving, loading and filtering the storage data is done here.
      #The generated dataframes are attached as global variables.
      
      #import the storage files
fileaddress <- "../data/hoofar_raj/STORAGE_01.txt"
storage_01 <- read.table(fileaddress, header=TRUE, sep = "\t")
head(storage_01)

fileaddress <- "../data/hoofar_raj/STORAGE_02.txt"
storage_02 <- read.table(fileaddress, header=TRUE, sep = "\t")
head(storage_02)

#re-write the columns for better clarity and compactness for both tables before merge according to the documentaion /data/README.md
names(storage_01)
names(storage_01) <- c("datetimehour", "pt100_h2", "pt11_h2", "pt200_pressure", "pt250_pressure", "pt930_left", "pt931_right")
names(storage_02) <- names(storage_01)
#to easier normalize and better sort and faster read table create date(just the date 01/01/17) time(10:32) and hour(10:00) for every observation
storage_01df <- as.data.frame(storage_01)
storage_02df <- as.data.frame(storage_02)
#-----------------------------------------

library(lubridate)
library(readr)

#storage_01df$datetimehourly <- as.POSIXlt(storage_01df$datetimehour, tz="GMT",format="%dd/%mm/%yyyy %H:%M:%S ")
 

#buildDateColumns <- function(rawhourlycolumndata, dataframeobj){}
  
storage_01dfstring <- as.character(storage_01df$datetimehour, stringsAsFactors=FALSE)  
asDate <- dmy_hms(storage_01dfstring)
 
#to better search parse them sepeerately 
day_col <- day(asDate)
month_col <- month(asDate)
year_col <- year(asDate)
second_col <- second(asDate)
min_col <- minute(asDate)
hour_col <- hour(asDate)
storage_parsed_01 <- cbind(storage_01df, asDate, day_col, month_col, year_col, second_col , min_col, hour_col)  

  
buildDateColumns <- function(hourlydatecol, dataframeobj){
    storage_01dfstring <- as.character(dataframeobj$hourlydatecol, stringsAsFactors=FALSE)  
    asDate <- dmy_hms(storage_01dfstring)
    #to better search parse them sepeerately 
    day_col <- day(asDate)
    month_col <- month(asDate)
    year_col <- year(asDate)
    second_col <- second(asDate)
    min_col <- minute(asDate)
    hour_col <- hour(asDate)
    storage_parsed <- cbind(storage_export, asDate, day_col, month_col, year_col, second_col , min_col, hour_col)  
    return(storage_parsed)
}



#buildDateColumns(storage_01df$datetimehour, storage_01df)
#merge both dataframes
#save and export the sorted table
export_filename = "storage_parsed.csv"
export_address = "./data/hoofar_raj/"
write.csv( storage_parsed_01, file = export_filename)


tag_for_delivery <- function(){
  
  # LP < 34 bar is not usable.
  # MP < 200 bar is not usable.
  # HP < 640 bar is not usable.
  cat("succussfully tagged for delivery.")
}


}