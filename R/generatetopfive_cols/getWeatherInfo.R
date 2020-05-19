#https://github.com/ALShum/rwunderground
#http://lotustech.io/anaheim
install.packages("rwunderground" , dependencies = TRUE)
library("rwunderground")
rwunderground::set_api_key("0955ce6eae311819")
almanac(set_location(zip_code = "92804"))
weather_date= history_range(set_location(zip_code = "92804"), date_start ="20161202", date_end = "20170730") #30 min with freee API
write.csv(weather_date,"weather_data_raw_.csv")
