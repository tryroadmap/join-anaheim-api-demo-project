# ---
# title: "R Notebook"
# output: html_notebook
# ---

library(ggplot2)
library(lubridate)
# library(plyr)
library(dplyr)
library(scales)
library(readr)
library(zoo)



# Preparing the Tempreture and Ambient Tempreture Data

rawtempdata <- read_csv("tempatemp.csv")
rawtime <- read_csv('SuccessfulPOSRawHan.csv')

cat("the temp columns is updated successfully.")


# #Use excel or R or anyother tool. Output should be csv file. You can use this template. 
# workday = 1 for Mon-Fri and for Sat and Sun it is 0. holiday = 1 for Sat. & Sun. 
# everyweek and New Year's day, MLK, Inauguration, Washington BD and Christman and Easter 
# Otherwise holiday=0


clean_the_data <- function(){
  
  # #in the 3rd column start from top. read the date. remember the temp. 
  # #parse the year, month, day and the hour keep them in x5, x6, x7 and x8
  # #2294
  # for (i in 1:2294){
  #   tempday<- rawtempdata[i,3]$`Date/Time`
  #   tempvalue <- rawtempdata[i,4]$`TT001_Ambient Temperature atex skid (C100)`
  #   x <- strsplit(tempday[[1]][1], ' ' )
  #   #datestring <- format(tempday, format= "%m/%d/%y")
  #   datestring <- as.Date(x[[1]][1], "%m/%d/%y")
  #   timevar <- (x[[1]][2])
  #   timefor <- hm(as.character(timevar))
  #   
  #   yearvar <- year(datestring)
  #   monthvar <- month(datestring)
  #   dayvar <- day(datestring)
  #   
  #   hourvar <- hour(timefor)
  #   
  #   print(tempday)
  #   rawtempdata[i,5]$X5 <- yearvar
  #   rawtempdata[i,6]$X6 <-  monthvar
  #   rawtempdata[i,7]$X7 <- dayvar
  #   rawtempdata[i,8]$X8 <- hourvar
  #   
  #   
  #   print(hourvar)
  #   
  #   #filling in the atemp
  #   if(yearvar == 2016){
  #     offsetval <- 1
  #   }else{
  #     offsetval <- 12
  #   }
  # 
  #   #positionvalue <- 1 + (yearvar-2016)*somevalue + (monthvar-12)*744 + (dayvar - 3)*24 + (hourvar - 0)
  #   positionvalue <- offsetval + (yearvar-2016)*8760 + (monthvar-12)*730 + (dayvar - 3)*24 + (hourvar - 0)
  # 
  #   rawtempdata[positionvalue, 2] <- tempvalue
  #   
  # }
  # 
  # write.csv(rawtempdata[,1:2], "trainsettemp.csv")
  
  
  
  #in the 3rd column start from top. read the date. remember the temp. 
  #parse the year, month, day and the hour keep them in x5, x6, x7 and x8
  #2294
  
  # rawtempdata = rename(rawtempdata, c('X5' = 'year', 'X6' = 'month', 'X7' = 'day', 'X8' = 'hour'))
  # rawtempdata$X5 = rawtempdata
  
  # create new time columns for matching 
  rawtempdata$time1 = mdy_h(format(mdy_hm(rawtempdata$datetimehourly), '%m/%d/%y %H'))
  rawtempdata$time2 = mdy_h(format(mdy_hm(rawtempdata$`Date/Time`), '%m/%d/%y %H'))
  
  newRawData = rawtempdata %>% 
    select(datetimehourly, time1, atemp) %>% 
    left_join(select(rawtempdata, -datetimehourly, -time1, -atemp), by = c('time1' = 'time2'))
  
  # For temperature, only the last record in each time period
  newRawData = newRawData %>%
    group_by(time1) %>%
    slice(n())
  newRawData$atemp = newRawData$`TT001_Ambient Temperature atex skid (C100)`
  
  # For sales, sum of records in each time period
  newRawData$totalsale = newRawData %>%
    group_by(time1) %>%
    summarise(totalsale = sum(atemp)) %>% 
    pull(totalsale)
  
  # write.csv(newRawData[,1:2], "trainsettemp.csv")
  
  
  <!-- ###Task4: -->
    <!-- fill NAs in column 'atemp' using arithmatic progression -->
    
    trainsettemp <- read_csv("trainsettemp.csv")[,-1]
  
  trainsettemp$atemp = na.fill(trainsettemp$atemp, "extend")
  
  write.csv(trainsettemp, "new_trainsettemp.csv")
  
  
  
  Task5:
    once the data is generated until 5/4/2017 11:00:00 PM create one month of until June 18th 2017 using the values of the last month. The values of the next month should be exactly equal to the values of the month before it (30 days before it, same hour of the day).
  
  
  #Fill in the empty data with the last value 
  #Sun Jun 18 16:46:34 EDT 2017
  startDay = as.Date('2017-05-04')
  lastDay = as.Date('2017-06-18')
  trainsettemp$date = as.Date(mdy_hm(trainsettemp$datetimehourly))
  createMonth = data.frame()
  for (i in seq(from = startDay, to = lastDay, by = 'day')){
    newRow = trainsettemp[trainsettemp$date == as.Date(i) - 30 & !is.na(trainsettemp$datetimehourly) ,]
    if (nrow(newRow) != 0) {
      newRow$datetimehourly = mdy_hm(newRow$datetimehourly) + days(30)
    }
    else  {
      newRow = createMonth[createMonth$date == as.Date(i) - 30,]
      ## createMonth has datetimehourly as format: ymd_hms
      newRow$datetimehourly = ymd_hms(newRow$datetimehourly) + days(30)
    }
    newRow$date = as.Date(newRow$datetimehourly)
    createMonth = rbind(createMonth, newRow)
  }
  
  # convert time to string?
  # format(createMonth$datetimehourly, '%y-%m-%d %H:%M')
  
  trainsettempNew = rbind(trainsettemp, createMonth)[,-1]
  
  write.csv(trainsettempNew, "complete_trainsettemp.csv")
  
  
  ###Task6
  Now, the existing R code has a bug, it doesn't exactly match the values that it reads from the tempatemp.csv file. In this task your job is to fix this matching algorithm so data in a hour of a day is put to exactly the matching hour box in the destination file. A diagram of what I mean is shown in the next image
  an action is found and its values is put in the right box for that day in another table
  
  
  matchDate = function(table1, table2){
  
  }
  
  
  
  
  
  
  
  
}
