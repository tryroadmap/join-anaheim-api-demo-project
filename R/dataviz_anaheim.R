print("data vis funtions loaded successfully.")
rm(list=ls())

library(ggplot2)
library(lubridate)
library(scales)
library(plyr)
library(readr)



#load from workspace
storage_train <- read_csv("../data/hoofar_raj/storage_parsed.csv")
pos_data_tidy <- read_csv("../data/hoofar_raj/pos_parsed.csv")
 

dataDF = mutate(pos_data_tidy)
train = mutate(pos_data_tidy)
attach(storage_train)
attach(pos_data_tidy)




getBasicStats <- function(dfobject){
  # Write some basic stats to the log
  cat("Number of training rows ", nrow(dfobject), "\n")
  #cat("Number of test rows ", nrow(test), "\n")
  head(dfobject)
  
}


#=======================================

getBasicStats(storage_train)
getBasicStats(pos_data_tidy)





#=======================================



getGgplotsPOS <- function(){
  dataDF$times <- dataDF$timedatepos
  dataDF$jitter_times <- dataDF$times  #+  minutes(round(as.numeric(nrow(dataDF$min_col))))
  #dataDF$day <- wday(dataDF$day_col, label=TRUE)
  dataDF$temp_f <- dataDF$atemX
  # Tweak these to show something else on the axes
  x_axis <- "jitter_times"
  y_axis <- "pumps"
  color  <- "temp_f" # for example swap this to something else 
  p <-  #tryCatch(
            ggplot(dataDF[dataDF$workday==1,], aes_string(x=x_axis, y=y_axis, color=color)) +
            geom_point(position=position_jitter(w=0.1, h=0.4)) +
            theme_light(base_size=10) +
            xlab("Hour of the Day") +
            scale_x_datetime(breaks = date_breaks("4 hours")) + 
            ylab("Number of H2 Charges") +
            scale_colour_gradientn("Temp (°F)", colours=c("#5e4fa2", "#3288bd", "#66c2a5", "#abdda4", "#e6f598", "#fee08b", "#fdae61", "#f46d43", "#d53e4f", "#9e0142")) +
            ggtitle("On workdays, most charges on warm mornings and evenings\n") +
            theme(plot.title=element_text(size=8))
        #), error=function(e) cat("ggplot is missing Missing column names but the plot is generated.")
  ggsave("../data/output/cars_h2_pumps_time_and_temperature.png", p)
  cat("files printed. \nUnncessary files deleted from memory.")
}

#getGgplotsPOS()
 


doWeatherAnalysis <- function(){
  #to better interprate the plots
  train$section  <- factor(train$section, labels = c("First", "Second", "third", "fourth"))
  train$weatherfactors <- factor(train$weathertype, labels = c("Good", "Normal", "Bad", "Very Bad"))
  
  
  
  
  season_summary <- ddply(train,.(section,hour_col),
                          summarise, pumps = mean(pumps))
  
  
  ggplot(train, aes(x = hour_col, y = pumps, colour = section)) +
    geom_point(data = season_summary, aes(group = section)) +
    geom_line(data = season_summary, aes(group = section)) +
    scale_x_discrete("Hour") +
    scale_y_continuous("H2 Pumps hourly") +
    theme_minimal() +
    ggtitle("More sales during the 2nd and 3rd section of the day, and much less in the First\n") + 
    theme(plot.title=element_text(size=18))
  
  #weather will be very important in TX based stations 
  weather_summary <- ddply(train,.(weatherfactors,hour_col),
                           summarise, pumps = mean(pumps))
  ggplot(train, aes(x = hour_col, y = pumps, colour = weatherfactors)) +
    geom_point(data = weather_summary, aes(group = weatherfactors)) +
    geom_line(data = weather_summary, aes(group = weatherfactors)) +
    scale_x_discrete("Hour") +
    scale_y_continuous("Pumps Per Hour Counts") +
    theme_minimal() +
    ggtitle("More H2 sales are done during clear weather.\n") + 
    theme(plot.title=element_text(size=18))
  
  
  day_summary <- ddply(train,.(day_col,hour_col),
                       summarise, pumps = mean(pumps))
  
  
  
  
  ggplot(train, aes(x = hour_col, y = pumps, colour = workday)) +
    geom_point(data = day_summary, aes(group=workday)) +
    geom_line(data = day_summary, aes(group=workday)) +
    scale_x_discrete("Hour") +
    scale_y_continuous("H2 Pumps by the Hour") +
    theme_minimal() +
    ggtitle("H2 charging during the morning/evening commutes to or from work on weekdays,
            and daytime H2 Charging on weekends\n")
  
  
  
  #================PART TWO =======================
  
  weather_prob <- ddply(train,.(section, hour),
                        summarise, Good = mean(weatherX == "Good"),
                        Normal = mean(weatherX == "Normal"),
                        Bad = mean(weatherX == "Bad"),
                        Very_bad = mean(weatherX == "Very Bad"))
  
  
  ggplot(train, aes(x = hour_col, y = Good, colour = section)) +
    geom_point(data = weather_prob, aes(group = section)) +
    geom_line(data = weather_prob, aes(group = section)) +
    scale_x_discrete("Hour") +
    scale_y_continuous("Prob Distribution of Good Weather Conditions") +
    theme_minimal() +
    ggtitle("higher probability of Good weather condition. \n") + 
    theme(plot.title=element_text(size=18))
  
  ggplot(train, aes(x = hour_col, y = Normal, colour = section)) +
    geom_point(data = weather_prob, aes(group = section)) +
    geom_line(data = weather_prob, aes(group = section)) +
    scale_x_discrete("Hour") +
    scale_y_continuous("Prob of Normal") +
    theme_minimal() +
    ggtitle("The distibution of Normal weather in this Data. \n") + 
    theme(plot.title=element_text(size=18))
  
  ggplot(train, aes(x = hour_col, y = Bad, colour = section)) +
    geom_point(data = weather_prob, aes(group = section)) +
    geom_line(data = weather_prob, aes(group = section)) +
    scale_x_discrete("Hour") +
    scale_y_continuous("Prob of Bad") +
    theme_minimal() +
    ggtitle("Not significant probability of Bad weather in Spring and Winter. \n") + 
    theme(plot.title=element_text(size=18))
  
  
}

#doWeatherAnalysis()

# 
# > season_summary
# section hour_col     pumps
# 1    First        5 0.4242424
# 2    First        6 0.4595960
# 3    First        7 0.4343434
# 4    First        8 0.5505051
# 5    First        9 0.5656566
# 6    First       10 0.7171717
# 7   Second       11 0.8535354
# 8   Second       12 0.7575758
# 9   Second       13 0.6212121
# 10  Second       14 0.5909091
# 11   third       15 0.6010101
# 12   third       16 0.5959596
# 13   third       17 0.5101010
# 14   third       18 0.5909091
# 15   third       19 0.5252525
# 16   third       20 0.5707071
# 17   third       21 0.6666667
# 18  fourth        0 0.6212121
# 19  fourth        1 0.5000000
# 20  fourth        2 0.6700508
# 21  fourth        3 0.4816754
# 22  fourth        4 0.3711340
# 23  fourth       22 0.5202020
# 24  fourth       23 0.6262626

 

