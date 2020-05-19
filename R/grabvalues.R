grabvalues <- function(inputedate){
  if (is.POSIXct(inputedate)){
    lookupdate = inputedate
  }else{
    lookupdate = as.POSIXct(inputedate)
  }
  year = year(lookupdate)
  month= month(lookupdate)
  day= day(lookupdate)
  hour= hour(lookupdate)

  # cat("year: ", year , "|")
  # cat("month: ", month, "|")
  # cat("day: " ,day ,"|")
  # cat("hour: " ,hour , "|")
  matchingkey =  c(year, month, day, hour) #later this method can be optimized for faster performance
}